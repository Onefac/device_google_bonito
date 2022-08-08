#
# Copyright (C) 2020-2021 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Kernel
BOARD_KERNEL_IMAGE_NAME := Image.gz
TARGET_COMPILE_WITH_MSM_KERNEL := true
TARGET_KERNEL_CLANG_VERSION := r547379
TARGET_KERNEL_CLANG_PATH := $(abspath .)/prebuilts/clang/host/$(HOST_PREBUILT_TAG)/clang-$(TARGET_KERNEL_CLANG_VERSION)
TARGET_KERNEL_CONFIG := vendor/sdm670-perf_defconfig vendor/b4s4.config
TARGET_KERNEL_ADDITIONAL_FLAGS := LLVM=1 LLVM_IAS=1 KCFLAGS=-Wno-unused-function
TARGET_KERNEL_SOURCE := kernel/google/sdm670
TARGET_KERNEL_VERSION := 4.19

BOARD_KERNEL_SEPARATED_DTBO := true
BOARD_DTBO_CFG := $(TARGET_KERNEL_SOURCE)/arch/arm64/boot/dts/google/dtboimg.cfg

# Manifests
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += \
    hardware/qcom-caf/common/vendor_framework_compatibility_matrix.xml \
    hardware/qcom-caf/common/vendor_framework_compatibility_matrix_legacy.xml

# Partitions
AB_OTA_PARTITIONS += \
    vendor
ifneq ($(PRODUCT_USE_DYNAMIC_PARTITIONS), true)
    BOARD_VENDORIMAGE_PARTITION_SIZE := 805306368
endif
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4

# Reserve space for gapps install
-include vendor/lineage/config/BoardConfigReservedSize.mk
ifneq ($(WITH_GMS),true)
BOARD_PRODUCTIMAGE_PARTITION_RESERVED_SIZE := 943718400
endif

# SELinux
BOARD_SEPOLICY_DIRS += device/google/bonito/sepolicy-lineage/dynamic
BOARD_SEPOLICY_DIRS += device/google/bonito/sepolicy-lineage/vendor
include device/lineage/sepolicy/libperfmgr/sepolicy.mk

# Verified Boot
ifneq (,$(AVB_CUSTOM_KEY_PATH))
BOARD_AVB_ALGORITHM := $(AVB_CUSTOM_ALGORITHM)
BOARD_AVB_KEY_PATH := $(AVB_CUSTOM_KEY_PATH)
endif

ifneq ($(WITH_AVB),true)
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
endif
