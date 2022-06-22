string title = "\\$d36" + Icons::Wrench + "\\$z Tweaker";

bool initialised = false;

CHmsCamera@ mainCamera;

Window@ window;

void InitialiseNods(bool init = true) {
	if (init) {
		if (GetApp().GameScene !is null) {
			@mainCamera = GetApp().Viewport.Cameras[0];
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
		if (!initialised) {
			InitialiseNods();
		}
	}
}

void Render()
{
	if (initialised) {
		if (Setting_ZClip) {
			mainCamera.FarZ = Setting_ZClipDistance;
		}
	}
}

void Update(float delta)
{
	if(initialised && GetApp().GameScene is null) {
		InitialiseNods(false);
	}
}

void Main()
{
	
	@window = Window();
	@mainCamera = null;
}