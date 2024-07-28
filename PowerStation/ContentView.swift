//
//  ContentView.swift
//  PowerStation
//
//  Created by Ahmad Fayyaz on 28/07/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            SidebarView()
            Text("Select an item")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    ContentView()
}
