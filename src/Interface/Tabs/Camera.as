#if TMNEXT
class CameraTab : Tab {
    string GetLabel() override { return "Camera"; }

    void Render() override
    {
        // Field of View

		if (UI::BeginCombo("Field of View", tostring(Setting_FOV))) {
			if (UI::Selectable("Default", false)) {
				Setting_FOV = FieldOfView::Default;
			}
			if (UI::Selectable("Simple", false)) {
				Setting_FOV = FieldOfView::Simple;
			}
			if (UI::Selectable("Advanced", false)) {
				Setting_FOV = FieldOfView::Advanced;
			}
			UI::EndCombo();
		}

		if (UI::IsItemHovered()) {
			UI::BeginTooltip();
			UI::Text("How wide can camera see");
			UI::EndTooltip();
		}

		if (Setting_FOV == FieldOfView::Simple) {
			Setting_FOVAmount = float(UI::SliderInt("FOV Amount", int(Setting_FOVAmount), Camera::MinimumFOV, Camera::MaximumFOV));
		} else if (Setting_FOV == FieldOfView::Advanced) {
			// Change to proper UI
			UI::Columns(3, "##Field of View Rectangle Min Table", false);
			UI::SetNextItemWidth((UI::GetWindowSize().x / 3) - 16);
			Setting_FOVRect.x = UI::SliderFloat("##FOV Rect Min X", Setting_FOVRect.x, -5.f, 5.f);
			UI::NextColumn();
			UI::SetNextItemWidth((UI::GetWindowSize().x / 3) - 16);
			Setting_FOVRect.y = UI::SliderFloat("##FOV Rect Min Y", Setting_FOVRect.y, -5.f, 5.f);
			UI::NextColumn();
			UI::Text("FovRectMin");
			UI::NextColumn();
			UI::Columns(3, "##Field of View Rectangle Min Table", false);
			UI::SetNextItemWidth((UI::GetWindowSize().x / 3) - 16);
			Setting_FOVRect.z = UI::SliderFloat("##FOV Rect Max X", Setting_FOVRect.z, -5.f, 5.f);
			UI::NextColumn();
			UI::SetNextItemWidth((UI::GetWindowSize().x / 3) - 16);
			Setting_FOVRect.w = UI::SliderFloat("##FOV Rect Max Y", Setting_FOVRect.w, -5.f, 5.f);
			UI::NextColumn();
			UI::Text("FovRectMax");
			UI::Columns(1);
		}

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