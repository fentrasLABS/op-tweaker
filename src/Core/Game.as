class Game : Vendor
{
    dictionary defaults = {};

    bool initialised = false;

    CTrackMania@ app;
    CHmsViewport@ view;
    CHmsCamera@ camera;
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
        scene.Mobils[0].IsVisible = Setting_Background;
        scene.Lights[0].Light.Color = Setting_LightingCar ? Setting_LightingCarColor : vec3(defaults["Lighting Car Color"]);
        scene.Lights[0].Light.Intensity = Setting_LightingCar ? Setting_LightingCarIntensity : float(defaults["Lighting Car Intensity"]);
        scene.Lights[1].Light.Color = Setting_LightingWorld ? Setting_LightingWorldColor : vec3(defaults["Lighting World Color"]);
        scene.Lights[1].Light.Intensity = Setting_LightingWorld ? Setting_LightingWorldIntensity : float(defaults["Lighting World Intensity"]);
        clouds.IsVisible = Setting_Clouds;
        clouds.MaterialUseT3b = Setting_CloudsLighting;
        // camera.ClearColorEnable = !Setting_Background;
        // camera.ClearColor = Setting_BackgroundColor;
        ApplyVendorSettings();
    }

    void ApplyVendorSettings() { }

    void OverrideSettings()
    {
        if (Setting_ZClip)
            camera.FarZ = Setting_ZClipDistance;
        if (Setting_FOV == FieldOfView::Simple)
            camera.Fov = Setting_FOVAmount;
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