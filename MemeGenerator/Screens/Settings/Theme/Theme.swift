//
//  Theme.swift
//  MemeGenerator
//
//  Created by Илья Мудрый on 14.09.2021.
//

import UIKit

enum Theme: Int, CaseIterable {
    case system = 0
    case light
    case dark
}

extension Theme {
    @Persist(key: "appTheme", defaultValue: Theme.system.rawValue)
    private static var appTheme: Int
    
    static var current: Theme {
        Theme(rawValue: appTheme) ?? .system
    }
    
    var userInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .system: return themeWindow.traitCollection.userInterfaceStyle
        case .light: return .light
        case .dark: return .dark
        }
    }
    
    func save() {
        Theme.appTheme = self.rawValue
    }
    
    func setActive() {
        save()
        UIApplication.shared.windows
            .filter { $0 != themeWindow }
            .forEach { $0.overrideUserInterfaceStyle = userInterfaceStyle }
    }
}
