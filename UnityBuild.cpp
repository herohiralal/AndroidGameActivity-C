_Pragma("clang diagnostic push")
_Pragma("clang diagnostic ignored \"-Weverything\"")

// doing these shenanigans to avoid some redefinition warnings
#include "game-activity/Log.h"
#include "game-activity/system_utils.cpp"
#include "game-activity/jnictx.cpp"
#undef LOG_TAG
#include "game-activity/jni_helper.cpp"
#include "game-activity/jni_wrap.cpp"
#include "game-activity/apk_utils.cpp"
#undef LOG_TAG
#include "game-activity/gametextinput.cpp"
#undef LOG_TAG
#define LOG_TAG "GameActivity"
#undef ALOGV
#undef ALOGW
#undef ALOGE
#include "game-activity/GameActivityLog.h"
#include "game-activity/GameActivityEvents.cpp"
#include "game-activity/GameActivity.cpp"
#undef LOG_TAG

_Pragma("clang diagnostic pop")
