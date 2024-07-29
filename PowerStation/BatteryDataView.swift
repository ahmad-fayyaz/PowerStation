import SwiftUI
import IOKit.ps

struct BatteryDataView: View {
    
    @State private var currentCapacity: Int?
    @State private var timeToFullCharge: Int?
    @State private var timeToEmpty: Int?
    @State private var isCharging: Bool?
    @State private var batteryHealth: String?
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
        VStack(alignment: .leading) {
            
            // Battery Capacity Widget
            HStack {
                VStack(alignment: .leading, spacing: 13.0) {
                    Label("Battery Capacity", systemImage: "battery.100")
                    if let currentCapacity = currentCapacity {
                        Text("\(currentCapacity)%")
                            .font(.title)
                            .fontWeight(.heavy)
                    }
                }
                ProgressView(value: 0.25) { }
                    .padding()
            }
            
            
            // Time to charge + discharge Widget
            HStack(alignment: .center) {
                VStack {
                    Label("Time to Full Charge", systemImage: "timelapse")
                    if let timeToFullCharge = timeToFullCharge {
                        ProgressView(value: 0.25)
                                        .progressViewStyle(.circular)
                        
                        Text(" \(timeToFullCharge) minutes")
                            .font(.title)
                            .fontWeight(.heavy)
                    }
                }
                Spacer()
                VStack {
                    Label("Time to Empty", systemImage: "exclamationmark.warninglight.fill")
                    if let timeToEmpty = timeToEmpty {
                        ProgressView(value: 0.25)
                                        .progressViewStyle(.circular)
                        Text("\(timeToEmpty) minutes")
                            .font(.title)
                            .fontWeight(.heavy)
                    }
                }
            }
            
            // Is Charging? Widget
            
            if let isCharging = isCharging {
                            ZStack {
                                Rectangle()
                                    .fill(isCharging ? Color.green : Color.gray)
                                    .frame(width: 600.0, height: 50.0)
                                    .cornerRadius(10)
                                Text("Is Charging: \(isCharging ? "Yes" : "No")")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                            
                        }
            
            if let batteryHealth = batteryHealth {
                Text("Battery Health: \(batteryHealth)")
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
            
            if currentCapacity == nil &&
                timeToFullCharge == nil &&
                timeToEmpty == nil &&
                isCharging == nil &&
                batteryHealth == nil &&
                powerSourceState == nil &&
                powerSourceID == nil &&
                name == nil &&
                optimizedBatteryChargingEngaged == nil &&
                transportType == nil &&
                type == nil &&
                current == nil &&
                lpmActive == nil &&
                providesTimeRemaining == nil {
                Text("Loading Battery Data...")
                    .font(.headline)
            }
        }
        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        .frame(height: 600.0)
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
                self.timeToFullCharge = info[kIOPSTimeToFullChargeKey as String] as? Int
                self.timeToEmpty = info[kIOPSTimeToEmptyKey as String] as? Int
                self.isCharging = info[kIOPSIsChargingKey as String] as? Bool
                self.batteryHealth = info["BatteryHealth"] as? String
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
