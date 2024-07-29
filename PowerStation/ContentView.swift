//
//  ContentView.swift
//  PowerStation
//
//  Created by Ahmad Fayyaz on 28/07/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selection: SidebarContent? = .dashboard
    
    var body: some View {
        NavigationSplitView {
            SidebarView(selection: $selection)
        } detail: {
            if let selected = selection {
                switch selected {
                case .dashboard:
                    BatteryDataView()
                case .settings:
                    SettingsView()
                case .about:
                    AboutContent()
                }
            } else {
                Text("Select an item")
            }
        }
    }
}

#Preview {
    ContentView()
}
