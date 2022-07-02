#if MP4
class Vendor
{
    CGameScene@ scene;
}

class Mania : Game
{
    void AddVendorNods()
    {
        @scene = app.GameScene;
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