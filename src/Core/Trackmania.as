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
    bool initFov;
    float setFov;
    float currentFov;
    bool initRectFov;
    vec4 setRectFov;
    vec4 currentRectFov;
    FieldOfView currentSettingFOV;
    QuickZoom currentSettingQuickZoom;
}

class Mania : Game
{
    private bool FOVChanging()
    {
        return Math::Abs(currentFov - setFov) > 1e-4 // Thanks to NaNInf
            || Setting_Wipeout
            || Setting_FOV == FieldOfView::Simple
            || Setting_FOV != currentSettingFOV
            || Setting_QuickZoom == QuickZoom::Simple
            || Setting_QuickZoom != currentSettingQuickZoom;
    }

    private bool IsRectFOVChanging()
    {
        return Math::Abs(currentRectFov.x - setRectFov.x) > 1e-4
            || Math::Abs(currentRectFov.y - setRectFov.y) > 1e-4
            || Math::Abs(currentRectFov.z - setRectFov.z) > 1e-4
            || Math::Abs(currentRectFov.w - setRectFov.w) > 1e-4
            || Setting_FOV == FieldOfView::Advanced
            || Setting_FOV != currentSettingFOV
            || Setting_QuickZoom == QuickZoom::Advanced
            || Setting_QuickZoom != currentSettingQuickZoom;
    }

    private vec4 GetCameraFovRect(CHmsCamera@ cam)
    {
        return vec4(camera.FovRectMin.x, camera.FovRectMin.y, camera.FovRectMax.x, camera.FovRectMax.y);
    }

    void AddVendorNods() override
    {
        @scene = app.GameScene.HackScene;
        @camera = view.Cameras[0];
        @clouds = cast<CSceneMobilClouds>(scene.Mobils[1]).Clouds;
        @skybox = scene.Mobils[0];
        currentSettingFOV = Setting_FOV;
        currentSettingQuickZoom = Setting_QuickZoom;
        initFov = false;
        initRectFov = false;
        currentFov = camera.Fov;
        setFov = currentFov;
        currentRectFov = GetCameraFovRect(camera);
        setRectFov = currentRectFov;
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
            camera.ClearColor = Setting_BackgroundColor;
            camera.ClearColorEnable = !Setting_Background;
            if (IsRectFOVChanging()) {
                camera.FovRect = true;
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
            if (FOVChanging()) {
                if (!initFov) {
                    currentFov = camera.Fov;
                    initFov = true;
                }
                if (Setting_QuickZoomActive && Setting_QuickZoom == QuickZoom::Simple) {
                    setFov = Setting_QuickZoomSimpleAmount;
                } else if (Setting_Wipeout && visState !is null) {
                    setFov = (((Math::Clamp(visState.FrontSpeed, Trackmania::MinimumFrontSpeed, Trackmania::MaximumFrontSpeed) - Trackmania::MinimumFrontSpeed) * (Setting_WipeoutMax - Trackmania::GetPreferredFOV())) / (Trackmania::MaximumFrontSpeed - Trackmania::MinimumFrontSpeed)) + Trackmania::GetPreferredFOV();
                } else if (Setting_FOV == FieldOfView::Simple) {
                    setFov = Setting_FOVAmount;
                } else {
                    setFov = camera.Fov;
                }
                camera.Fov = currentFov;
            } else if (initFov) {
                initFov = false;
            }
            if (IsRectFOVChanging()) {
                if (!initRectFov) {
                    currentRectFov = GetCameraFovRect(camera);
                    initRectFov = true;
                }
                if (Setting_QuickZoomActive && Setting_QuickZoom == QuickZoom::Advanced) {
                    vec2 mousePos = UI::GetMousePos();
                    vec2 windowSize = vec2(Math::Clamp(Draw::GetWidth(), 1, 99999), Math::Clamp(Draw::GetHeight(), 1, 99999));
                    mousePos = vec2(Math::Clamp(mousePos.x, 1, windowSize.x), Math::Clamp(mousePos.y, 1, windowSize.y));
                    float calcPosX = ((mousePos.x * (Setting_QuickZoomAdvancedAmount - -Setting_QuickZoomAdvancedAmount)) / windowSize.x) + -Setting_QuickZoomAdvancedAmount;
                    float calcPosY = ((mousePos.y * (Setting_QuickZoomAdvancedAmount - -Setting_QuickZoomAdvancedAmount)) / windowSize.y) + -Setting_QuickZoomAdvancedAmount;
                    vec2 rectMin = vec2(calcPosX - Setting_QuickZoomAdvancedAmount, calcPosY - Setting_QuickZoomAdvancedAmount);
                    vec2 rectMax = vec2(calcPosX + Setting_QuickZoomAdvancedAmount, calcPosY + Setting_QuickZoomAdvancedAmount);
                    setRectFov = vec4(rectMin.x, rectMin.y, rectMax.x, rectMax.y);
                } else if (Setting_FOV == FieldOfView::Advanced) {
                    setRectFov = Setting_FOVRect;
                } else {
                    setRectFov = Camera::DefaultRectFOV;
                }
                camera.FovRectMin = vec2(currentRectFov.x, currentRectFov.y);
                camera.FovRectMax = vec2(currentRectFov.z, currentRectFov.w);
            } else if (initRectFov) {
                initRectFov = false;
            }
            if (Setting_FOV != currentSettingFOV) currentSettingFOV = Setting_FOV;
            if (Setting_QuickZoom != currentSettingQuickZoom) currentSettingQuickZoom = Setting_QuickZoom;
        }
    }

    void VendorUpdate(float dt) override
    {
        if (initialised) {
            @visState = VehicleState::ViewingPlayerState();
            if (visState !is null) {
                if (FOVChanging()) { currentFov = Math::Lerp(setFov, currentFov, 0.9f); }
                if (IsRectFOVChanging()) { currentRectFov = Math::Lerp(setRectFov, currentRectFov, 0.9f); }
            }
        }
    }

    UI::InputBlocking VendorOnKeyPress(bool down, VirtualKey key) override
    {
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

    UI::InputBlocking VendorOnMouseWheel(int x, int y) override
    {
        if (Setting_QuickZoomScroll) {
            if (Setting_QuickZoom == QuickZoom::Simple) {
                Setting_QuickZoomSimpleAmount = Math::Clamp(Setting_QuickZoomSimpleAmount - (y * Setting_QuickZoomScrollMultiplier * 10), float(Camera::MinimumFOV), float(Camera::MaximumFOV));
            } else if (Setting_QuickZoom == QuickZoom::Advanced) {
                Setting_QuickZoomAdvancedAmount = Math::Clamp(Setting_QuickZoomAdvancedAmount + (y * Setting_QuickZoomScrollMultiplier), QuickZoom::MinimumAmount, QuickZoom::MaximumAmount);
            }
        }
        return UI::InputBlocking::DoNothing;
    }
}
#endif