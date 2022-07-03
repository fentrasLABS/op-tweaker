class EnvironmentTab : Tab {
    string GetLabel() override { return "Environment"; }

    void Render() override
    {
        // Background

#if !TMNEXT
		string prefix = "##";
#else
		string prefix = "";
#endif
		Setting_Background = UI::Checkbox(prefix + "Background Toggle", Setting_Background);

		if (UI::IsItemHovered()) {
			UI::BeginTooltip();
			UI::Text("Toggle background skybox");
			UI::EndTooltip();
		}

		UI::SameLine();
#if !TMNEXT
        if (Setting_Background) UI::BeginDisabled();
		Setting_BackgroundColor = UI::InputColor3("Background Color", Setting_BackgroundColor);
        if (Setting_Background) UI::EndDisabled();
#endif

		// Decoration
#if !TMNEXT
        Setting_Decoration = UI::Checkbox("Decoration Toggle", Setting_Decoration);

		if (UI::IsItemHovered()) {
			UI::BeginTooltip();
			UI::Text("Toggle decoration");
			UI::EndTooltip();
		}
#endif
		
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

		// Lighting Car
#if TMNEXT
		Setting_LightingCar = UI::Checkbox("Lighting (Car)", Setting_LightingCar);

		if (UI::IsItemHovered()) {
			UI::BeginTooltip();
			UI::Text("Toggle car lighting settings");
			UI::EndTooltip();
		}

        if (!Setting_LightingCar) UI::BeginDisabled();
		Setting_LightingCarColor = UI::InputColor3("Lighting (Car) Color", Setting_LightingCarColor);
		Setting_LightingCarIntensity = UI::SliderFloat("Lighting (Car) Intensity", Setting_LightingCarIntensity, -10.f, 10.f);
        if (!Setting_LightingCar) UI::EndDisabled();

		Setting_LightingWorld = UI::Checkbox("Lighting (World)", Setting_LightingWorld);

		if (UI::IsItemHovered()) {
			UI::BeginTooltip();
			UI::Text("Toggle world lighting settings");
			UI::EndTooltip();
		}

        if (!Setting_LightingWorld) UI::BeginDisabled();
		Setting_LightingWorldColor = UI::InputColor3("Lighting (World) Color", Setting_LightingWorldColor);
		Setting_LightingWorldIntensity = UI::SliderFloat("Lighting (World) Intensity", Setting_LightingWorldIntensity, -10.f, 10.f);
        if (!Setting_LightingWorld) UI::EndDisabled();
#endif
    }
}