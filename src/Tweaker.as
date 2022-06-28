// 0.3.0 TODO
// Apply tables for proper UI layout
// Bug on Linux with Null pointer exception at gameScene
// Replace Render() with startnew()
// Organize code properly
// m_IsOverlay3D needs re-toggle when entering a map to make cars appear again

// ManiaPlanet and Turbo TODO
// Draw Distance (fixable, another nod), Field of View (unknown) and Lighting (needs research) are not working
// Disabling background disables Stadium instead of SkyDome (new feature!)
// IsOverlay3D makes cars disappear mid-game and doesn't work in Turbo

string title = "\\$d36" + Icons::Wrench + "\\$z Tweaker";

dictionary defaults = {};

bool initialised = false;

CTrackMania@ app;
CHmsViewport@ viewport;
CHmsCamera@ mainCamera;
CSceneCloudSystem@ clouds;

#if TMNEXT
CScene@ gameScene;
#elif MP4
CGameScene@ gameScene;
#elif TURBO
CScene3d@ gameScene;
#endif

Window@ window;

void InitialiseNods(bool init = true) {
	if (init) {
		if (app.GameScene is null)
			return;

#if MP4
		@gameScene = app.GameScene;
#elif TURBO
		@gameScene = app.GameScene.Scene;
#endif
#if TMNEXT
		@mainCamera = viewport.Cameras[0];
		@gameScene = app.GameScene.HackScene;
		@clouds = cast<CSceneMobilClouds>(gameScene.Mobils[1]).Clouds;
#elif MP4 || TURBO
		@mainCamera = cast<CHmsCamera>(app.GameCamera.SceneCamera.HmsPoc);
		@clouds = cast<CSceneCloudSystem>(gameScene.MgrWeather.CloudSystem);
#endif
		SaveDefaults();
		ApplySettings();
		initialised = true;
	} else {
		@mainCamera = null;
		@gameScene = null;
		initialised = false;
	}
}

void RenderMenu() {
    if (UI::MenuItem(title)) {
        window.isOpened = !window.isOpened;
    }
}

void RenderInterface()
{
    if (window.isOpened) {
		window.Render();
		ApplySettings();
	}
	if (Setting_FPS) {
		UI::Begin("\\$o\\$wFPS Counter", Setting_FPS, UI::WindowFlags::AlwaysAutoResize + UI::WindowFlags::NoTitleBar + UI::WindowFlags::NoDocking);
		UI::Text(tostring(int(viewport.AverageFps)));
		UI::End();
	}
}

// Probably replace with startnew()
void Render()
{
	if (initialised) {
		OverrideSettings();
	}
}

void Update(float delta)
{
	if (initialised) {
		if (app.GameScene is null) {
			InitialiseNods(false);
			return;
		}
	} else
		InitialiseNods();
}

void OverrideSettings()
{
	if (Setting_ZClip)
		mainCamera.FarZ = Setting_ZClipDistance;
	if (Setting_FOV == FieldOfView::Simple)
		mainCamera.Fov = Setting_FOVAmount;
}

void ApplySettings()
{
	viewport.ScreenShotWidth = Setting_ResolutionWidth;
	viewport.ScreenShotHeight = Setting_ResolutionHeight;
	viewport.ScreenShotForceRes = Setting_Resolution;
	gameScene.Mobils[0].IsVisible = Setting_Background;
	clouds.IsVisible = Setting_Clouds;
	clouds.MaterialUseT3b = Setting_CloudsLighting;
#if TMNEXT
	mainCamera.m_IsOverlay3d = Setting_RenderMode == RenderMode::Limited;
#else
	mainCamera.IsOverlay3d = Setting_RenderMode == RenderMode::Limited;
#endif
	viewport.TextureRender = Setting_LightingMode == LightingMode::Minimal ? 0 : 2;
	viewport.RenderProjectors = Setting_Projectors ? 1 : 0;
	gameScene.Lights[0].Light.Color = Setting_LightingCar ? Setting_LightingCarColor : vec3(defaults["Lighting Car Color"]);
	gameScene.Lights[0].Light.Intensity = Setting_LightingCar ? Setting_LightingCarIntensity : float(defaults["Lighting Car Intensity"]);
	gameScene.Lights[1].Light.Color = Setting_LightingWorld ? Setting_LightingWorldColor : vec3(defaults["Lighting World Color"]);
	gameScene.Lights[1].Light.Intensity = Setting_LightingWorld ? Setting_LightingWorldIntensity : float(defaults["Lighting World Intensity"]);
	// Broken for now
	// mainCamera.ClearColor = Setting_BackgroundColor;
}

void SaveDefaults()
{
	defaults.Set("Lighting Car Color", gameScene.Lights[0].Light.Color);
	defaults.Set("Lighting Car Intensity", gameScene.Lights[0].Light.Intensity);
	defaults.Set("Lighting World Color", gameScene.Lights[1].Light.Color);
	defaults.Set("Lighting World Intensity", gameScene.Lights[1].Light.Intensity);
}

void Main()
{
	// Main Window
	@window = Window();

	// Static Nods
	@app = cast<CTrackMania>(GetApp());
	@viewport = app.Viewport;

	// Dynamic Nods
	@mainCamera = null;
	@gameScene = null;
}