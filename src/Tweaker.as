// 0.3.0 TODO
// Apply tables for proper UI layout
// Replace Render() with another method
// m_IsOverlay3D needs re-toggle when entering a map to make cars appear again
// Separate interface into classes like in Core folder
// Settings as well?

// ManiaPlanet and Turbo TODO
// Field of View (Dev::Patch, Moski plugin) and Lighting (too many nods) are not working
// Wrong skybox index in Valley and Lagoon
// IsOverlay3D makes cars disappear mid-game and doesn't work in Turbo

string title = "\\$d36" + Icons::Wrench + "\\$z Tweaker";

Mania@ game;
Window@ window;

void RenderMenu() {
    if (UI::MenuItem(title)) {
        window.isOpened = !window.isOpened;
    }
}

void RenderInterface()
{
    if (window.isOpened) {
		window.Render();
		game.ApplySettings();
	}
	if (Setting_FPS) {
		UI::Begin("\\$o\\$wFPS Counter", Setting_FPS, UI::WindowFlags::AlwaysAutoResize + UI::WindowFlags::NoTitleBar + UI::WindowFlags::NoDocking);
		UI::Text(tostring(int(game.view.AverageFps)));
		UI::End();
	}
}

void Render()
{
	if (game.initialised) {
		game.OverrideSettings();
	}
}

void Update(float delta)
{
	if (game.initialised) {
		if (game.app.GameScene is null) {
			game.RemoveNods();
		}
	} else {
		game.AddNods();
	}
}

void Main()
{
	@game = Mania();
	@window = Window();
}
