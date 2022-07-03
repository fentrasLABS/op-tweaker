#if TURBO
class Vendor
{
    CScene3d@ scene;
    CSceneMobil@ city;
    array<CSceneMobil@> decoration;
}

class Mania : Game
{
    void AddVendorNods() override
    {
        string environment = app.Challenge.CollectionName;
        @scene = app.GameScene.Scene;
        @camera = cast<CHmsCamera>(app.GameCamera.SceneCamera.HmsPoc);
        @clouds = cast<CSceneCloudSystem>(scene.MgrWeather.CloudSystem);

        for (uint i = 0; i < scene.Mobils.Length; i++) {
            auto mobil = scene.Mobils[i];
            if (environment == "Stadium") {
                if (i == 4) {
                    decoration.InsertLast(mobil);
                }
                if (mobil.IdName == "Flags") {
                    decoration.InsertLast(mobil);
                }
                if (mobil.IdName == "SkyDome") {
                    @skybox = mobil;
                }
            } else {
                if (i == 0) {
                    @skybox = mobil;
                }
            }
            if (mobil.IdName == "Warp") {
                decoration.InsertLast(mobil);
            }
        }
        InitNods();
    }

    void ApplyVendorSettings() override
    {
        camera.ZClipEnable = Setting_ZClip;
        camera.ZClipValue = Setting_ZClipDistance;
        camera.ClearColor = Setting_BackgroundColor;
        camera.ClearColorEnable = !Setting_Background;
        for (uint i = 0; i < decoration.Length; i++) {
            decoration[i].IsVisible = Setting_Decoration;
        }
    }
}
#endif