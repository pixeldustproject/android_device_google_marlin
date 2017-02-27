# Copyright (C) 2017 The PixelDust Project
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

# Boot animation
TARGET_SCREEN_HEIGHT := 2560
TARGET_SCREEN_WIDTH := 1440

# Include common PixelDust stuff
include vendor/pixeldust/configs/pixeldust_phone.mk

# Inherit AOSP device configuration for marlin
$(call inherit-product, device/google/marlin/aosp_marlin.mk)

# Override AOSP build properties
PRODUCT_NAME := pixeldust_marlin
PRODUCT_BRAND := google
PRODUCT_DEVICE := marlin
PRODUCT_MODEL := Pixel XL
PRODUCT_MANUFACTURER := Google

# Device Fingerprint
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=marlin \
    BUILD_FINGERPRINT=google/marlin/marlin:7.1.1/NOF26W/3637559:user/release-keys \
    PRIVATE_BUILD_DESC="marlin-user 7.1.1 NOF26W 3637559 release-keys"
