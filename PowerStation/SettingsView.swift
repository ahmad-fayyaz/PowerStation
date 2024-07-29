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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Settings")
                .font(.largeTitle)
                .padding(.bottom, 20)
            
            VStack(alignment: .leading) {
                Text("Slider 1 Value: \(Int(sliderValue1))")
                Slider(value: $sliderValue1, in: 0...100, step: 1)
            }
            
            VStack(alignment: .leading) {
                Text("Slider 2 Value: \(Int(sliderValue2))")
                Slider(value: $sliderValue2, in: 0...100, step: 1)
            }
            
            Button(action: applyChanges) {
                Text("Apply")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.top, 20)
            
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
