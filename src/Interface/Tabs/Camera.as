#if TMNEXT
class CameraTab : Tab {
    string GetLabel() override { return "Camera"; }

    void Render() override
    {
        // Field of View

		if (UI::Checkbox("##Field of View Toggle", Setting_FOV == FieldOfView::Simple)) {
            Setting_FOV = FieldOfView::Simple;
        } else {
            Setting_FOV = FieldOfView::Default;
            if (Setting_Wipeout) {
                Setting_Wipeout = false;
            }
        }

		if (UI::IsItemHovered()) {
			UI::BeginTooltip();
			UI::Text("How wide can camera see");
			UI::EndTooltip();
		}

		UI::SameLine();
		Setting_FOVAmount = float(UI::SliderInt("Field of View", int(Setting_FOVAmount), Camera::MinimumFOV, Camera::MaximumFOV));
    }
}
#endif