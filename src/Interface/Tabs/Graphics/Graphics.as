class GraphicsTab : Tab {
    string GetLabel() override { return "Graphics"; }

    void Render() override
    {
		// Screen Resolution

		Setting_Resolution = UI::Checkbox("Screen Resolution Toggle", Setting_Resolution);

		if (UI::IsItemHovered()) {
			UI::BeginTooltip();
			UI::Text("Custom screen resolution");
			UI::Text("\\$777Works in windowed mode, but breaks OpenPlanet UI scaling.\\$z");
			UI::Text("\\$ff0" + Icons::KeyboardO + " Keyboard shortcuts available\\$z");
			UI::EndTooltip();
		}

		if (Setting_Resolution) UI::BeginDisabled();
		// UI::SameLine();
		Setting_ResolutionWidth = UI::SliderInt("Resolution Width", Setting_ResolutionWidth, RESOLUTION_MIN, RESOLUTION_WIDTH_MAX);
		// UI::SameLine();
		Setting_ResolutionHeight = UI::SliderInt("Resolution Height", Setting_ResolutionHeight, RESOLUTION_MIN, RESOLUTION_HEIGHT_MAX);
		// UI::SameLine();
		// UI::Text("Screen Resolution");
		if (Setting_Resolution) UI::EndDisabled();

		// Draw Distance

		Setting_ZClip = UI::Checkbox("##Draw Distance Toggle", Setting_ZClip);

		if (UI::IsItemHovered()) {
			UI::BeginTooltip();
			UI::Text("How far the game can render itself");
			UI::EndTooltip();
		}

		UI::SameLine();
		Setting_ZClipDistance = UI::SliderInt("Draw Distance", Setting_ZClipDistance, 10, 5000);
    }
}