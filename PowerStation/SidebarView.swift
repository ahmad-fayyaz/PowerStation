//
//  SidebarView.swift
//  PowerStation
//
//  Created by Ahmad Fayyaz on 28/07/2024.
//

import SwiftUI

struct SidebarView: View {
    
    @State private var selection: SidebarContent? = .dashboard
    
    var body: some View {
        NavigationSplitView {
            List(SidebarContent.allCases, id: \.self, selection: $selection) { item in
                NavigationLink(value: item) {
                    Label(item.displayName, systemImage: item.iconName)
                }
            }
            .navigationTitle("Powerhouse")
            .listStyle(SidebarListStyle())
        } detail: {
            if let selected = selection {
                Text("Selected: \(selected.displayName)")
            } else {
                Text("Select an item")
            }
        }
    }
}

#Preview {
    SidebarView()
}
