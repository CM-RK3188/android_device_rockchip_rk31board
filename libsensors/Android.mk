# Copyright (C) 2008 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


LOCAL_PATH := $(call my-dir)

# HAL module implemenation, not prelinked, and stored in
# hw/<SENSORS_HARDWARE_MODULE_ID>.<ro.product.board>.so

include $(CLEAR_VARS)
LOCAL_MODULE := sensors.$(TARGET_BOARD_HARDWARE)
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
LOCAL_MODULE_TAGS := optional
LOCAL_CFLAGS := -DLOG_TAG=\"SensorsHal\" -DPLATFORM_SDK_VERSION=$(PLATFORM_SDK_VERSION)

LOCAL_SRC_FILES := sensors.c nusensors.cpp InputEventReader.cpp	SensorBase.cpp MmaSensor.cpp
LOCAL_SHARED_LIBRARIES := liblog libcutils libutils
LOCAL_PRELINK_MODULE := false

ifeq ($(strip $(BOARD_SENSOR_ANGLE)), true)
LOCAL_CFLAGS += -DANGLE_SUPPORT
endif

ifeq ($(strip $(BOARD_SENSOR_CALIBRATION)), true)
LOCAL_CFLAGS += -DCALIBRATION_SUPPORT
endif

include $(BUILD_SHARED_LIBRARY)
