#if TMNEXT
class SpecialTab : Tab {
    string GetLabel() override { return "Special"; }

    void Render() override
    {
        // Wipeout Mode

		if (UI::Checkbox("##Wipeout Mode", Setting_Wipeout)) {
            Setting_Wipeout = true;
            if (Setting_FOV == FieldOfView::Default) {
                Setting_FOV = FieldOfView::Simple;
            }
        } else {
            Setting_Wipeout = false;
        }

		if (UI::IsItemHovered()) {
			UI::BeginTooltip();
			UI::Text("Field of View depends on the speed");
            if (Setting_FOV == FieldOfView::Default) {
                UI::Text("\\$ff0Requires Field of View setting enabled!\\$z");
            }
            UI::Text("\\$ff0Please use \"Alternate Cockpit View\" for better experience.\\$z");
            UI::Text("\\$ff0FoV change is a moderately rapid when respawning (for now).\\$z");
			UI::EndTooltip();
		}

		UI::SameLine();
		Setting_WipeoutMax = float(UI::SliderInt("Wipeout", int(Setting_WipeoutMax), int(Setting_FOVAmount), Camera::MaximumFOV));

        // Quick Zoom -- needs shortcuts to choose between keyboard, mouse wheel and controller (or all)

		if (UI::Checkbox("##Quick Zoom Mode", Setting_QuickZoom == QuickZoom::Simple)) {
            Setting_QuickZoom = QuickZoom::Simple;
        } else {
            Setting_QuickZoom = QuickZoom::Disabled;
        }

		if (UI::IsItemHovered()) {
			UI::BeginTooltip();
			UI::Text("Quickly zoom at the center");
            UI::Text("\\$ff0Press " + tostring(Setting_QuickZoomShortcutKey) + " to activate Quick Zoom mode.\\$z");
			UI::EndTooltip();
		}

		UI::SameLine();
		Setting_QuickZoomAmount = float(UI::SliderInt("Zoom FoV", int(Setting_QuickZoomAmount), Camera::MinimumFOV, Setting_FOV == FieldOfView::Default ? 75 : int(Setting_FOVAmount)));

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
#endif