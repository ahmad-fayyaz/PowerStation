//
//  BatteryData.swift
//  PowerStation
//
//  Created by Ahmad Fayyaz on 28/07/2024.
//

import Foundation
import IOKit.ps

func getBatteryLevel() -> Int? {
    let snapshot = IOPSCopyPowerSourcesInfo().takeRetainedValue()
    let sources = IOPSCopyPowerSourcesList(snapshot).takeRetainedValue() as Array

    for ps in sources {
        if let info = IOPSGetPowerSourceDescription(snapshot, ps).takeUnretainedValue() as? [String: Any] {
            if let capacity = info[kIOPSCurrentCapacityKey] as? Int,
               let maxCapacity = info[kIOPSMaxCapacityKey] as? Int {
                return (capacity * 100) / maxCapacity
            }
        }
    }
    return nil
}


