@echo off

SetLocal EnableDelayedExpansion

if "!ANDROID_NDK_HOME!" equ "" (
    if not defined JAVA_HOME (
        set "JAVA_HOME=%ProgramFiles%\Android\Android Studio\jbr"
        if not exist "!JAVA_HOME!" (
            set "JAVA_HOME=%ProgramFiles(x86)%\Android\Android Studio\jbr"
            if not exist "!JAVA_HOME!" (
                set JAVA_HOME=
            )
        )
    )
    if exist "%LOCALAPPDATA%\Android\Sdk" (
        set ANDROID_SDK_ROOT=%LOCALAPPDATA%\Android\Sdk
        set ANDROID_HOME=!ANDROID_SDK_ROOT!

        if exist "!ANDROID_HOME!\ndk" (
            for /d %%i in ("!ANDROID_HOME!\ndk\*") do set ANDROID_NDK_HOME=%%i
        )

        if "!ANDROID_NDK_HOME!" neq "" (
            set ANDROID_TOOLCHAIN=!ANDROID_NDK_HOME!
            set ANDROID_TOOLCHAIN_FOUND=1
        )
    )
)

if "%ANDROID_TOOLCHAIN_FOUND%" neq "1" (
    echo.
    echo ERROR: Couldn't find Android NDK.
    exit /b 1
)

echo Using Android NDK: %ANDROID_TOOLCHAIN%

if not exist .\Temp mkdir .\Temp
if not exist .\Temp\x86 mkdir .\Temp\x86
if not exist .\Temp\x86_64 mkdir .\Temp\x86_64
if not exist .\Temp\armeabi-v7a mkdir .\Temp\armeabi-v7a
if not exist .\Temp\arm64-v8a mkdir .\Temp\arm64-v8a

echo.
echo Building Android-x86
%ANDROID_TOOLCHAIN%\toolchains\llvm\prebuilt\windows-x86_64\bin\clang.exe -g -O0 -DDEBUG -DANDROID=1 -D_FORTIFY_SOURCE=2 -std=c11 --sysroot=%ANDROID_TOOLCHAIN%\toolchains\llvm\prebuilt\windows-x86_64\sysroot\ -fPIC --target=i686-none-linux-android30 ./UnityBuild.c -o ./Temp/x86/GameSDKC.o -c
%ANDROID_TOOLCHAIN%\toolchains\llvm\prebuilt\windows-x86_64\bin\clang++.exe -g -O0 -DDEBUG -DANDROID=1 -D_FORTIFY_SOURCE=2 -std=c++14 --sysroot=%ANDROID_TOOLCHAIN%\toolchains\llvm\prebuilt\windows-x86_64\sysroot\ -fPIC --target=i686-none-linux-android30 ./UnityBuild.cpp -o ./Temp/x86/GameSDKCxx.o -c
%ANDROID_TOOLCHAIN%\toolchains\llvm\prebuilt\windows-x86_64\bin\clang++.exe --sysroot=%ANDROID_TOOLCHAIN%\toolchains\llvm\prebuilt\windows-x86_64\sysroot\ -fPIC --target=i686-none-linux-android30 ./Temp/x86/GameSDKC.o ./Temp/x86/GameSDKCxx.o -o ./Temp/x86/GameSDKCxx.so -llog -landroid -shared -u Java_com_google_androidgamesdk_GameActivity_initializeNativeCode
if %ErrorLevel% equ 0 (
    echo Build succeeded.
) else (
    echo Build failed.
)

echo.
echo Building Android-x86_64
%ANDROID_TOOLCHAIN%\toolchains\llvm\prebuilt\windows-x86_64\bin\clang.exe -g -O0 -DDEBUG -DANDROID=1 -D_FORTIFY_SOURCE=2 -std=c11 --sysroot=%ANDROID_TOOLCHAIN%\toolchains\llvm\prebuilt\windows-x86_64\sysroot\ -fPIC --target=x86_64-none-linux-android30 ./UnityBuild.c -o ./Temp/x86_64/GameSDKC.o -c
%ANDROID_TOOLCHAIN%\toolchains\llvm\prebuilt\windows-x86_64\bin\clang++.exe -g -O0 -DDEBUG -DANDROID=1 -D_FORTIFY_SOURCE=2 -std=c++14 --sysroot=%ANDROID_TOOLCHAIN%\toolchains\llvm\prebuilt\windows-x86_64\sysroot\ -fPIC --target=x86_64-none-linux-android30 ./UnityBuild.cpp -o ./Temp/x86_64/GameSDKCxx.o -c
%ANDROID_TOOLCHAIN%\toolchains\llvm\prebuilt\windows-x86_64\bin\clang++.exe --sysroot=%ANDROID_TOOLCHAIN%\toolchains\llvm\prebuilt\windows-x86_64\sysroot\ -fPIC --target=x86_64-none-linux-android30 ./Temp/x86_64/GameSDKC.o ./Temp/x86_64/GameSDKCxx.o -o ./Temp/x86_64/GameSDKCxx.so -llog -landroid -shared -u Java_com_google_androidgamesdk_GameActivity_initializeNativeCode
if %ErrorLevel% equ 0 (
    echo Build succeeded.
) else (
    echo Build failed.
)

echo.
echo Building Android-armeabi-v7a
%ANDROID_TOOLCHAIN%\toolchains\llvm\prebuilt\windows-x86_64\bin\clang.exe -g -O0 -DDEBUG -DANDROID=1 -D_FORTIFY_SOURCE=2 -std=c11 --sysroot=%ANDROID_TOOLCHAIN%\toolchains\llvm\prebuilt\windows-x86_64\sysroot\ -fPIC --target=armv7a-none-linux-androideabi30 ./UnityBuild.c -o ./Temp/armeabi-v7a/GameSDKC.o -c
%ANDROID_TOOLCHAIN%\toolchains\llvm\prebuilt\windows-x86_64\bin\clang++.exe -g -O0 -DDEBUG -DANDROID=1 -D_FORTIFY_SOURCE=2 -std=c++14 --sysroot=%ANDROID_TOOLCHAIN%\toolchains\llvm\prebuilt\windows-x86_64\sysroot\ -fPIC --target=armv7a-none-linux-androideabi30 ./UnityBuild.cpp -o ./Temp/armeabi-v7a/GameSDKCxx.o -c
%ANDROID_TOOLCHAIN%\toolchains\llvm\prebuilt\windows-x86_64\bin\clang++.exe --sysroot=%ANDROID_TOOLCHAIN%\toolchains\llvm\prebuilt\windows-x86_64\sysroot\ -fPIC --target=armv7a-none-linux-androideabi30 ./Temp/armeabi-v7a/GameSDKC.o ./Temp/armeabi-v7a/GameSDKCxx.o -o ./Temp/armeabi-v7a/GameSDKCxx.so -llog -landroid -shared -u Java_com_google_androidgamesdk_GameActivity_initializeNativeCode
if %ErrorLevel% equ 0 (
    echo Build succeeded.
) else (
    echo Build failed.
)

echo.
echo Building Android-arm64-v8a
%ANDROID_TOOLCHAIN%\toolchains\llvm\prebuilt\windows-x86_64\bin\clang.exe -g -O0 -DDEBUG -DANDROID=1 -D_FORTIFY_SOURCE=2 -std=c11 --sysroot=%ANDROID_TOOLCHAIN%\toolchains\llvm\prebuilt\windows-x86_64\sysroot\ -fPIC --target=aarch64-none-linux-android30 ./UnityBuild.c -o ./Temp/arm64-v8a/GameSDKC.o -c
%ANDROID_TOOLCHAIN%\toolchains\llvm\prebuilt\windows-x86_64\bin\clang++.exe -g -O0 -DDEBUG -DANDROID=1 -D_FORTIFY_SOURCE=2 -std=c++14 --sysroot=%ANDROID_TOOLCHAIN%\toolchains\llvm\prebuilt\windows-x86_64\sysroot\ -fPIC --target=aarch64-none-linux-android30 ./UnityBuild.cpp -o ./Temp/arm64-v8a/GameSDKCxx.o -c
%ANDROID_TOOLCHAIN%\toolchains\llvm\prebuilt\windows-x86_64\bin\clang++.exe --sysroot=%ANDROID_TOOLCHAIN%\toolchains\llvm\prebuilt\windows-x86_64\sysroot\ -fPIC --target=aarch64-none-linux-android30 ./Temp/arm64-v8a/GameSDKC.o ./Temp/arm64-v8a/GameSDKCxx.o -o ./Temp/arm64-v8a/GameSDKCxx.so -llog -landroid -shared -u Java_com_google_androidgamesdk_GameActivity_initializeNativeCode
if %ErrorLevel% equ 0 (
    echo Build succeeded.
) else (
    echo Build failed.
)
