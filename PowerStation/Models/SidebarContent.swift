//
//  SidebarContent.swift
//  PowerStation
//
//  Created by Ahmad Fayyaz on 28/07/2024.
//

import Foundation

enum SidebarContent: String, Identifiable, CaseIterable, Hashable {
    
    case dashboard
    case settings
    case about
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
            case .dashboard:
                return "Dashboard"
            case .settings:
                return "Settings"
            case .about:
                return "About"
        }
    }
    
    var iconName: String {
        switch self {
            case .dashboard:
                return "battery.75percent"
            case .settings:
                return "gear"
            case .about:
                return "info.bubble.fill"
        }
    }
    
    static func == (lhs: SidebarContent, rhs: SidebarContent) -> Bool {
        lhs.id == rhs.id
    }
}
