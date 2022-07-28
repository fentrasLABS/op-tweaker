#if TMNEXT
namespace Trackmania
{
    const float MinimumFrontSpeed = 10.f;
    const float MaximumFrontSpeed = 275.f;

    int GetPreferredFOV() { return Setting_FOV == FieldOfView::Simple ? int(Setting_FOVAmount) : Camera::DefaultFOV; }
}

class Vendor
{
    bool decoration;
    bool initFov;
    float setFov;
    float currentFov;
    bool initRectFov;
    bool pickRectFov;
    vec4 setRectFov;
    vec4 currentRectFov;
    vec4 tempRectFov;
    float pickRectFovZoom;
    string warpPath;
    
    CScene@ scene;
    CSceneVehicleVisState@ visState;
    CGameCtnChapter@ collection;
    CSceneFxStereoscopy@ stereoscopy;
    
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

    private bool FOVRectChanging()
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

    private vec4 GetMouseFovRect(float zoomFactor)
    {
        vec2 mousePos = UI::GetMousePos();
        vec2 windowSize = vec2(Math::Max(Draw::GetWidth(), 16), Math::Max(Draw::GetHeight(), 16));
        mousePos = vec2(Math::Clamp(mousePos.x, 1, windowSize.x), Math::Clamp(mousePos.y, 1, windowSize.y));
        float calcPosX = ((mousePos.x * (zoomFactor - -zoomFactor)) / windowSize.x) + -zoomFactor;
        float calcPosY = ((mousePos.y * (zoomFactor - -zoomFactor)) / windowSize.y) + -zoomFactor;
        vec2 rectMin = vec2(calcPosX - zoomFactor, calcPosY - zoomFactor);
        vec2 rectMax = vec2(calcPosX + zoomFactor, calcPosY + zoomFactor);
        return vec4(rectMin.x, rectMin.y, rectMax.x, rectMax.y);
    }

    private bool IsDecorationCreated()
    {
        return collection.Articles[5].CollectorFid.Nod !is null
            && collection.Articles[6].CollectorFid.Nod !is null;
    }

    private void DecorationToggle(bool enabled)
    {

        CSystemFidFile@ fidStade4096 = Fids::GetGame(warpPath + "Stade4096.Prefab.Gbx");
        CSystemFidFile@ fidStade1536 = Fids::GetGame(warpPath + "Stade1536.Prefab.Gbx");
        CSystemFidFile@ fidStade1536B = Fids::GetGame(warpPath + "Stade1536B.Prefab.Gbx");
        CPlugPrefab@ stade4096 = cast<CPlugPrefab>(fidStade4096.Preload());
        CPlugPrefab@ stade1536 = cast<CPlugPrefab>(fidStade1536.Preload());
        CPlugPrefab@ stade1536B = cast<CPlugPrefab>(fidStade1536B.Preload());
        
        if (!enabled) {
            CSystemFidFile@ fidGrass4096 = Fids::GetGame(warpPath + "Grass4096.Mesh.Gbx");
            CSystemFidFile@ fidGrass1536 = Fids::GetGame(warpPath + "Grass1536.Mesh.Gbx");
            CPlugSolid2Model@ grass4096 = cast<CPlugSolid2Model>(fidGrass4096.Preload());
            CPlugSolid2Model@ grass1536 = cast<CPlugSolid2Model>(fidGrass1536.Preload());
            @cast<CPlugStaticObjectModel>(stade4096.Ents[0].Model).Mesh = grass4096;
            @cast<CPlugStaticObjectModel>(stade1536.Ents[0].Model).Mesh = grass1536;
            @cast<CPlugStaticObjectModel>(stade1536B.Ents[0].Model).Mesh = grass1536;
        } else {
            CSystemFidFile@ fidStadm4096 = Fids::GetGame(warpPath + "Stade4096.Mesh.Gbx");
            CSystemFidFile@ fidStadm1536 = Fids::GetGame(warpPath + "Stade1536.Mesh.Gbx");
            CPlugSolid2Model@ stadm4096 = cast<CPlugSolid2Model>(fidStadm4096.Preload());
            CPlugSolid2Model@ stadm1536 = cast<CPlugSolid2Model>(fidStadm1536.Preload());
            @cast<CPlugStaticObjectModel>(stade4096.Ents[0].Model).Mesh = stadm4096;
            @cast<CPlugStaticObjectModel>(stade1536.Ents[0].Model).Mesh = stadm1536;
            @cast<CPlugStaticObjectModel>(stade1536B.Ents[0].Model).Mesh = stadm1536;   
        }

        decoration = Setting_Decoration;
    }

    private CSceneFxStereoscopy@ GetStereoscopyNod()
    {
        CSystemFidFile@ sceneFxNodRoot = cast<CSystemFidFile>(app.Resources.SceneFxNodRoot);
        CSceneFxNod@ nod = cast<CSceneFxNod>(sceneFxNodRoot.Nod);
        return cast<CSceneFxStereoscopy>(nod.NodInput.Fx);
    }

    void AddVendorNods() override
    {
        @scene = app.GameScene.HackScene;
        @camera = view.Cameras[0];
        @clouds = cast<CSceneMobilClouds>(scene.Mobils[1]).Clouds;
        @skybox = scene.Mobils[0];
        @stereoscopy = GetStereoscopyNod();
        currentSettingFOV = Setting_FOV;
        currentSettingQuickZoom = Setting_QuickZoom;
        initFov = false;
        initRectFov = false;
        pickRectFov = false;
        currentFov = camera.Fov;
        setFov = currentFov;
        currentRectFov = GetCameraFovRect(camera);
        setRectFov = currentRectFov;
        tempRectFov = currentRectFov;
        pickRectFovZoom = 1.f;
        InitNods();
    }

    void RemoveVendorNods() override
    {
        @scene = null;
        @visState = null;
    }

    void ApplyVendorSettings() override
    {
        app.StereoscopyEnable = Setting_Stereoscopy != Stereoscopy::Disabled;
        if (Setting_Stereoscopy != Stereoscopy::Disabled) {
            stereoscopy.Output = Stereoscopy::Workaround;
            stereoscopy.Output = Setting_Stereoscopy;
            stereoscopy.SeparationUserScale = Setting_StereoscopySeparation;
            stereoscopy.SplitRatio = Setting_StereoscopyRatio;
            stereoscopy.AnaglyphColor = Setting_StereoscopyColor;
            stereoscopy.AnaglyphColorFactor = 1.f - Setting_StereoscopyColorFactor;
        }
        if (initialised) {
            if (camera !is null) {
                camera.m_IsOverlay3d = Setting_RenderMode == RenderMode::Limited;
                camera.m_ViewportRatio = Setting_RatioPriority == RatioPriority::Horizontal ? CHmsCamera::EViewportRatio::FovX : CHmsCamera::EViewportRatio::FovY;
                camera.ClearColor = Setting_BackgroundColor;
                if (FOVRectChanging()) {
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
    }

    void VendorRoutine() override
    {
        if (initialised) {
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
                if (FOVRectChanging()) {
                    if (!initRectFov) {
                        currentRectFov = GetCameraFovRect(camera);
                        initRectFov = true;
                    }
                    if (Setting_QuickZoomActive && Setting_QuickZoom == QuickZoom::Advanced) {
                        setRectFov = GetMouseFovRect(Setting_QuickZoomAdvancedAmount);
                    } else if (Setting_FOV == FieldOfView::Advanced) {
                        if (pickRectFov) {
                            Setting_FOVRect = GetMouseFovRect(pickRectFovZoom);
                        }
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
    }

    void VendorUpdate(float dt) override
    {
        if (initialised) {
            @visState = VehicleState::ViewingPlayerState();
            if (visState !is null) {
                if (FOVChanging()) currentFov = Math::Lerp(setFov, currentFov, 0.9f);
                if (FOVRectChanging()) currentRectFov = Math::Lerp(setRectFov, currentRectFov, 0.9f);
            }
            if (Setting_Decoration != decoration && IsDecorationCreated()) {
                DecorationToggle(Setting_Decoration);
            } else if (!IsDecorationCreated()) {
                decoration = !Setting_Decoration;
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
            ApplySettings();
        }
        return block ? UI::InputBlocking::Block : UI::InputBlocking::DoNothing;
    }

    UI::InputBlocking VendorOnMouseButton(bool down, int button, int x, int y)
    {
        if (Setting_FOV == FieldOfView::Advanced && pickRectFov && down) {
            if (button == 0) {
                pickRectFov = false;
                UI::ShowOverlay();
            } else if (button == 1) {
                Setting_FOVRect = tempRectFov;
                pickRectFov = false;
                UI::ShowOverlay();
            }
        }
        return UI::InputBlocking::DoNothing;
    }

    UI::InputBlocking VendorOnMouseWheel(int x, int y) override
    {
        if (Setting_QuickZoomScroll && Setting_QuickZoomActive) {
            if (Setting_QuickZoom == QuickZoom::Simple) {
                Setting_QuickZoomSimpleAmount = Math::Clamp(Setting_QuickZoomSimpleAmount - (y * Setting_QuickZoomScrollMultiplier * 10), float(Camera::MinimumFOV), float(Camera::MaximumFOV));
            } else if (Setting_QuickZoom == QuickZoom::Advanced) {
                Setting_QuickZoomAdvancedAmount = Math::Clamp(Setting_QuickZoomAdvancedAmount + (y * Setting_QuickZoomScrollMultiplier), QuickZoom::MinimumAmount, QuickZoom::MaximumAmount);
            }
        }
        if (Setting_FOV == FieldOfView::Advanced && pickRectFov) {
            // Replace QuickZoom min/max amount with global FOVRect limits
            pickRectFovZoom = Math::Clamp(pickRectFovZoom + (y * Setting_QuickZoomScrollMultiplier), QuickZoom::MinimumAmount, QuickZoom::MaximumAmount);
        }
        return UI::InputBlocking::DoNothing;
    }
}
#endif