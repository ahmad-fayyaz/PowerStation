import SwiftUI
import IOKit.ps

struct BatteryDataView: View {
    
    @State private var currentCapacity: Int?
    @State private var timeToFullCharge: Int?
    @State private var timeToEmpty: Int?
    @State private var isCharging: Bool?
    @State private var powerSourceState: String?
    @State private var batteryHealth: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            // Battery Capacity Widget
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Label("Battery Capacity", systemImage: "battery.100")
                    if let currentCapacity = currentCapacity {
                        Text("\(currentCapacity)%")
                            .font(.title)
                            .fontWeight(.heavy)
                    }
                }
                Spacer()
                ProgressView(value: (currentCapacity != nil) ? Double(currentCapacity!) / 100 : 0.25)
                    .progressViewStyle(LinearProgressViewStyle())
                    .frame(width: 150)
                    .padding()
            }
            
            // Time to charge + discharge Widget
            HStack(alignment: .center, spacing: 20) {
                VStack {
                    Label("Time to Full Charge", systemImage: "timelapse")
                    if let timeToFullCharge = timeToFullCharge {
                        ProgressView(value: 0.25)
                            .progressViewStyle(CircularProgressViewStyle())
                        Text(" \(timeToFullCharge) minutes")
                            .font(.title)
                            .fontWeight(.heavy)
                    }
                }
                Spacer()
                VStack {
                    Label("Time to Empty", systemImage: "exclamationmark.triangle.fill")
                    if let timeToEmpty = timeToEmpty {
                        ProgressView(value: 0.25)
                            .progressViewStyle(CircularProgressViewStyle())
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
                        .frame(height: 50.0)
                        .cornerRadius(10)
                    Text("Is Charging: \(isCharging ? "Yes" : "No")")
                        .foregroundColor(.white)
                        .bold()
                }
                .padding(.vertical, 10)
            }
            
            // Power Source Widget
            HStack {
                Label("Power Source", systemImage: "bolt.fill")
                Spacer()
                if let powerSourceState = powerSourceState {
                    Text("\(powerSourceState)")
                }
            }
            .padding(.vertical, 5)
            
            // Battery Health Widget
            HStack {
                Label("Battery Health", systemImage: "heart.fill")
                Spacer()
                if let batteryHealth = batteryHealth {
                    Text("\(batteryHealth)")
                }
            }
            .padding(.vertical, 5)
            
            // Loading State
            if currentCapacity == nil &&
                timeToFullCharge == nil &&
                timeToEmpty == nil &&
                isCharging == nil &&
                powerSourceState == nil &&
                batteryHealth == nil {
                Text("Loading Battery Data...")
                    .font(.headline)
                    .padding(.top, 20)
            }
        }
        .padding()
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
                self.powerSourceState = info[kIOPSPowerSourceStateKey as String] as? String
                self.batteryHealth = info["BatteryHealth"] as? String
            }
        }
    }
}

#Preview {
    BatteryDataView()
}
