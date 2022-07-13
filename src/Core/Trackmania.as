#if TMNEXT
namespace Trackmania
{
    const float MinimumFrontSpeed = 10.f;
    const float MaximumFrontSpeed = 275.f;
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
        return currentFov != setFov || Setting_FOV != FieldOfView::Default || Setting_Wipeout || Setting_QuickZoom != QuickZoom::Disabled;
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
                if (Setting_QuickZoom == QuickZoom::Simple) {
                    setFov = Setting_QuickZoomAmount;
                } else if (Setting_FOV != FieldOfView::Default) {
                    if (Setting_Wipeout && visState !is null) {
                        setFov = (((Math::Clamp(visState.FrontSpeed, Trackmania::MinimumFrontSpeed, Trackmania::MaximumFrontSpeed) - Trackmania::MinimumFrontSpeed) * (Setting_WipeoutMax - Setting_FOVAmount)) / (Trackmania::MaximumFrontSpeed - Trackmania::MinimumFrontSpeed)) + Setting_FOVAmount;
                    } else {
                        setFov = Setting_FOVAmount;
                    }
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
        if (Setting_QuickZoomShortcut != Shortcut::Disabled && key == Setting_QuickZoomShortcutKey) {
            if (Setting_QuickZoomShortcut == Shortcut::Hold) {
                Setting_QuickZoom = down ? QuickZoom::Simple : QuickZoom::Disabled;
                return UI::InputBlocking::DoNothing;
            }
            else if(Setting_QuickZoomShortcut == Shortcut::Toggle && down) {
                Setting_QuickZoom = Setting_QuickZoom == QuickZoom::Simple ? QuickZoom::Disabled : QuickZoom::Simple;
                return UI::InputBlocking::Block;
            }
        }
        return UI::InputBlocking::DoNothing;
    }
}
#endif