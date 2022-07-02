// 0.3.0 TODO
// Apply tables for proper UI layout
// Replace Render() with another method
// m_IsOverlay3D needs re-toggle when entering a map to make cars appear again

// ManiaPlanet and Turbo TODO
// Draw Distance (fixable, another nod), Field of View (unknown) and Lighting (needs research) are not working
// Disabling background disables Stadium instead of SkyDome (new feature!)
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