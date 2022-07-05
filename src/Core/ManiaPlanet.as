#if MP4
class Vendor
{
    CGameScene@ scene;
    array<CSceneMobil@> decoration;
}

class Mania : Game
{
    void AddVendorNods() override
    {
        string environment = app.RootMap.CollectionName;
        @scene = app.GameScene;
        @camera = cast<CHmsCamera>(app.GameCamera.SceneCamera.HmsPoc);
        @clouds = cast<CSceneCloudSystem>(scene.MgrWeather.CloudSystem);

        for (uint i = 0; i < scene.Mobils.Length; i++) {
            auto mobil = scene.Mobils[i];
            if (environment == "Stadium") {
                if (mobil.IdName == "Flags") {
                    decoration.InsertLast(mobil);
                }
                if (mobil.IdName == "SkyDome") {
                    @skybox = mobil;
                }
            } else {
                if (i == 1) {
                    @skybox = mobil;
                }
            }
            if (mobil.IdName == "Warp") {
                decoration.InsertLast(mobil);
            }
        }
        InitNods();
    }

    void RemoveVendorNods() override
    {
        @scene = null;
        decoration.RemoveRange(0, decoration.Length);
    }

    void ApplyVendorSettings() override
    {
        if (camera !is null) {
            camera.IsOverlay3d = Setting_RenderMode == RenderMode::Limited;
            camera.ZClipEnable = Setting_ZClip;
            camera.ZClipValue = Setting_ZClipDistance;
            camera.ClearColor = Setting_BackgroundColor;
            camera.ClearColorEnable = !Setting_Background;
        }
        for (uint i = 0; i < decoration.Length; i++) {
            auto item = decoration[i];
            if (item !is null) {
                item.IsVisible = Setting_Decoration;
            }
        }
    }
}
#endif