// 0.3.0 TODO
// Apply tables for proper UI layout
// m_IsOverlay3D needs re-toggle when entering a map to make cars appear again
// Separate interface into classes like in Core folder
// Settings as well?
// Ability to add shortcut to every setting
// Proper UI, accesible to everyone

// ManiaPlanet and Turbo TODO
// Field of View (Dev::Patch (Moski plugin) or Fids) and Lighting (too many nods) are not working
// Wrong skybox index in Valley and Lagoon
// IsOverlay3D makes cars disappear mid-game and doesn't work in Turbo

const string title = "\\$d36" + Icons::Wrench + "\\$z Tweaker";

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
}

void Render()
{
	game.Render();
	game.Routine();
	if (game.initialised) {
		if (game.app.GameScene is null) {
			game.RemoveNods();
		}
	} else {
		game.AddNods();
	}
}

void Update(float dt)
{
	game.Update(dt);
}

UI::InputBlocking OnKeyPress(bool down, VirtualKey key)
{
	return game.OnKeyPress(down, key);
}

UI::InputBlocking OnMouseButton(bool down, int button, int x, int y)
{
	return game.OnMouseButton(down, button, x, y);
}

UI::InputBlocking OnMouseWheel(int x, int y)
{
	return game.OnMouseWheel(x, y);
}

void Main()
{
	@game = Mania();
	@window = Window();
}
