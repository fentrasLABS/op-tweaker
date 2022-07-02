class InterfaceTab : Tab {
    string GetLabel() override { return "Interface"; }

    void Render() override
    {
        // FPS Counter

        Setting_FPS = UI::Checkbox("FPS Counter", Setting_FPS);

		if (UI::IsItemHovered()) {
			UI::BeginTooltip();
			UI::Text("Toggle simple FPS counter");
			UI::EndTooltip();
		}
    }
}