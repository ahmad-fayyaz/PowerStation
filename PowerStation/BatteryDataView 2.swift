import SwiftUI
import IOKit.ps

struct BatteryDataView: View {
    
    @State private var currentCapacity: Int?
    @State private var maxCapacity: Int?
    @State private var designCycleCount: Int?
    @State private var cycleCount: Int?
    @State private var timeToFullCharge: Int?
    @State private var timeToEmpty: Int?
    @State private var isCharging: Bool?
    @State private var isPresent: Bool?
    @State private var hardwareSerialNumber: String?
    @State private var batteryHealth: String?
    @State private var batteryHealthCondition: String?
    @State private var powerSourceState: String?
    @State private var powerSourceID: Int?
    @State private var name: String?
    @State private var optimizedBatteryChargingEngaged: Bool?
    @State private var transportType: String?
    @State private var type: String?
    @State private var current: Int?
    @State private var lpmActive: Bool?
    @State private var providesTimeRemaining: Bool?
    
    var body: some View {
        VStack(alignment: .leading,spacing: 15.0) {
            if let currentCapacity = currentCapacity {
                Text("Current Capacity: \(currentCapacity) mAh")
            }
            if let maxCapacity = maxCapacity {
                Text("Max Capacity: \(maxCapacity) mAh")
            }
            if let designCycleCount = designCycleCount {
                Text("Design Cycle Count: \(designCycleCount)")
            }
            if let cycleCount = cycleCount {
                Text("Cycle Count: \(cycleCount)")
            }
            if let timeToFullCharge = timeToFullCharge {
                Text("Time to Full Charge: \(timeToFullCharge) minutes")
            }
            if let timeToEmpty = timeToEmpty {
                Text("Time to Empty: \(timeToEmpty) minutes")
            }
            if let isCharging = isCharging {
                Text("Is Charging: \(isCharging ? "Yes" : "No")")
            }
            if let isPresent = isPresent {
                Text("Is Present: \(isPresent ? "Yes" : "No")")
            }
            if let hardwareSerialNumber = hardwareSerialNumber {
                Text("Hardware Serial Number: \(hardwareSerialNumber)")
            }
            if let batteryHealth = batteryHealth {
                Text("Battery Health: \(batteryHealth)")
            }
            if let batteryHealthCondition = batteryHealthCondition {
                Text("Battery Health Condition: \(batteryHealthCondition)")
            }
            if let powerSourceState = powerSourceState {
                Text("Power Source State: \(powerSourceState)")
            }
            if let powerSourceID = powerSourceID {
                Text("Power Source ID: \(powerSourceID)")
            }
            if let name = name {
                Text("Name: \(name)")
            }
            if let optimizedBatteryChargingEngaged = optimizedBatteryChargingEngaged {
                Text("Optimized Battery Charging Engaged: \(optimizedBatteryChargingEngaged ? "Yes" : "No")")
            }
            if let transportType = transportType {
                Text("Transport Type: \(transportType)")
            }
            if let type = type {
                Text("Type: \(type)")
            }
            if let current = current {
                Text("Current: \(current) mA")
            }
            if let lpmActive = lpmActive {
                Text("LPM Active: \(lpmActive ? "Yes" : "No")")
            }
            if let providesTimeRemaining = providesTimeRemaining {
                Text("Battery Provides Time Remaining: \(providesTimeRemaining ? "Yes" : "No")")
            }
        }
        .padding()
        .frame(width: 800.0, height: 600.0)
        .onAppear {
            self.fetchBatteryInfo()
        }
    }
    
    func fetchBatteryInfo() {
        let snapshot = IOPSCopyPowerSourcesInfo().takeRetainedValue()
        let sources = IOPSCopyPowerSourcesList(snapshot).takeRetainedValue() as Array

        for ps in sources {
            if let info = IOPSGetPowerSourceDescription(snapshot, ps).takeUnretainedValue() as? [String: Any] {
                self.currentCapacity = info[kIOPSCurrentCapacityKey as String] as? Int
                self.maxCapacity = info[kIOPSMaxCapacityKey as String] as? Int
                self.designCycleCount = info["DesignCycleCount"] as? Int
                self.cycleCount = info["CycleCount"] as? Int
                self.timeToFullCharge = info[kIOPSTimeToFullChargeKey as String] as? Int
                self.timeToEmpty = info[kIOPSTimeToEmptyKey as String] as? Int
                self.isCharging = info[kIOPSIsChargingKey as String] as? Bool
                self.isPresent = info["Is Present"] as? Bool
                self.hardwareSerialNumber = info["Hardware Serial Number"] as? String
                self.batteryHealth = info["BatteryHealth"] as? String
                self.batteryHealthCondition = info["BatteryHealthCondition"] as? String
                self.powerSourceState = info["Power Source State"] as? String
                self.powerSourceID = info["Power Source ID"] as? Int
                self.name = info["Name"] as? String
                self.optimizedBatteryChargingEngaged = info["Optimized Battery Charging Engaged"] as? Bool
                self.transportType = info["Transport Type"] as? String
                self.type = info["Type"] as? String
                self.current = info["Current"] as? Int
                self.lpmActive = info["LPM Active"] as? Bool
                self.providesTimeRemaining = info["Battery Provides Time Remaining"] as? Bool
            }
        }
    }
}

#Preview {
    BatteryDataView()
}
