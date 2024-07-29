//
//  SettingsView.swift
//  PowerStation
//
//  Created by Ahmad Fayyaz on 28/07/2024.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("sliderValue1") private var storedSliderValue1: Double = 50.0
    @AppStorage("sliderValue2") private var storedSliderValue2: Double = 75.0
    
    @State private var sliderValue1: Double = 50.0
    @State private var sliderValue2: Double = 75.0
    @State private var onLogin = false
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            Text("Settings")
                .font(.largeTitle)
                .padding(.bottom, 20)
                
            // Slider #1
            VStack(alignment: .leading) {
                Text("Start Charging at \(Int(sliderValue1))%")
                Slider(value: $sliderValue1, in: 0...100, step: 1)
            }
            
            // Slider #2
            VStack(alignment: .leading) {
                Text("Stop Charging at \(Int(sliderValue2))%")
                Slider(value: $sliderValue2, in: 0...100, step: 1)
            }
            
            // Disable/Enable Power Adapter
            HStack {
                Button(action: applyChanges) {
                    Text("Disable Power Adapter")
                }
                Button(action: applyChanges) {
                    Text("Request Full Charging")
                }
            }
            
            Toggle(isOn: $onLogin) {
                        Text("Start Powerhouse on Login")
                    }
                    .toggleStyle(.checkbox)
            
            
            // Apply Settings
            Button(action: applyChanges) {
                Text("Apply")
            }
            
            
            Spacer()
        }
        .padding()
        .onAppear {
            sliderValue1 = storedSliderValue1
            sliderValue2 = storedSliderValue2
        }
    }
    
    private func applyChanges() {
        storedSliderValue1 = sliderValue1
        storedSliderValue2 = sliderValue2
    }
}

#Preview {
    SettingsView()
}
