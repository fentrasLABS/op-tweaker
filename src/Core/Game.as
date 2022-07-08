class Game : Vendor
{

    dictionary defaults;

    bool initialised = false;

    CTrackMania@ app;
    CHmsViewport@ view;
    CHmsCamera@ camera;
    CSceneMobil@ skybox;
    CSceneCloudSystem@ clouds;

    Game() {
        @app = cast<CTrackMania>(GetApp());
        @view = app.Viewport;
    }

    void AddNods()
    {
        if (app.GameScene !is null && app.CurrentPlayground !is null && view.Cameras.Length > 0) {
            AddVendorNods();
        }
    }

    void AddVendorNods()
    {
        InitNods();
    }

    void InitNods()
    {
        SaveDefaults();
        ApplySettings();
        initialised = true;
    }

    void RemoveNods()
    {
        initialised = false;
        @camera = null;
        @clouds = null;
        RemoveVendorNods();
    }

    void RemoveVendorNods() { }

    void ApplySettings()
    {
        if (view !is null) {
            view.ScreenShotWidth = Setting_ResolutionWidth;
            view.ScreenShotHeight = Setting_ResolutionHeight;
            view.ScreenShotForceRes = Setting_Resolution;
            view.TextureRender = Setting_LightingMode == LightingMode::Minimal ? 0 : 2;
            view.RenderProjectors = Setting_Projectors ? 1 : 0;
        }
        if (skybox !is null) {
            skybox.IsVisible = Setting_Background;
        }
        if (clouds !is null) {
            clouds.IsVisible = Setting_Clouds;
            clouds.MaterialUseT3b = Setting_CloudsLighting;
        }
        ApplyVendorSettings();
    }

    void ApplyVendorSettings() { }

    void OverrideSettings()
    {
        OverrideVendorSettings();
    }

    void OverrideVendorSettings() { }

    void Update(float dt)
    {
        VendorUpdate(dt);
    }

    void VendorUpdate(float dt) { }

    UI::InputBlocking OnKeyPress(bool down, VirtualKey key)
    {
        return VendorOnKeyPress(down, key);
    }

    UI::InputBlocking VendorOnKeyPress(bool down, VirtualKey key)
    {
        return UI::InputBlocking::DoNothing;
    }

    void SaveDefaults()
    {
        if (scene !is null && scene.Lights.Length > 0) {
            defaults.Set("Lighting Car Color", scene.Lights[0].Light.Color);
            defaults.Set("Lighting Car Intensity", scene.Lights[0].Light.Intensity);
            defaults.Set("Lighting World Color", scene.Lights[1].Light.Color);
            defaults.Set("Lighting World Intensity", scene.Lights[1].Light.Intensity);
        }
    }
}