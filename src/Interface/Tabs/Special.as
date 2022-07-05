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
		Setting_WipeoutMax = float(UI::SliderInt("Wipeout Amount", int(Setting_WipeoutMax), int(Setting_FOVAmount), Camera::MaximumFOV));
    }
}
#endif