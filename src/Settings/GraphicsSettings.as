// Screen Resolution

[Setting name="Resolution" category="Parameters"]
bool Setting_Resolution = false;

[Setting name="Resolution Width" category="Parameters"]
int Setting_ResolutionWidth = 800;

[Setting name="Resolution Height" category="Parameters"]
int Setting_ResolutionHeight = 600;

[Setting name="Resolution Shortcut" category="Parameters"]
Shortcut Setting_ResolutionShortcut = Shortcut::Disabled;

[Setting name="Resolution Shortcut Key" category="Parameters"]
VirtualKey Setting_ResolutionShortcutKey= VirtualKey::F1;

// Draw Distance

[Setting name="ZClip" category="Parameters"]
bool Setting_ZClip = false;

[Setting name="ZClip Distance" category="Parameters"]
int Setting_ZClipDistance = 5000;

// Level of Detail

[Setting name="Level of Detail" category="Parameters"]
bool Setting_LOD = false;

[Setting name="Level of Detail Distance" category="Parameters"]
float Setting_LODDistance = 1.f;

// Render Mode

[Setting name="Render Mode" category="Parameters"]
RenderMode Setting_RenderMode = RenderMode::Default;

// Lighting Mode

[Setting name="Render Style" category="Parameters"]
LightingMode Setting_LightingMode = LightingMode::Default;

// Projectors

[Setting name="Projectors" category="Parameters"]
bool Setting_Projectors = true;

// enums

enum RenderMode
{
    Default,
    Limited
}

enum LightingMode
{
    Default,
    Minimal
}