class GraphicsTab : Tab {
    string GetLabel() override { return "Graphics"; }

    void Render() override
    {
		// Screen Resolution

		Setting_Resolution = UI::Checkbox("Resolution Override", Setting_Resolution);

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
		Setting_ResolutionWidth = UI::InputInt("Resolution Width", Setting_ResolutionWidth);
		// UI::SameLine();
		Setting_ResolutionHeight = UI::InputInt("Resolution Height", Setting_ResolutionHeight);
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
#if !TURBO
		if (UI::BeginCombo("Render Mode", tostring(Setting_RenderMode))) {
			if (UI::Selectable("Default", false)) {
				Setting_RenderMode = RenderMode::Default;
			}
			if (UI::Selectable("Limited", false)) {
				Setting_RenderMode = RenderMode::Limited;
			}
			UI::EndCombo();
		}
#if TMNEXT
		if (UI::IsItemHovered()) {
			UI::BeginTooltip();
			UI::Text("\\$ff0Cutting Edge Version Note");
			UI::Text("To fix decals being stuck on the screen switch to Free Camera,\nlook somewhere where you don't see any decals (e.g. sky)\nand enable this setting.");
			UI::EndTooltip();
		}
#endif
#endif
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
#if TMNEXT
		if (UI::IsItemHovered()) {
			UI::BeginTooltip();
			UI::Text("\\$ff0Cutting Edge Version Note");
			UI::Text("If lighting is too bright you can tweak it in Environment tab.");
			UI::EndTooltip();
		}
#endif
		// Projectors

		Setting_Projectors = UI::Checkbox("Projectors Toggle", Setting_Projectors);

		if (UI::IsItemHovered()) {
			UI::BeginTooltip();
			UI::Text("Display fake shadows (e.g. under the car)");
			UI::EndTooltip();
		}

    }
}