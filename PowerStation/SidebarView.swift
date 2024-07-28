//
//  SidebarView.swift
//  PowerStation
//
//  Created by Ahmad Fayyaz on 28/07/2024.
//

import SwiftUI

struct SidebarView: View {
    var body: some View {
        List {
            NavigationLink(destination: Text("Home")) {
                Label("Home", systemImage: "house")
            }
            NavigationLink(destination: Text("Profile")) {
                Label("Profile", systemImage: "person")
            }
            NavigationLink(destination: Text("Settings")) {
                Label("Settings", systemImage: "gear")
            }
        }
        .listStyle(SidebarListStyle())
    }
}

#Preview {
    SidebarView()
}
