//
//  Constants.swift
//  MemeGenerator
//
//  Created by Илья Мудрый on 08.09.2021.
//

import UIKit

enum Constants {
    static let collectionCellInset: CGFloat = 3.0
    static let cornerRadius: CGFloat = 5
    static let impactFont = UIFont(name: "Impact", size: UIFont.labelFontSize + 20)
}

enum MemesAPI {
    static let baseURL = "https://meme-generator-sberschool.herokuapp.com/"
    enum EndPoint {
        static let imageThumbPath = "thumbs/"
        static let APIPath        = "api/memes"
    }
}
