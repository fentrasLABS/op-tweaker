class GraphicsTab : Tab {
    string GetLabel() override { return "Graphics"; }

    void Render() override
    {
		Setting_ZClip = UI::Checkbox("##Draw Distance Toggle", Setting_ZClip);

		if (UI::IsItemHovered()) {
			UI::BeginTooltip();
			UI::Text("How far the game can render itself");
			UI::EndTooltip();
		}

		if (!Setting_ZClip || !initialised) UI::BeginDisabled();
		UI::SameLine();
		Setting_ZClipDistance = UI::SliderInt("Draw Distance", Setting_ZClipDistance, 10, 5000);
		if (!Setting_ZClip || !initialised) UI::EndDisabled();
    }
}