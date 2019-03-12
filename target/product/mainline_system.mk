#
# Copyright (C) 2018 The Android Open Source Project
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
#

# This makefile is the basis of a generic system image for a handheld device.
$(call inherit-product, $(SRC_TARGET_DIR)/product/handheld_system.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/telephony_system.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_default.mk)
# Add adb keys to debuggable AOSP builds (if they exist)
$(call inherit-product-if-exists, vendor/google/security/adb/vendor_key.mk)

# Shared java libs
PRODUCT_PACKAGES += \
    com.android.nfc_extras \

# Applications
PRODUCT_PACKAGES += \
    LiveWallpapersPicker \
    PartnerBookmarksProvider \
    PresencePolling \
    RcsService \
    SafetyRegulatoryInfo \
    Stk \
    Tag \
    TimeZoneUpdater \

# Binaries
PRODUCT_PACKAGES += llkd

# OTA support
PRODUCT_PACKAGES += \
    recovery-refresh \
    update_engine \
    update_verifier \

# Wrapped net utils for /vendor access.
PRODUCT_PACKAGES += netutils-wrapper-1.0

# Charger images
PRODUCT_PACKAGES += charger_res_images

# system_other support
PRODUCT_PACKAGES += \
    cppreopts.sh \
    otapreopt_script \

# Bluetooth libraries
PRODUCT_PACKAGES += \
    audio.a2dp.default \
    audio.hearing_aid.default \

# Media libraries
# - These libraries are used by the new media code path that relies on new
#   plugins and HAL implementations that may not exist on older devices.
PRODUCT_PACKAGES += \
    com.android.media.swcodec \
    libsfplugin_ccodec \

# For ringtones that rely on forward lock encryption
PRODUCT_PACKAGES += libfwdlockengine

# System libraries commonly depended on by things on the product partition.
# This list will be pruned periodically.
PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint@2.1 \
    android.hardware.radio@1.0 \
    android.hardware.radio@1.1 \
    android.hardware.radio@1.2 \
    android.hardware.radio.config@1.0 \
    android.hardware.radio.deprecated@1.0 \
    android.hardware.secure_element@1.0 \
    android.hardware.wifi@1.0 \
    libaudio-resampler \
    liblogwrap \
    liblz4 \
    libminui \
    libnl \
    libprotobuf-cpp-full \
    libprotobuf-cpp-full-rtti \

PRODUCT_PACKAGES_DEBUG += \
    avbctl \
    bootctl \
    tinyplay \
    tinycap \
    tinymix \
    tinypcminfo \
    update_engine_client \

PRODUCT_HOST_PACKAGES += \
    tinyplay

# Enable stats logging in LMKD
TARGET_LMKD_STATS_LOG := true
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.lmk.log_stats=true

# Enable dynamic partition size
PRODUCT_USE_DYNAMIC_PARTITION_SIZE := true

PRODUCT_NAME := mainline_system
PRODUCT_BRAND := generic

_base_mk_whitelist :=

_my_whitelist := $(_base_mk_whitelist)

# For mainline, system.img should be mounted at /, so we include ROOT here.
_my_paths := \
  $(TARGET_COPY_OUT_ROOT)/ \
  $(TARGET_COPY_OUT_SYSTEM)/ \

$(call require-artifacts-in-path, $(_my_paths), $(_my_whitelist))
