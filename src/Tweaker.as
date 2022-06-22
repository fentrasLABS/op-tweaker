string title = "\\$d36" + Icons::Wrench + "\\$z Tweaker";

bool initialised = false;

CHmsViewport@ viewport;
CHmsCamera@ mainCamera;

Window@ window;

void InitialiseNods(bool init = true) {
	if (init) {
		if (GetApp().GameScene !is null) {
			@mainCamera = viewport.Cameras[0];
		} else return;
		initialised = true;
	} else {
		@mainCamera = null;
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
		if (!initialised) {
			InitialiseNods();
		}
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
	if(initialised && GetApp().GameScene is null) {
		InitialiseNods(false);
	}
}

void OverrideSettings()
{
	if (Setting_ZClip) {
		mainCamera.FarZ = Setting_ZClipDistance;
	}
}

void ApplySettings()
{
	viewport.ScreenShotWidth = Setting_ResolutionWidth;
	viewport.ScreenShotHeight = Setting_ResolutionHeight;
	viewport.ScreenShotForceRes = Setting_Resolution;
}

void Main()
{
	// Main Window
	@window = Window();

	// Static Nods
	@viewport = GetApp().Viewport;

	// Dynamic Nods
	@mainCamera = null;
}