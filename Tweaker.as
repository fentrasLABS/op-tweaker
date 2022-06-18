CSystemConfigDisplay@ display = null;
CSystemConfigDisplay@ displaySafe = null;

dictionary defaults = {};

void ApplySettings()
{
	if (Setting_ZClip_Enabled) {
		switch(Setting_ZClip) {
			case ZClip::Disabled:
				display.ZClip = CSystemConfigDisplay::EZClip::_ZClip_Disable;
				break;
			case ZClip::Near:
				display.ZClipAuto = CSystemConfigDisplay::EZClipAuto::_ZClipAuto_Near;
			case ZClip::Medium:
				display.ZClipAuto = CSystemConfigDisplay::EZClipAuto::_ZClipAuto_Medium;
			case ZClip::Far:
				display.ZClipAuto = CSystemConfigDisplay::EZClipAuto::_ZClipAuto_Far;
				display.ZClip = CSystemConfigDisplay::EZClip::_ZClip_Auto;
				break;
			case ZClip::Custom:
				display.ZClip = CSystemConfigDisplay::EZClip::_ZClip_Fixed;
				display.ZClipNbBlock = Setting_ZClip_Distance;
				break;
		}
	} else {
		display.ZClip = CSystemConfigDisplay::EZClip(defaults['ZClip']);
		display.ZClipAuto = CSystemConfigDisplay::EZClipAuto(defaults['ZClipAuto']);
		display.ZClipNbBlock = int(defaults['ZClipNbBlock']);
	}

	if (Setting_GeometryQuality_Enabled) {
		display.GeomLodScaleZ = Setting_GeometryQuality_Distance;
	} else {
		display.GeomLodScaleZ = float(defaults['GeomLodScaleZ']);
	}
}

void SetDefaults()
{
	defaults.Set("ZClip", displaySafe.ZClip);
	defaults.Set("ZClipAuto", displaySafe.ZClipAuto);
	defaults.Set("ZClipNbBlock", displaySafe.ZClipNbBlock);
	defaults.Set("GeomLodScaleZ", displaySafe.GeomLodScaleZ);
}

void Reset()
{
	Setting_ZClip_Enabled = false;
	Setting_GeometryQuality_Enabled = false;
	ApplySettings();
}

void OnSettingsChanged()
{
	ApplySettings();
}

void OnDestroyed()
{
	Reset();
}

void OnDisabled()
{
	Reset();
}

void Main()
{
	@display = GetApp().Viewport.SystemConfig.Display;
	@displaySafe = GetApp().Viewport.SystemConfig.DisplaySafe;
	SetDefaults();
	ApplySettings();
}