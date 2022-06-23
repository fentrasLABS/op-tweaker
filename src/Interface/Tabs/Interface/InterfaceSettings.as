// FPS Counter

[Setting name="FPS Counter" category="Parameters"]
bool Setting_FPS = false;

[Setting name="FPS Counter Smoothing" category="Parameters"]
FPSCounterSmoothing Setting_FPSSmoothing = FPSCounterSmoothing::Disabled;

enum FPSCounterSmoothing
{
    None
}