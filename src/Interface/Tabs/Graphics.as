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
			if (Setting_ResolutionShortcut != Shortcut::Disabled) {
				// Make this tooltip function separate one
				UI::Text("\\$ff0Press " + tostring(Setting_ResolutionShortcutKey) + " to toggle Resolution Override.\\$z");
			}
			UI::Text("\n\\$f00Preview Version Warning");
			UI::Text("Move this window to top left corner first.");
			UI::Text("Remember the position of a checkbox because UI will move but its controls will remain in the same place.");
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

		if (UI::BeginCombo("Resolution Shortcut", tostring(Setting_ResolutionShortcut))) {
			if (UI::Selectable("Disabled", false)) {
				Setting_ResolutionShortcut = Shortcut::Disabled;
			}
			if (UI::Selectable("Hold", false)) {
				Setting_ResolutionShortcut = Shortcut::Hold;
			}
			if (UI::Selectable("Toggle", false)) {
				Setting_ResolutionShortcut = Shortcut::Toggle;
			}
			UI::EndCombo();
		}

		if (Setting_ResolutionShortcut != Shortcut::Disabled) {
			if (UI::BeginCombo("Resolution Key", tostring(Setting_ResolutionShortcutKey))) {
				for (int i = 1; i < 255; i++) { // 255 is length of VirtualKey
					if (tostring(VirtualKey(i)) == tostring(i)) continue; // thanks to NaNInf
					if (UI::Selectable(tostring(VirtualKey(i)), false)) {
						Setting_ResolutionShortcutKey = VirtualKey(i);
					}
				}
				UI::EndCombo();
			}
		}

		UI::Separator();
		// Draw Distance

		Setting_ZClip = UI::Checkbox("##Draw Distance Toggle", Setting_ZClip);

		if (UI::IsItemHovered()) {
			UI::BeginTooltip();
			UI::Text("How far the game can render itself");
			UI::EndTooltip();
		}

		UI::SameLine();
		Setting_ZClipDistance = UI::SliderInt("Draw Distance", Setting_ZClipDistance, 10, 5000);

		if (UI::BeginCombo("Draw Distance Shortcut", tostring(Setting_ZClipShortcut))) {
			if (UI::Selectable("Disabled", false)) {
				Setting_ZClipShortcut = Shortcut::Disabled;
			}
			if (UI::Selectable("Hold", false)) {
				Setting_ZClipShortcut = Shortcut::Hold;
			}
			if (UI::Selectable("Toggle", false)) {
				Setting_ZClipShortcut = Shortcut::Toggle;
			}
			UI::EndCombo();
		}

		if (Setting_ZClipShortcut != Shortcut::Disabled) {
			if (UI::BeginCombo("Draw Distance Key", tostring(Setting_ZClipShortcutKey))) {
				for (int i = 1; i < 255; i++) { // 255 is length of VirtualKey
					if (tostring(VirtualKey(i)) == tostring(i)) continue; // thanks to NaNInf
					if (UI::Selectable(tostring(VirtualKey(i)), false)) {
						Setting_ZClipShortcutKey = VirtualKey(i);
					}
				}
				UI::EndCombo();
			}
		}

		UI::Separator();
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
			UI::Text("\\$ff0Preview Version Note");
			UI::Text("To fix decals being stuck on the screen switch to Free Camera,\nlook somewhere where you don't see any decals (e.g. sky)\nand enable this setting.");
			UI::EndTooltip();
		}
#endif
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