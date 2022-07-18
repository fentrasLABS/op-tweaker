#if TMNEXT
namespace Trackmania
{
    const float MinimumFrontSpeed = 10.f;
    const float MaximumFrontSpeed = 275.f;

    int GetPreferredFOV() { return Setting_FOV == FieldOfView::Simple ? int(Setting_FOVAmount) : Camera::DefaultFOV; }
}

class Vendor
{
    CScene@ scene;
    CSceneVehicleVisState@ visState;
    float setFov;
    float currentFov;
}

class Mania : Game
{
    private bool IsFOVChanging()
    {
        return currentFov != setFov
            || Setting_FOV == FieldOfView::Simple
            || Setting_Wipeout
            || Setting_QuickZoom != QuickZoom::Disabled;
    }

    void AddVendorNods() override
    {
        @scene = app.GameScene.HackScene;
        @camera = view.Cameras[0];
        @clouds = cast<CSceneMobilClouds>(scene.Mobils[1]).Clouds;
        @skybox = scene.Mobils[0];
        currentFov = Setting_FOVAmount;
        setFov = currentFov;
        InitNods();
    }

    void RemoveVendorNods() override
    {
        @scene = null;
        @visState = null;
    }

    void ApplyVendorSettings() override
    {
        if (camera !is null) {
            camera.m_IsOverlay3d = Setting_RenderMode == RenderMode::Limited;
            camera.m_ViewportRatio = Setting_RatioPriority == RatioPriority::Horizontal ? CHmsCamera::EViewportRatio::FovX : CHmsCamera::EViewportRatio::FovY;
            if (Setting_FOV == FieldOfView::Advanced) {
                camera.FovRect = true;
                camera.FovRectMin = vec2(Setting_FOVRect.x, Setting_FOVRect.y);
                camera.FovRectMax = vec2(Setting_FOVRect.z, Setting_FOVRect.w);
            } else {
                camera.FovRect = false;
            }
        }
        if (scene !is null && scene.Lights.Length > 0) {
            scene.Lights[0].Light.Color = Setting_LightingCar ? Setting_LightingCarColor : vec3(defaults["Lighting Car Color"]);
            scene.Lights[0].Light.Intensity = Setting_LightingCar ? Setting_LightingCarIntensity : float(defaults["Lighting Car Intensity"]);
            scene.Lights[1].Light.Color = Setting_LightingWorld ? Setting_LightingWorldColor : vec3(defaults["Lighting World Color"]);
            scene.Lights[1].Light.Intensity = Setting_LightingWorld ? Setting_LightingWorldIntensity : float(defaults["Lighting World Intensity"]);
        }
    }

    void OverrideVendorSettings() override
    {
        if (camera !is null) {
            if (Setting_ZClip) {
                camera.FarZ = Setting_ZClipDistance;
            }
            if (Setting_AspectRatio) {
                camera.Width_Height = Setting_AspectRatioAmount;
            }
            if (IsFOVChanging()) {
                if (Setting_QuickZoomActive) {
                    if (Setting_QuickZoom == QuickZoom::Simple) {
                        setFov = Setting_QuickZoomAmount;
                    }
                } else if (Setting_Wipeout && visState !is null) {
                    setFov = (((Math::Clamp(visState.FrontSpeed, Trackmania::MinimumFrontSpeed, Trackmania::MaximumFrontSpeed) - Trackmania::MinimumFrontSpeed) * (Setting_WipeoutMax - Trackmania::GetPreferredFOV())) / (Trackmania::MaximumFrontSpeed - Trackmania::MinimumFrontSpeed)) + Trackmania::GetPreferredFOV();
                } else if (Setting_FOV == FieldOfView::Simple) {
                    setFov = Setting_FOVAmount;
                } else {
                    setFov = Camera::DefaultFOV;
                }
                camera.Fov = currentFov;
            }
        }
    }

    void VendorUpdate(float dt) override
    {
        if (initialised) {
            if (IsFOVChanging()) {
                @visState = VehicleState::ViewingPlayerState();
                if (visState !is null) {
                    currentFov = Math::Lerp(setFov, currentFov, 0.9f);
                }
            }
        }
    }

    UI::InputBlocking VendorOnKeyPress(bool down, VirtualKey key) override
    {
        // Needs refactoring to accept keys from all methods (e.g. screen resolution shortcut)
        // Move to Game.as
        bool block = false;
        if (Setting_QuickZoom != QuickZoom::Disabled && Setting_QuickZoomShortcut != Shortcut::Disabled && key == Setting_QuickZoomShortcutKey) {
            if (Setting_QuickZoomShortcut == Shortcut::Hold) {
                Setting_QuickZoomActive = down ? true : false;
            } else if (Setting_QuickZoomShortcut == Shortcut::Toggle && down) {
                Setting_QuickZoomActive = !Setting_QuickZoomActive;
                block = true;
            }
        }
        ApplySettings();
        return block ? UI::InputBlocking::Block : UI::InputBlocking::DoNothing;
    }
}
#endif