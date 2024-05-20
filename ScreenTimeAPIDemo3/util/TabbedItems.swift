//
//  TabbedItems.swift
//  ScreenTimeAPIDemo3
//
//  Created by user256728 on 4/21/24.
//

enum TabbedItems: Int, CaseIterable{
    case home = 0
    case history
    case profile
    
    var iconName: String{
        switch self {
        case .home:
            return "list.bullet.circle.fill"
        case .history:
            return "plus.circle.fill"
        case .profile:
            return "person.circle.fill"
        }
    }
}
