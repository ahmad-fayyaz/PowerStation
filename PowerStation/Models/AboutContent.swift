//
//  AboutContent.swift
//  PowerStation
//
//  Created by Ahmad Fayyaz on 28/07/2024.
//


import SwiftUI

struct AboutContent: View {
    
    var developerName: String = "Ahmad Fayyaz"
    var appVersion: String = "1.0.0"
    
    var body: some View {
        VStack {
            Text("Developer: \(developerName)")
                .font(.title)
                .padding(.bottom, 10)
            Text("App Version: \(appVersion)")
                .font(.subheadline)
        }
        .padding()
    }
}

#Preview {
    AboutContent()
}
