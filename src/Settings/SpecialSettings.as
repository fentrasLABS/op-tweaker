#if TMNEXT
// Wipeout Mode

[Setting name="Wipeout Mode" category="Parameters"]
bool Setting_Wipeout = false;

[Setting name="Maximum Field of View Amount" category="Parameters"]
float Setting_WipeoutMax = 150.f;

// Quick Zoom

[Setting name="Quick Zoom" category="Parameters"]
QuickZoom Setting_QuickZoom = QuickZoom::Disabled;

[Setting name="Quick Zoom Amount" category="Parameters"]
float Setting_QuickZoomAmount = 50.f;

[Setting name="Quick Zoom Shortcut" category="Parameters"]
Shortcut Setting_QuickZoomShortcut = Shortcut::Disabled;

[Setting name="Quick Zoom Shortcut Key" category="Parameters"]
VirtualKey Setting_QuickZoomShortcutKey= VirtualKey::Z;

enum QuickZoom
{
    Disabled,
    Simple
    // Advanced
}
#endif