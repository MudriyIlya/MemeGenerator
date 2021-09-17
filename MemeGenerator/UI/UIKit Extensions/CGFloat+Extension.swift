//
//  CGFloat+Extension.swift
//  MemeGenerator
//
//  Created by Илья Мудрый on 14.09.2021.
//

import UIKit

extension CGFloat {

    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
