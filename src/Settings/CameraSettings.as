#if TMNEXT
namespace Camera
{
    const int MinimumFOV = 1;
    const int MaximumFOV = 175;
    const int DefaultFOV = 75;

    const int MinimumRectFOV = 1;
    const int MaximumRectFOV = 100;
    const vec4 DefaultRectFOV = vec4(-1.f, -1.f, 1.f, 1.f);
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

// Stereoscopy

[Setting name="Stereoscopy" category="Parameters"]
Stereoscopy Setting_Stereoscopy = Stereoscopy::Disabled;

[Setting name="Stereoscopy Separation" category="Parameters"]
float Setting_StereoscopySeparation = .150f;

[Setting name="Stereoscopy Ratio" category="Parameters"]
StereoscopyRatio Setting_StereoscopyRatio = StereoscopyRatio::Default;

[Setting name="Stereoscopy Color" category="Parameters"]
StereoscopyColor Setting_StereoscopyColor = StereoscopyColor::Optimized;

[Setting name="Stereoscopy Color Factor" category="Parameters"]
float Setting_StereoscopyColorFactor = 1.f;

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

enum Stereoscopy
{
    Disabled = -1,
    Anaglyph = 2,
    Vertical = 0,
    Vertical_Reverse = 1,
    Horizontal = 3,
    Horizontal_Reverse = 4,
    Blend = 10,
    Workaround = 9
}

enum StereoscopyRatio
{
    Default,
    Optimized
}

enum StereoscopyColor
{
    Optimized = 2,
    Full = 0,
    Half = 1
}
#endif