#if TMNEXT
class Vendor
{
    CScene@ scene;
}

class Mania : Game
{
    void AddVendorNods()
    {
        @scene = app.GameScene.HackScene;
        @camera = view.Cameras[0];
        @clouds = cast<CSceneMobilClouds>(scene.Mobils[1]).Clouds;
        InitNods();
    }

    void ApplyVendorSettings()
    {
        camera.m_IsOverlay3d = Setting_RenderMode == RenderMode::Limited;
    }
}
#endif