
DEVICE_PATH := device/oneplus/wly
HARDWARE_PATH := hardware/oplus

# Setup dalvik vm configs
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# A/B # Boot Control
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_ramdisk.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=ext4 \
    POSTINSTALL_OPTIONAL_vendor=true

PRODUCT_PACKAGES += \
    update_engine \
    update_engine_client \
    update_verifier \
    android.hardware.boot@1.2-impl-qti \
    android.hardware.boot@1.2-impl-qti.recovery \
    android.hardware.boot@1.2-service

PRODUCT_PACKAGES += \
    checkpoint_gc \
    otapreopt_script \
    update_engine_sideload

# AAPT
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

# API
#BOARD_API_LEVEL := 31
BOARD_SHIPPING_API_LEVEL := 31
PRODUCT_SHIPPING_API_LEVEL := 32
SHIPPING_API_LEVEL := 32

# Audio
AUDIO_HAL_DIR := vendor/qcom/opensource/audio-hal/primary-hal
QCV_FAMILY_SKUS := taro

PRODUCT_PACKAGES += \
    android.hardware.audio@7.1-impl \
    android.hardware.audio.effect@7.1-impl \
    android.hardware.audio.service \
    android.hardware.audio.sounddose-vendor-impl \
    android.hardware.bluetooth.audio-impl \
    android.hardware.soundtrigger@2.3-impl \
    audio.bluetooth.default \
    libeffectproxy \
    libfmpal \
    libhapticgenerator \
    libldnhncr \
    libreverbwrapper \
    libvisualizer

# Authsecret
PRODUCT_PACKAGES += \
    android.hardware.authsecret@1.0.vendor

# AVB
BOARD_AVB_ENABLE := true

# Biometrics
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.fingerprint.xml

PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint@2.1.vendor

# Camera TODO::::::::::::::::::::::::::::::::::::::::::::::::::::

# DebugFS
PRODUCT_SET_DEBUGFS_RESTRICTIONS := true

TARGET_BOARD_PLATFORM := taro

# Dex
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false
PRODUCT_DEX_PREOPT_DEFAULT_COMPILER_FILTER := everything
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true
USE_DEX2OAT_DEBUG := false

# Display
PRODUCT_PACKAGES += \
    vendor.qti.hardware.display.config-V2-ndk_platform.vendor \
    vendor.qti.hardware.display.config-V5-ndk_platform.vendor \
    vendor.qti.hardware.memtrack-service

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(DEVICE_PATH) \
    hardware/oplus

# Partitions - Dynamic
PRODUCT_BUILD_ODM_IMAGE := true
PRODUCT_USE_DYNAMIC_PARTITIONS := true

PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock \
    fastbootd

# Partitions - FRP
BOARD_FRP_PARTITION_NAME := frp

# Partitions - Vendor
ENABLE_VENDOR_IMAGE := true

# QRTR
PRODUCT_PACKAGES += \
    qrtr-ns \
    qrtr-lookup \
    libqrtr

# Power
PRODUCT_PACKAGES += \
    android.hardware.power-service-qti

# Powershare
PRODUCT_PACKAGES += \
    vendor.aospa.powershare-service

# QTI Components
TARGET_COMMON_QTI_COMPONENTS := \
    adreno \
    alarm \
    audio \
    av \
    bt \
    display \
    gps \
    init \
    media \
    nfc \
    overlay \
    perf \
    telephony \
    usb \
    vibrator \
    wfd \
    wlan

# ANT+
PRODUCT_PACKAGES += \
    com.dsi.ant@1.0.vendor

# Dex
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false
PRODUCT_DEX_PREOPT_DEFAULT_COMPILER_FILTER := everything
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true
USE_DEX2OAT_DEBUG := false

# Characteristics
PRODUCT_CHARACTERISTICS := nosdcard

# ParanoidDoze
#PRODUCT_PACKAGES += \
#    ParanoidDoze

PRODUCT_SYSTEM_EXT_PROPERTIES += \
    ro.sensor.pickup=android.sensor.tilt_detector \
    ro.sensor.pickup.value=0

# DRM
PRODUCT_PACKAGES += \
    android.hardware.drm-service.clearkey \
    android.hardware.drm@1.4.vendor

# Filesystem
PRODUCT_PACKAGES += \
    fs_config_files

# Fastboot
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl.custom \
    fastbootd

# Fingerprint
PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint@2.3-service.oplus \
    libshims_fingerprint.oplus

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.fingerprint.xml

# Gatekeeper
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0.vendor

# GPS
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/gps/gps.conf:$(TARGET_COPY_OUT_VENDOR)/etc/gps.conf

PRODUCT_PACKAGES += \
    android.hardware.gnss-V1-ndk_platform.vendor

# Health
$(call inherit-product, vendor/qcom/opensource/healthd-ext/health-vendor-product.mk)

PRODUCT_PACKAGES += \
    android.hardware.health@1.0.vendor \
    android.hardware.health@2.1.vendor

# Init
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init/fstab.qcom:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.qcom

PRODUCT_PACKAGES += \
    fstab.qcom \
    init.target.rc \
    init.oplus.rc \
    ueventd.oplus.rc

# HIDL - FCM 
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += \
   $(DEVICE_PATH)/configs/vintf/framework_compatibility_matrix.xml

DEVICE_MANIFEST_FILE += \
    $(DEVICE_PATH)/configs/vintf/taro_manifest.xml \
    $(DEVICE_PATH)/configs/vintf/wly_manifest.xml

# Keymaster
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.keystore.app_attest_key.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.keystore.app_attest_key.xml

PRODUCT_PACKAGES += \
    android.hardware.hardware_keystore.xml \
    android.hardware.keymaster@4.1.vendor \
    libkeymaster_messages.vendor

# Keymint
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.device_id_attestation.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.device_id_attestation.xml

PRODUCT_PACKAGES += \
    android.hardware.security.keymint-V1-ndk_platform.vendor \
    android.hardware.security.rkp-V3-ndk.vendor \
    android.hardware.security.secureclock-V1-ndk_platform.vendor \
    android.hardware.security.sharedsecret-V1-ndk_platform.vendor

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.keystore.app_attest_key.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.keystore.app_attest_key.xml \
    frameworks/native/data/etc/android.software.device_id_attestation.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.device_id_attestation.xml

# Graphics
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml \
    frameworks/native/data/etc/android.hardware.vulkan.compute-0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.compute-0.xml \
    frameworks/native/data/etc/android.hardware.vulkan.level-1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.level-1.xml \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.version-1_1.xml \
    frameworks/native/data/etc/android.software.opengles.deqp.level-2021-03-01.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.opengles.deqp.level.xml \
    frameworks/native/data/etc/android.software.vulkan.deqp.level-2021-03-01.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.vulkan.deqp.level.xml

# Identity
PRODUCT_PACKAGES += \
    android.hardware.identity-V3-ndk.vendor

# Media
PRODUCT_PACKAGES += \
    libavservices_minijail_vendor \
    libcodec2_hidl@1.2.vendor \
    libcodec2_soft_common.vendor \
    libsfplugin_ccodec_utils.vendor

# Kernel
KERNEL_PREBUILT_DIR := $(DEVICE_PATH)-kernel

# NDK
NEED_AIDL_NDK_PLATFORM_BACKEND := true

# Net
PRODUCT_PACKAGES += \
    android.system.net.netd@1.1.vendor

# Neural network
PRODUCT_PACKAGES += \
    android.hardware.neuralnetworks@1.3.vendor

# OMX
PRODUCT_PACKAGES += \
    libOmxCore \
    libstagefrighthw

# Overlays
PRODUCT_PACKAGES += \
    OPlusCarrierConfig \
    OPlusFrameworks \
    OplusNfc \
    OPlusSettings \
    OplusSettingsProvider \
    OplusSystemUI

# Protobuf
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full-3.9.1-vendorcompat \
    libprotobuf-cpp-lite-3.9.1-vendorcompat

# QMI
PRODUCT_PACKAGES += \
    libcurl.vendor:64 \
    libjson \
    libjsoncpp.vendor \
    libqti_vndfwk_detect_vendor \
    libsqlite.vendor:64 \
    libvndfwk_detect_jni.qti.vendor

# QTI service tracker
PRODUCT_PACKAGES += \
    vendor.qti.hardware.servicetracker@1.2.vendor

# Sensors
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.ambient_temperature.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.ambient_temperature.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.hifi_sensors.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.hifi_sensors.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.relative_humidity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.relative_humidity.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepdetector.xml

PRODUCT_PACKAGES += \
    android.frameworks.sensorservice@1.0.vendor \
    android.hardware.sensors@2.1-service.oplus-multihal \
    libsensorndkbridge

# Emulated Storage
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Thermal
PRODUCT_PACKAGES += \
    android.hardware.thermal@2.0-service.qti-v2

# Suspend
PRODUCT_PACKAGES += \
    libsuspend

# Touch
PRODUCT_PACKAGES += \
    vendor.lineage.touch@1.0-service.oplus
    
# USB
PRODUCT_HAS_GADGET_HAL := true

# TrustedUI
PRODUCT_PACKAGES += \
    android.hidl.memory.block@1.0.vendor \
    vendor.qti.hardware.systemhelper@1.0.vendor


# Inherit from the proprietary files makefile.
$(call inherit-product, vendor/oneplus/wly/wly-vendor.mk)
