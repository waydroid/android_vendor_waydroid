LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE            := init.waydroid.rc
LOCAL_MODULE_TAGS       := optional
LOCAL_MODULE_CLASS      := ETC
LOCAL_SRC_FILES         := etc/init.waydroid.rc
LOCAL_MODULE_PATH       := $(TARGET_OUT_ETC)/init
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE            := libnfc-nci.conf
LOCAL_MODULE_TAGS       := optional
LOCAL_MODULE_CLASS      := ETC
LOCAL_SRC_FILES         := etc/libnfc-nci.conf
LOCAL_MODULE_PATH       := $(TARGET_OUT_ETC)
include $(BUILD_PREBUILT)
