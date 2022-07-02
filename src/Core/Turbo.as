#if TURBO
class Vendor
{
    CScene3d@ scene;
}

class Mania : Game
{
    void AddVendorNods()
    {
        @scene = app.GameScene.Scene;
        @camera = cast<CHmsCamera>(app.GameCamera.SceneCamera.HmsPoc);
        @clouds = cast<CSceneCloudSystem>(scene.MgrWeather.CloudSystem);
        InitNods();
    }

    void ApplyVendorSettings()
    {
        camera.IsOverlay3d = Setting_RenderMode == RenderMode::Limited;
    }
}
#endif