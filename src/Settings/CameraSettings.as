#if TMNEXT
namespace Camera
{
    const int MinimumFOV = 1;
    const int MaximumFOV = 175;
}

// Field of View

[Setting name="Field of View" category="Parameters"]
FieldOfView Setting_FOV = FieldOfView::Default;

[Setting name="Field of View Amount" category="Parameters"]
float Setting_FOVAmount = 75.f;

[Setting name="Field of View Rectangle" category="Parameters"]
vec4 Setting_FOVRect = vec4(-1.f, -1.f, 1.f, 1.f);

// Camera Ratio

[Setting name="Ratio Priority" category="Parameters"]
RatioPriority Setting_RatioPriority = RatioPriority::Vertical;

[Setting name="Aspect Ratio" category="Parameters"]
bool Setting_AspectRatio = false;

[Setting name="Aspect Ratio Amount" category="Parameters"]
float Setting_AspectRatioAmount = 1.333f; // 16:9

// Quick Zoom

[Setting name="Quick Zoom" category="Parameters"]
QuickZoom Setting_QuickZoom = QuickZoom::Disabled;

[Setting name="Quick Zoom Amount" category="Parameters"]
int Setting_QuickZoomAmount = 50;

[Setting name="Quick Zoom Shortcut" category="Parameters"]
Shortcut Setting_QuickZoomShortcut = Shortcut::Disabled;

[Setting name="Quick Zoom Shortcut Key" category="Parameters"]
VirtualKey Setting_QuickZoomShortcutKey= VirtualKey::Z;

// enums

enum FieldOfView
{
    Default,
    Simple,
    Advanced
}

enum RatioPriority
{
    Vertical,
    Horizontal
}

enum QuickZoom
{
    Disabled,
    Simple,
    Advanced
}
#endif