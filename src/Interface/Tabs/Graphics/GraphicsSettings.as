// Screen Resolution

[Setting name="Resolution" category="Parameters"]
bool Setting_Resolution = false;

[Setting name="Resolution Vector" category="Parameters"]
vec2 Setting_ResolutionX = vec2(800, 600);

// Draw Distance

[Setting name="ZClip" category="Parameters"]
bool Setting_ZClip = false;

[Setting name="ZClip Distance" category="Parameters" min=1 max=50000]
int Setting_ZClipDistance = 50000;

// Render Mode

[Setting name="Render Mode" category="Parameters"]
RenderMode Setting_RenderMode = RenderMode::Default;

// Render Style

[Setting name="Render Style" category="Parameters"]
RenderType Setting_RenderType = RenderType::Default;

// Shadow Style

[Setting name="Shadow Style" category="Parameters"]
ShadowType Setting_ShadowType = ShadowType::Default;

// Projectors

[Setting name="Projectors" category="Parameters"]
bool Setting_Projectors = true;