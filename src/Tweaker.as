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
		if (game.initialised) {
			game.ApplySettings();
		}
	}
}

void Render()
{
	if (game.initialised) {
		if (game.app.GameScene is null) {
			game.RemoveNods();
		}
		game.Render();
		game.OverrideSettings();
	} else {
		game.AddNods();
	}
}

void Update(float dt)
{
	if (game.initialised) {
		game.Update(dt);
	}
}

UI::InputBlocking OnKeyPress(bool down, VirtualKey key)
{
	return game.OnKeyPress(down, key);
}

void Main()
{
	@game = Mania();
	@window = Window();
}
