/*
 * SPDX-FileCopyrightText: The LineageOS Project
 * SPDX-License-Identifier: Apache-2.0
 */

/*
 * android.frameworks.stats@1.0 is gone from the platform. The FPC
 * fingerprint HAL only looks the service up to report atoms, and copes
 * with it being absent.
 */

#include <string>

#include <utils/RefBase.h>
#include <utils/StrongPointer.h>

namespace android::frameworks::stats::V1_0 {

struct IStats : public virtual RefBase {
    static sp<IStats> tryGetService(const std::string& serviceName, bool getStub);
};

sp<IStats> IStats::tryGetService(const std::string&, bool) {
    return nullptr;
}

}  // namespace android::frameworks::stats::V1_0
