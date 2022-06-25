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
			UI::Text("\n\\$ff0Cutting Edge Version Note");
			UI::Text("Remember the position of a checkbox because UI will move but controls will remain in the same place.");
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

		// Render Mode

		if (UI::BeginCombo("Render Mode", tostring(Setting_RenderMode))) {
			if (UI::Selectable("Default", false)) {
				Setting_RenderMode = RenderMode::Default;
			}
			if (UI::Selectable("Limited", false)) {
				Setting_RenderMode = RenderMode::Limited;
			}
			UI::EndCombo();
		}

		if (UI::IsItemHovered()) {
			UI::BeginTooltip();
			UI::Text("\\$ff0Cutting Edge Version Note");
			UI::Text("To fix decals being stuck on the screen switch to Free Camera,\nlook somewhere where you don't see any decals (e.g. sky)\nand enable this setting.");
			UI::EndTooltip();
		}

		// Lighting Mode

		if (UI::BeginCombo("Lighting Mode", tostring(Setting_LightingMode))) {
			if (UI::Selectable("Default", false)) {
				Setting_LightingMode = LightingMode::Default;
			}
			if (UI::Selectable("Minimal", false)) {
				Setting_LightingMode = LightingMode::Minimal;
			}
			UI::EndCombo();
		}

		if (UI::IsItemHovered()) {
			UI::BeginTooltip();
			UI::Text("\\$ff0Cutting Edge Version Note");
			UI::Text("The lighting might be too bright but there's a fix that will be introduced in the next commit.");
			UI::EndTooltip();
		}

		// Projectors

		Setting_Projectors = UI::Checkbox("Projectors Toggle", Setting_Projectors);

		if (UI::IsItemHovered()) {
			UI::BeginTooltip();
			UI::Text("Display fake shadows (e.g. under the car)");
			UI::EndTooltip();
		}

    }
}