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
        @collection = app.GlobalCatalog.Chapters[4];
        decoration = !Setting_Decoration;
        warpPath = "GameData/Stadium256/Media/Solid/Warp/";
    }

    void AddNods()
    {
        if (app.GameScene !is null && (app.CurrentPlayground !is null || app.Editor !is null) && view.Cameras.Length > 0) {
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
        if (view !is null) {
            // Change code design choices
            // You need to also have ApplySettings which can work without initialised game
            // Therefore there needs to be ApplySettings - ApplyInitialisedSettings - and so on
            view.ScreenShotForceRes = !UI::IsOverlayShown() ? Setting_Resolution : false;
        }
        OverrideVendorSettings();
    }

    void OverrideVendorSettings() { }

    void Render()
    {
        if (Setting_FPS) {
            UI::Begin("\\$o\\$wFPS Counter", Setting_FPS, UI::WindowFlags::AlwaysAutoResize + UI::WindowFlags::NoTitleBar + UI::WindowFlags::NoDocking);
            UI::Text(tostring(int(game.view.AverageFps)));
            UI::End();
        }
    }

    void Update(float dt)
    {
        VendorUpdate(dt);
    }

    void VendorUpdate(float dt) { }

    UI::InputBlocking OnKeyPress(bool down, VirtualKey key)
    {
        bool block = false;
        if (key == Setting_ResolutionShortcutKey && Setting_ResolutionShortcut != Shortcut::Disabled) {
            if (Setting_ResolutionShortcut == Shortcut::Hold) {
                Setting_Resolution = down ? true : false;
            } else if (Setting_ResolutionShortcut == Shortcut::Toggle && down) {
                Setting_Resolution = !Setting_Resolution;
                block = true;
            }
            ApplySettings();
        } else {
            return VendorOnKeyPress(down, key);
        }
        return block ? UI::InputBlocking::Block : UI::InputBlocking::DoNothing;
    }

    UI::InputBlocking VendorOnKeyPress(bool down, VirtualKey key)
    {
        return UI::InputBlocking::DoNothing;
    }

    UI::InputBlocking OnMouseWheel(int x, int y)
    {
        return VendorOnMouseWheel(x, y);
    }

    UI::InputBlocking VendorOnMouseWheel(int x, int y)
    {
        return UI::InputBlocking::DoNothing;
    }

    void SaveDefaults()
    {
        if (scene !is null && scene.Lights.Length > 0) {
            // Bug: setting a different lighting and entering the game won't save default values
            defaults.Set("Lighting Car Color", scene.Lights[0].Light.Color);
            defaults.Set("Lighting Car Intensity", scene.Lights[0].Light.Intensity);
            defaults.Set("Lighting World Color", scene.Lights[1].Light.Color);
            defaults.Set("Lighting World Intensity", scene.Lights[1].Light.Intensity);
        }
    }
}