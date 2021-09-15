# Tweaker <sup><sub>Trackmania</sub></sup>
Plugin for OpenPlanet that helps modify in-game hidden settings (mostly visual) and slightly boost the performance.

## Disclaimer
This is a very early version of the plugin so only few features are available for now.

## Features

* Graphics tweaking
    * Render Distance (Z-Clip)
    * Level of Detail (LOD)

## Limitations
* *Render Distance* applies only if you are in the main menu or editor
* *Level of Detail* might differ depending on your graphics preset
* **Fog relies on _Render Distance_**, therefore if fog is increased it might be impossible to see the whole map.
    * Disable *Render Distance* in this case
* ***Level of Detail* value remains even if you disable the plugin**
    * Set `"GeomLodScaleZ"` to `1.00000` at `Documents/Trackmania2020/Config/Default.json` to revert the _LOD_ state

## Download
* [OpenPlanet](https://openplanet.nl/files/126)
* [Releases](https://gitlab.com/DergnNamedSkye/op-tweaker/-/releases)

## Screenshots

![](_git/1.png)
![](_git/2.png)
![](_git/3.png)

## Credits

Project icon provided by [Fork Awesome](https://forkaweso.me/)
