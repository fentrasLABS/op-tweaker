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
			// Change to proper UI and add position/zoom picker
			UI::Columns(3, "##Field of View Rectangle Min Table", false);
			UI::SetNextItemWidth((UI::GetWindowSize().x / 3) - 16);
			Setting_FOVRect.x = UI::SliderFloat("##FOV Rect Min X", Setting_FOVRect.x, -10.f, 10.f);
			UI::NextColumn();
			UI::SetNextItemWidth((UI::GetWindowSize().x / 3) - 16);
			Setting_FOVRect.y = UI::SliderFloat("##FOV Rect Min Y", Setting_FOVRect.y, -10.f, Setting_FOVRect.w - 0.001f);
			UI::NextColumn();
			UI::Text("FovRectMin");
			UI::NextColumn();
			UI::Columns(3, "##Field of View Rectangle Min Table", false);
			UI::SetNextItemWidth((UI::GetWindowSize().x / 3) - 16);
			Setting_FOVRect.z = UI::SliderFloat("##FOV Rect Max X", Setting_FOVRect.z, -10.f, 10.f);
			UI::NextColumn();
			UI::SetNextItemWidth((UI::GetWindowSize().x / 3) - 16);
			Setting_FOVRect.w = UI::SliderFloat("##FOV Rect Max Y", Setting_FOVRect.w, Setting_FOVRect.y + 0.001f, 10.f);
			UI::NextColumn();
			UI::Text("FovRectMax");
			UI::Columns(1);
		}

		UI::Separator();
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
		string aspectRatioLabel = "Aspect Ratio (" + (game.camera !is null ? tostring(game.camera.Width_Height) : "?") + ")";
        Setting_AspectRatioAmount = UI::SliderFloat(aspectRatioLabel, Setting_AspectRatioAmount, 0.001f, 10.f);

		UI::Separator();
		// Stereoscopy

		if (UI::BeginCombo("Stereoscopy", tostring(Setting_Stereoscopy).Replace("_", ""))) {
			for (int i = -1; i < 10; i++) {
				if (tostring(Stereoscopy(i)) == tostring(i)) continue; // thanks to NaNInf
				if (tostring(Stereoscopy(i)) == tostring(Stereoscopy::Workaround)) continue; // thanks to NaNInf
				if (UI::Selectable(tostring(Stereoscopy(i)).Replace("_", " "), false)) {
					Setting_Stereoscopy = Stereoscopy(i);
				}
			}
			UI::EndCombo();
		}

		if (Setting_Stereoscopy != Stereoscopy::Disabled) {
			Setting_StereoscopySeparation = UI::SliderFloat("Eye Separation", Setting_StereoscopySeparation, 0, 1.f);
			if (Setting_Stereoscopy == Stereoscopy::Anaglyph) {
				if (UI::BeginCombo("Anaglyph Color", tostring(Setting_StereoscopyColor))) {
					if (UI::Selectable("Default", false)) {
						Setting_StereoscopyColor = StereoscopyColor::Default;
					}
					if (UI::Selectable("Full", false)) {
						Setting_StereoscopyColor = StereoscopyColor::Full;
					}
					if (UI::Selectable("Half", false)) {
						Setting_StereoscopyColor = StereoscopyColor::Half;
					}
					UI::EndCombo();
				}
				if (Setting_StereoscopyColor != StereoscopyColor::Default) {
					Setting_StereoscopyColorFactor = UI::SliderFloat("Grayscale", Setting_StereoscopyColorFactor, 0, 1.f);
				}
			} else {
				if (UI::BeginCombo("Split Ratio", tostring(Setting_StereoscopyRatio))) {
					if (UI::Selectable("Default", false)) {
						Setting_StereoscopyRatio = StereoscopyRatio::Default;
					}
					if (UI::Selectable("Optimized", false)) {
						Setting_StereoscopyRatio = StereoscopyRatio::Optimized;
					}
					UI::EndCombo();
				}
			}
		}
    }
}
#endif