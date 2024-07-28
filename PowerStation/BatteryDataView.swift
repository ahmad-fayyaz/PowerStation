import SwiftUI
import IOKit.ps

struct BatteryDataView: View {
    
    @State private var batteryLevel: Int?
    
    var body: some View {
        VStack {
            if let batteryLevel = batteryLevel {
                Text("Current Battery Level: \(batteryLevel)%")
                    .font(.largeTitle)
                    .padding()
            } else {
                Text("Loading Battery Data...")
                    .font(.headline)
                    .padding()
            }
        }
        .onAppear {
            self.batteryLevel = getBatteryLevel()
        }
    }
}

#Preview {
    BatteryDataView()
}
