class EnvironmentTab : Tab {
    string GetLabel() override { return "Environment"; }

    void Render() override
    {
        // Background

		Setting_Background = UI::Checkbox("##Background Toggle", Setting_Background);

		if (UI::IsItemHovered()) {
			UI::BeginTooltip();
			UI::Text("Toggle background skybox");
			UI::EndTooltip();
		}

		UI::SameLine();
        if (Setting_Background) UI::BeginDisabled();
		Setting_BackgroundColor = UI::InputColor3("Background Color", Setting_BackgroundColor);
        if (Setting_Background) UI::EndDisabled();

        // Clouds

        Setting_Clouds = UI::Checkbox("Clouds Toggle", Setting_Clouds);

		if (UI::IsItemHovered()) {
			UI::BeginTooltip();
			UI::Text("Toggle clouds");
			UI::EndTooltip();
		}

        UI::SameLine();

        if (!Setting_Clouds) UI::BeginDisabled();
		Setting_CloudsLighting = UI::Checkbox("Clouds Lighting", Setting_CloudsLighting);
		if (UI::IsItemHovered()) {
			UI::BeginTooltip();
			UI::Text("Should lighting affects clouds");
			UI::EndTooltip();
		}
        if (!Setting_Clouds) UI::EndDisabled();
    }
}