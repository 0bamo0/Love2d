## How to run on Android :
1- Downlod and install the [Love2d Android from here](https://github.com/love2d/love/releases/tag/11.5)

2- Download the Source zip from [Releases](https://github.com/0bamo0/Love2d/releases)

3- Extarct and Copy files to storage/lovegame :

4- Run the Love2d Game from your launcher.

## Tests
Run the local LOVE test suite on Windows:

```bat
.\run-tests.cmd
```

## Saves
The main game has three save slots. From the in-game pause menu, use `Escape` and choose a save slot. Keyboard shortcuts also work while playing:

```text
F5/F6/F7  Save slots 1/2/3
F9/F10/F11 Load slots 1/2/3
```

## Runner Mode
The main menu has a Runner option for an endless one-button runner mode. Press `Space`, `Up`, or `W` to jump, and press `R` to restart.

## Android Build
Run:

```bat
.\build-android-love.cmd
```

See [ANDROID_BUILD.md](ANDROID_BUILD.md) for APK/AAB notes.
