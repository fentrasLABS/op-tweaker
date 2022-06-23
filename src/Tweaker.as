// 0.3.0 TODO
// Apply tables for proper UI layout

string title = "\\$d36" + Icons::Wrench + "\\$z Tweaker";

bool initialised = false;
bool applyOnce = false;

CTrackMania@ app;
CHmsViewport@ viewport;
CScene@ gameScene;
CHmsCamera@ mainCamera;

Window@ window;

void InitialiseNods(bool init = true) {
	if (init) {
		if (app.GameScene is null)
			return;
		@mainCamera = viewport.Cameras[0];
		@gameScene = app.GameScene.HackScene;
		ApplySettings();
		applyOnce = true;
		initialised = true;
	} else {
		@mainCamera = null;
		applyOnce = false;
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
		}
		if (!applyOnce) {
			ApplySettings();
			applyOnce = true;
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
	cast<CSceneMobilClouds>(gameScene.Mobils[1]).Clouds.IsVisible = Setting_Clouds;
	cast<CSceneMobilClouds>(gameScene.Mobils[1]).Clouds.MaterialUseT3b = Setting_CloudsLighting;
	// Broken for now
	// mainCamera.ClearColor = Setting_BackgroundColor;
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