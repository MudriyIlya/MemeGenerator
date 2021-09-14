//
//  ThemeWindow.swift
//  MemeGenerator
//
//  Created by Илья Мудрый on 14.09.2021.
//

import UIKit

final class ThemeWindow: UIWindow {
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if Theme.current == .system {
            Theme.system.setActive()
        }
    }
}
