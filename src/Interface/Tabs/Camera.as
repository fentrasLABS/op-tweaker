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
        }

		if (UI::IsItemHovered()) {
			UI::BeginTooltip();
			UI::Text("How wide can camera see");
			UI::EndTooltip();
		}

		UI::SameLine();
		Setting_FOVAmount = float(UI::SliderInt("Field of View", int(Setting_FOVAmount), Camera::MinimumFOV, Camera::MaximumFOV));

        // Ratio Priority

		if (UI::BeginCombo("Ratio Priority", tostring(Setting_RatioPriority))) {
			if (UI::Selectable("Vertical", false)) {
				Setting_RatioPriority = RatioPriority::Vertical;
			}
			if (UI::Selectable("Horizontal", false)) {
				Setting_RatioPriority = RatioPriority::Horizontal;
			}
			UI::EndCombo();
		}

		if (UI::IsItemHovered()) {
			UI::BeginTooltip();
			UI::Text("Proritize camera view stretching horizontally or vertically.");
			UI::Text("Useful if you are playing in vertical resolution.");
			UI::EndTooltip();
		}

        // Aspect Ratio
        Setting_AspectRatio = UI::Checkbox("##Aspect Ratio Toggle", Setting_AspectRatio);

        if (UI::IsItemHovered()) {
			UI::BeginTooltip();
			UI::Text("Aspect ratio between screen width and height");
			UI::EndTooltip();
		}

        UI::SameLine();
        Setting_AspectRatioAmount = UI::SliderFloat("Aspect Ratio", Setting_AspectRatioAmount, 0.001f, 10.f);
        UI::Text("Current Aspect Ratio: " + (game.camera !is null ? tostring(game.camera.Width_Height) : "?"));
    }
}
#endif