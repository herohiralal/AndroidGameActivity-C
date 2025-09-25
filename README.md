# Android Game SDK Source Inclusion

## What's the point?

- Is your primary IDE anything other than fucking Android Studio?
- Do you prefer primarily working in C, over C++?
- Do you prefer not having to deal with package managers and dependency hell?
- Do you prefer single translation unit ("Unity") builds over build system hell?

Congratulations, you're in the right fucking place.
If you think that's too much swearing, I want you to know I've earned it with the kind of pain that modern build systems and package managers have put me through.
Anyway, basically with this library:
- You can work outside Android Studio, because you can just include these files as rawdogged dependencies (pasted into your repo).
- Not _everything_ works with C11, but majority of things do. Scroll down for a list of headers you can use.
  - Also, this library (in its current state) won't free you from having to use a C++ compiler (which Android NDK ships with, btw).
  - There are `*.cpp` source files, that'll need to be built appropriately.
- You don't need to do CMake shenanigans just to get your code to compile+link. Just paste these files in.
  - For an APK/AAB build, you'll obviously still need at least Gradle and have to define `androidx.appcompat:appcompat:1.6.1` and `androidx.games:games-activity:3.0.5` as dependencies.
  - Just don't update your `CMakeLists.txt` file; you can keep it super simple.
- Since you're pasting all the source code anyway, might as well just `#include` all the source files into your single-translation-unit (if you use one).

## What's the original source?

[Here!](https://android.googlesource.com/platform/frameworks/opt/gamesdk/+/b2f7b2462b6969c79f6d6999e3e62816436b3585)

## Example

Attached an example project (bare minimum) that works fine.
Has:
- c/c++ files (from game activity template project)
- CMakeLists.txt
- MainActivity.java
- AndroidManifest.xml
- build.gradle
- gradle-wrapper.properties
- .gitignore
- build.gradle
- gradle.properties
- settings.gradle
(+ whatever gets generated)

## How to update with a new version?

- Select a specific commit (in this case, game-activity & game-text-input 3.0.5).
- Include all the relevant `*.h`/`*.hpp`/`*.c`/`*.cpp` files into the project.
  - will need to go through gamesdk, gametextinput and game-activity separately
  - something else as well, if you need
- Fix up any 'include' errors.
- Fix up any C11 incompatibilities, at least in headers

## C11 Compatibility

Following headers are c11 compatible:
- `android_native_app_glue.h`
- `ChoreographerShim.h`
- `GameActivity.h` // by itself, is compatible, but had to remove `enum` specifiers from a specific function (because of `gametextinput.h` changes)
- `GameActivityEvents.h`
- `gamecommon.h`
- `gamesdk_common.h`
- `gametextinput.h` // had to convert some enums to typedefs + macros

Following headers are NOT c11 compatible:
- `apk_utils.h`
- `jni_helper.h`
- `jni_wrap.h`
- `jnictx.h`
- `JNIUtil.h`
- `Log.h`
- `StringShim.h`
- `system_utils.h`
- `Trace.h`

> Regardless of whatever language you use, will still need C++ compiler because there are C++ source files. :'(

## Next Steps

Ideally, this would all be C compatible, but as it stands right now - it isn't.
If someone wants to help with that, you're most welcome.
