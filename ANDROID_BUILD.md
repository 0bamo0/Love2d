# Android Build

## Quick test on a phone

Run:

```bat
.\build-android-love.cmd
```

This creates:

```text
dist/love2d-game.love
```

Install the official LOVE for Android app, then open `love2d-game.love` on the phone.

## Building an APK or AAB

The official LOVE Android project requires:

- JDK 17
- Android SDK API 34
- Android NDK 26.1.10909125
- CMake 3.21 or newer

Clone LOVE Android with submodules:

```bat
git clone --recurse-submodules https://github.com/love2d/love-android
```

To embed this game, copy `dist/love2d-game.love` to:

```text
love-android/app/src/embed/assets/game.love
```

Then build one of these from the LOVE Android repository:

```bat
gradlew assembleEmbedNoRecordRelease
gradlew bundleEmbedNoRecordRelease
```

Use the APK for direct install/testing, or the AAB for Google Play upload.
