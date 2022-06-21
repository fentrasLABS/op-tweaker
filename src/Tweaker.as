string title = "\\$d36" + Icons::Wrench + "\\$z Tweaker";

CHmsCamera@ mainCamera = null;

Window@ g_window;

void RenderMenu() {
    if (UI::MenuItem(title)) {
        g_window.isOpened = !g_window.isOpened;
    }
}

void RenderInterface()
{
    if (g_window.isOpened) g_window.Render();
}

void Render()
{
	if (Setting_ZClip) {
		mainCamera.FarZ = Setting_ZClipDistance;
	}
}

void Main()
{
	@mainCamera = GetApp().Viewport.Cameras[0];
	@g_window = Window();
}