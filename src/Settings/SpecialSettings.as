#if TMNEXT
namespace QuickZoom
{
    const float MinimumAmount = 1.f;
    const float MaximumAmount = 100.f;
}

// Wipeout Mode

[Setting name="Wipeout Mode" category="Parameters"]
bool Setting_Wipeout = false;

[Setting name="Maximum Field of View Amount" category="Parameters"]
float Setting_WipeoutMax = 150.f;

// Quick Zoom

[Setting name="Quick Zoom" category="Parameters"]
QuickZoom Setting_QuickZoom = QuickZoom::Disabled;

[Setting name="Quick Zoom Active" category="Parameters"]
bool Setting_QuickZoomActive = false;

[Setting name="Quick Zoom Simple Amount" category="Parameters"]
float Setting_QuickZoomSimpleAmount = 50.f;

[Setting name="Quick Zoom Advanced Amount" category="Parameters"]
float Setting_QuickZoomAdvancedAmount = 2.f;

[Setting name="Quick Zoom Scroll" category="Parameters"]
bool Setting_QuickZoomScroll = false;

[Setting name="Quick Zoom Scroll Multiplier" category="Parameters"]
float Setting_QuickZoomScrollMultiplier = 0.01f;

[Setting name="Quick Zoom Shortcut" category="Parameters"]
Shortcut Setting_QuickZoomShortcut = Shortcut::Disabled;

[Setting name="Quick Zoom Shortcut Key" category="Parameters"]
VirtualKey Setting_QuickZoomShortcutKey= VirtualKey::Z;

enum QuickZoom
{
    Disabled,
    Simple,
    Advanced
}
#endif