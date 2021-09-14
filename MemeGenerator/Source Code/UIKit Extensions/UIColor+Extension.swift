//
//  UIColor+Extension.swift
//  MemeGenerator
//
//  Created by Илья Мудрый on 14.09.2021.
//

import UIKit

extension UIColor {
    
    static func random() -> UIColor {
        return UIColor(red: .random(), green: .random(), blue: .random(), alpha: 1)
    }
    
    struct Palette {
        static let backgroundColor = UIColor(named: "backgroundColor")
        static let tint = UIColor(named: "tint")
        static let accent = UIColor(named: "accent")
        static let textColor = UIColor(named: "textColor")
        // TODO: добавить в ассет под разные темы
        static let filterBackground = UIColor(white: 0, alpha: 0.4)
        
        private init() { }
    }
}
