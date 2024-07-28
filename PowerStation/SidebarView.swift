//
//  SidebarView.swift
//  PowerStation
//
//  Created by Ahmad Fayyaz on 28/07/2024.
//

import SwiftUI

struct SidebarView: View {
    
    @Binding var selection: SidebarContent?
    
    var body: some View {
        List(SidebarContent.allCases, id: \.self, selection: $selection) { item in
            NavigationLink(value: item) {
                Label(item.displayName, systemImage: item.iconName)
            }
        }
        .navigationTitle("Powerhouse")
        .listStyle(SidebarListStyle())
    }
}

#Preview {
    SidebarView(selection: .constant(.dashboard))
}


