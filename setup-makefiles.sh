#!/bin/bash
#
# SPDX-FileCopyrightText: 2016 The CyanogenMod Project
# SPDX-FileCopyrightText: 2017-2024 The LineageOS Project
# SPDX-FileCopyrightText: 2022 Paranoid Android
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

function vendor_imports() {
    cat <<EOF >>"$1"
        "hardware/qcom/display",
        "hardware/qcom/display/gralloc",
        "hardware/qcom/display/libdebug",
        "vendor/qcom/common/vendor/adreno-s",
        "vendor/qcom/common/vendor/display/5.10",
        "vendor/qcom/common/vendor/media",
        "vendor/qcom/common/vendor/perf",
        "vendor/qcom/common/vendor/wlan",
EOF
}

function lib_to_package_fixup_vendor_variants() {
    if [ "$2" != "vendor" ]; then
        return 1
    fi

    case "$1" in
            com.qualcomm.qti.dpm.api* | \
            com.qualcomm.qti.imscmservice* | \
            com.qualcomm.qti.uceservice* | \
            vendor.qti.data.* | \
            vendor.qti.diaghal@1.0 | \
            vendor.qti.hardware.embmssl* | \
            vendor.qti.hardware.limits* | \
            vendor.qti.hardware.ListenSoundModel@1.0 | \
            vendor.qti.hardware.mwqemadapter@1.0 | \
            vendor.qti.hardware.qccsyshal* | \
            vendor.qti.hardware.qccvndhal@1.0 | \
            vendor.qti.hardware.qxr-V1-ndk_platform | \
            vendor.qti.hardware.radio.* | \
            vendor.qti.hardware.slmadapter@1.0 | \
            vendor.qti.hardware.wifidisplaysession@1.0 | \
            vendor.qti.imsrtpservice@3.0* | \
            vendor.qti.hardware.radio.lpa* | \
            vendor.qti.ims* | \
            vendor.qti.hardware.data.cne.internal.api* | \
            vendor.qti.hardware.data.cne.internal.constants* | \
            vendor.qti.hardware.data.dynamicdds* | \
            vendor.qti.hardware.data.cne.internal.server* | \
            vendor.qti.hardware.data.qmi* | \
            vendor.qti.hardware.data.lce* | \
            vendor.qti.hardware.data.flow@1.0* | \
            vendor.qti.hardware.data.latency@1.0* | \
            vendor.qti.hardware.data.ka-V1-ndk_platform* | \
            vendor.qti.hardware.data.dataactivity-V1-ndk_platform* | \
            vendor.qti.hardware.data.connectionfactory-V1-ndk_platform* | \
            vendor.qti.hardware.data.connection@1.0* | \
            vendor.qti.hardware.data.connection@1.1* | \
            vendor.qti.hardware.data.iwlan@1.0* | \
            vendor.qti.hardware.data.iwlan@1.1* | \
            vendor.qti.hardware.dpmservice@1.0* | \
            vendor.qti.hardware.dpmservice@1.1* | \
            vendor.qti.latency*)
            echo "$1_vendor"
            ;;
        libgrpc++_unsecure)
            echo "$1_prebuilt"
            ;;
        libwpa_client)
            # Android.mk only packages
            ;;
        *)
            return 1
            ;;
    esac
}

function lib_to_package_fixup() {
    lib_to_package_fixup_clang_rt_ubsan_standalone "$1" ||
        lib_to_package_fixup_proto_3_9_1 "$1" ||
        lib_to_package_fixup_vendor_variants "$@"
}

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}"

# Warning headers and guards
write_headers

write_makefiles "${MY_DIR}/proprietary-files.txt"

# Finish
write_footers