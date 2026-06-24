#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Partitions
BOARD_SUPER_PARTITION_SIZE := 17062428672

# Include the common OEM chipset BoardConfig.
include device/oneplus/sm8850-common/BoardConfigCommon.mk

DEVICE_PATH := device/oneplus/infiniti

# SELinux
BOARD_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/vendor
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/private

# Assert
TARGET_OTA_ASSERT_DEVICE := OP60FFL1,OP611FL1

# Display
TARGET_SCREEN_DENSITY := 560

# Kernel
TARGET_KERNEL_BAZEL_FLAGS += --//vendor/oneplus/sm8850:dtbo_config=//vendor/oneplus/sm8850-devicetrees:infiniti_dtbo_config
TARGET_KERNEL_BAZEL_FLAGS += --//build/kernel/kleaf:defconfig_fragment=//common:arch/arm64/configs/infiniti.fragment

# Properties
TARGET_ODM_PROP += $(DEVICE_PATH)/properties/odm.prop
TARGET_SYSTEM_EXT_PROP += $(DEVICE_PATH)/properties/system_ext.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/properties/vendor.prop

# Recovery
TARGET_RECOVERY_DENSITY := xxhdpi
TARGET_RECOVERY_UI_MARGIN_HEIGHT := 103

# Include the proprietary files BoardConfig.
include vendor/oneplus/infiniti/BoardConfigVendor.mk

# Camera (OPlus camera port) - OEM camera sets vendor props outside the standard namespace.
BUILD_BROKEN_VENDOR_PROPERTY_NAMESPACE := true

# OOS night bursts return RAW frames with non-monotonic sensor timestamps.
# Preserve those timestamps for APS matching instead of dropping valid frames.
$(call soong_config_set,cameraservice,allow_nonincreasing_timestamps,true)
