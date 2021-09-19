//
//  PreviewMeme.swift
//  MemeGenerator
//
//  Created by Илья Мудрый on 19.09.2021.
//

import Foundation
import UIKit

final class PreviewMeme {
    
    var image: UIImage
    var name: String
    
    required init(withName name: String, image: UIImage) {
        self.name = name
        self.image = image
    }
}
