// Constants

const int RESOLUTION_MIN = 16;
const int RESOLUTION_WIDTH_MAX = 15360;
const int RESOLUTION_HEIGHT_MAX = 4316;

// Global Settings

enum Shortcut
{
    Disabled,
    Hold,
    Toggle
}

// Graphics Settings

enum RenderMode
{
    Default,
    Limited,
    LimitedWithPilot
}

enum RenderType
{
    Default,
    OnlyEffects,
    Minimal
}

enum ShadowType
{
    Default,
    ParallelSplitShadowMaps
}

// Camera Settings

enum FieldOfView
{
    Default,
    Simple,
    Advanced
}

enum QuickZoom
{
    Disabled,
    Simple,
    Advanced
}