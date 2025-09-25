# For more information about using CMake with Android Studio, read the
# documentation: https://d.android.com/studio/projects/add-native-code.html

cmake_minimum_required(VERSION 3.22.1)

project("nativelib")

# Creates your game shared library. The name must be the same as the
# one used for loading in your Kotlin/Java or AndroidManifest.txt files.
add_library(nativelib SHARED
        GameActivitySources.cpp
        GameActivitySourcesC.c
        main.cpp
        AndroidOut.cpp
        Renderer.cpp
        Shader.cpp
        TextureAsset.cpp
        Utility.cpp)

# Forces the linker to keep the JNI entry point for GameActivity
set(CMAKE_SHARED_LINKER_FLAGS
        "${CMAKE_SHARED_LINKER_FLAGS} -u Java_com_google_androidgamesdk_GameActivity_initializeNativeCode")

# Configure libraries CMake uses to link your target library.
target_link_libraries(nativelib
        EGL
        GLESv3
        jnigraphics
        android
        log)

set_source_files_properties(GameActivitySourcesC.c PROPERTIES
        LANGUAGE C
        C_STANDARD 11
)