#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=wly
VENDOR=oneplus

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

KANG=
SECTION=

while [ "${#}" -gt 0 ]; do
    case "${1}" in
        -n | --no-cleanup )
                CLEAN_VENDOR=false
                ;;
        -k | --kang )
                KANG="--kang"
                ;;
        -s | --section )
                SECTION="${2}"; shift
                CLEAN_VENDOR=false
                ;;
        * )
                SRC="${1}"
                ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC="adb"
fi

function blob_fixup() {
    case "${1}" in
        odm/bin/hw/vendor.oplus.hardware.biometrics.fingerprint@2.1-service)
            grep -q libshims_fingerprint.oplus.so "${2}" || "${PATCHELF}" --add-needed libshims_fingerprint.oplus.so "${2}"
            ;;
        odm/etc/vintf/manifest/manifest_oplus_fingerprint.xml)
            sed -ni "/android.hardware.biometrics.fingerprint/{x;s/hal format/hal override=\"true\" format/;x};x;1!p;\${x;p}" "${2}"
            ;;
        odm/bin/hw/vendor.pixelworks.hardware.display.iris-service)
            grep -q "libprocessgroup.so" "${2}" || "${PATCHELF}" --add-needed "libprocessgroup.so" "${2}"
            ;;
        odm/etc/camera/CameraHWConfiguration.config)
            sed -i "/SystemCamera = / s/1;/0;/g" "${2}"
            sed -i "/SystemCamera = / s/0;$/1;/" "${2}"
            ;;
        product/etc/sysconfig/com.android.hotwordenrollment.common.util.xml)
            sed -i "s/\/my_product/\/product/" "${2}"
            ;;
        system_ext/lib64/libwfdnative.so)
            sed -i "s/android.hidl.base@1.0.so/libhidlbase.so\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00/" "${2}"
            ;;
        vendor/etc/media_*/video_system_specs.json)
            sed -i "/max_retry_alloc_output_timeout/ s/2000/0/" "${2}"
            ;;
        vendor/etc/libnfc-nci.conf)
            sed -i "s/NFC_DEBUG_ENABLED=1/NFC_DEBUG_ENABLED=0/" "${2}"
            ;;
        vendor/etc/libnfc-nxp.conf)
            sed -i "/NXPLOG_\w\+_LOGLEVEL/ s/0x03/0x02/" "${2}"
            sed -i "s/NFC_DEBUG_ENABLED=1/NFC_DEBUG_ENABLED=0/" "${2}"
            ;;
        vendor/bin/hw/android.hardware.security.keymint-service-qti)
            grep -q "android.hardware.security.rkp-V3-ndk.so" "${2}" || ${PATCHELF} --add-needed "android.hardware.security.rkp-V3-ndk.so" "${2}"
            ;;
        vendor/etc/media_codecs.xml|vendor/etc/media_codecs_cape.xml|vendor/etc/media_codecs_cape_vendor.xml|vendor/etc/media_codecs_taro.xml|vendor/etc/media_codecs_taro_vendor.xml)
            sed -Ei "/media_codecs_(google_audio|google_c2|google_telephony|google_video)/d" "${2}"
            ;;
        system_ext/etc/camera/mtCalibrationCfg.xml)
            sed -i "s/-----/--/" "${2}"
            ;;
        system_ext/etc/camera/mwCalibrationCfg.xml)
            sed -i "s/-----/--/" "${2}"
            ;;
    esac
}

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"

extract "${MY_DIR}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"

"${MY_DIR}/setup-makefiles.sh"
