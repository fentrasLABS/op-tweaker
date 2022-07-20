#if TMNEXT
class SpecialTab : Tab {
    string GetLabel() override { return "Special"; }

    void Render() override
    {
        // Wipeout Mode

		if (UI::Checkbox("##Wipeout Mode", Setting_Wipeout)) {
            Setting_Wipeout = true;
        } else {
            Setting_Wipeout = false;
        }

		if (UI::IsItemHovered()) {
			UI::BeginTooltip();
			UI::Text("Field of View depends on the speed");
            UI::Text("\\$ff0Please use \"Alternate Cockpit View\" for better experience.\\$z");
            UI::Text("\\$ff0FoV change is a moderately rapid when respawning (for now).\\$z");
			UI::EndTooltip();
		}

		UI::SameLine();
		Setting_WipeoutMax = float(UI::SliderInt("Wipeout", int(Setting_WipeoutMax), Trackmania::GetPreferredFOV(), Camera::MaximumFOV));

        // Quick Zoom -- needs shortcuts to choose between keyboard, mouse wheel and controller (or all)

		if (UI::BeginCombo("Quick Zoom", tostring(Setting_QuickZoom))) {
			if (UI::Selectable("Disabled", false)) {
				Setting_QuickZoom = QuickZoom::Disabled;
			}
			if (UI::Selectable("Simple", false)) {
				Setting_QuickZoom = QuickZoom::Simple;
			}
			if (UI::Selectable("Advanced", false)) {
				Setting_QuickZoom = QuickZoom::Advanced;
			}
			UI::EndCombo();
		}

		if (Setting_QuickZoom != QuickZoom::Disabled) {
			Setting_QuickZoomActive = UI::Checkbox("##Quick Zoom Active", Setting_QuickZoomActive);

			if (UI::IsItemHovered()) {
				UI::BeginTooltip();
				UI::Text("Quickly zoom at the center");
				if (Setting_QuickZoomShortcut != Shortcut::Disabled) {
					UI::Text("\\$ff0Press " + tostring(Setting_QuickZoomShortcutKey) + " to toggle Quick Zoom mode.\\$z");
				}
				UI::EndTooltip();
			}

			UI::SameLine();
			if (Setting_QuickZoom == QuickZoom::Simple) {
				Setting_QuickZoomSimpleAmount = float(UI::SliderInt("Zoom FoV", int(Setting_QuickZoomSimpleAmount), Camera::MinimumFOV, Camera::MaximumFOV));
			} else if (Setting_QuickZoom == QuickZoom::Advanced) {
				Setting_QuickZoomAdvancedAmount = UI::SliderFloat("Zoom Amount", Setting_QuickZoomAdvancedAmount, QuickZoom::MinimumAmount, QuickZoom::MaximumAmount);
			}

			Setting_QuickZoomScroll = UI::Checkbox("Use Scrolling", Setting_QuickZoomScroll);
			if (UI::IsItemHovered()) {
				UI::BeginTooltip();
				UI::Text("Use your mouse wheel or scrolling motion to quickly zoom in or out");
				UI::Text("\\$ff0Scrolling also affects Field of View in Free Camera.\\$z");
				UI::EndTooltip();
			}

			if (UI::BeginCombo("Quick Zoom Shortcut", tostring(Setting_QuickZoomShortcut))) {
				if (UI::Selectable("Disabled", false)) {
					Setting_QuickZoomShortcut = Shortcut::Disabled;
				}
				if (UI::Selectable("Hold", false)) {
					Setting_QuickZoomShortcut = Shortcut::Hold;
				}
				if (UI::Selectable("Toggle", false)) {
					Setting_QuickZoomShortcut = Shortcut::Toggle;
				}
				UI::EndCombo();
			}

			if (Setting_QuickZoomShortcut != Shortcut::Disabled) {
				if (UI::BeginCombo("Quick Zoom Key", tostring(Setting_QuickZoomShortcutKey))) {
					for (int i = 1; i < 255; i++) { // 255 is length of VirtualKey
						if (tostring(VirtualKey(i)) == tostring(i)) continue; // thanks to NaNInf
						if (UI::Selectable(tostring(VirtualKey(i)), false)) {
							Setting_QuickZoomShortcutKey = VirtualKey(i);
						}
					}
					UI::EndCombo();
				}
			}
		}
    }
}
#endif