// Background

[Setting name="Background" category="Parameters"]
bool Setting_Sky = true;

[Setting name="Background Color" category="Parameters"]
vec3 Setting_BackgroundColor = vec3(0, 0, 0);

// Clouds

[Setting name="Clouds" category="Parameters"]
bool Setting_Clouds = true;

[Setting name="Clouds Lighting" category="Parameters"]
bool Setting_CloudsLighting = true;

// Lighting

[Setting name="Lighting Color" category="Parameters"]
vec3 Setting_LightingColor = vec3(255, 255, 255);

[Setting name="Lighting Intensity" category="Parameters" min=-1.f max=1.f]
float Setting_LightingIntensity = 1.f;

[Setting name="Lighting Inverse" category="Parameters"]
bool Setting_LightingInverse = false;