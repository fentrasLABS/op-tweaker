class Game : Vendor
{
    dictionary defaults = {};

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
        if (app.GameScene is null) {
            return;
        }
        AddVendorNods();
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
        @scene = null;
        @camera = null;
        @clouds = null;
        initialised = false;
    }

    void ApplySettings()
    {
        view.ScreenShotWidth = Setting_ResolutionWidth;
        view.ScreenShotHeight = Setting_ResolutionHeight;
        view.ScreenShotForceRes = Setting_Resolution;
        view.TextureRender = Setting_LightingMode == LightingMode::Minimal ? 0 : 2;
        view.RenderProjectors = Setting_Projectors ? 1 : 0;
        skybox.IsVisible = Setting_Background;
        clouds.IsVisible = Setting_Clouds;
        clouds.MaterialUseT3b = Setting_CloudsLighting;
        ApplyVendorSettings();
    }

    void ApplyVendorSettings() { }

    void OverrideSettings()
    {
        OverrideVendorSettings();
    }

    void OverrideVendorSettings() { }

    void SaveDefaults()
    {
        defaults.Set("Lighting Car Color", scene.Lights[0].Light.Color);
        defaults.Set("Lighting Car Intensity", scene.Lights[0].Light.Intensity);
        defaults.Set("Lighting World Color", scene.Lights[1].Light.Color);
        defaults.Set("Lighting World Intensity", scene.Lights[1].Light.Intensity);
    }
}