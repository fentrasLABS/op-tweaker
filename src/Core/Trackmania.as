#if TMNEXT
class Vendor
{
    CScene@ scene;
}

class Mania : Game
{
    void AddVendorNods() override
    {
        @scene = app.GameScene.HackScene;
        @camera = view.Cameras[0];
        @clouds = cast<CSceneMobilClouds>(scene.Mobils[1]).Clouds;
        @skybox = scene.Mobils[0];
        InitNods();
    }

    void ApplyVendorSettings() override
    {
        camera.m_IsOverlay3d = Setting_RenderMode == RenderMode::Limited;
        scene.Lights[0].Light.Color = Setting_LightingCar ? Setting_LightingCarColor : vec3(defaults["Lighting Car Color"]);
        scene.Lights[0].Light.Intensity = Setting_LightingCar ? Setting_LightingCarIntensity : float(defaults["Lighting Car Intensity"]);
        scene.Lights[1].Light.Color = Setting_LightingWorld ? Setting_LightingWorldColor : vec3(defaults["Lighting World Color"]);
        scene.Lights[1].Light.Intensity = Setting_LightingWorld ? Setting_LightingWorldIntensity : float(defaults["Lighting World Intensity"]);
    }

    void OverrideVendorSettings() override
    {
        if (Setting_ZClip)
            camera.FarZ = Setting_ZClipDistance;
        if (Setting_FOV == FieldOfView::Simple)
            camera.Fov = Setting_FOVAmount;
    }
}
#endif