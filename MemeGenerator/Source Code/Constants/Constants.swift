//
//  Constants.swift
//  MemeGenerator
//
//  Created by Илья Мудрый on 08.09.2021.
//

import UIKit

enum Constants {
    static let defaultBackgroundColor = UIColor.systemBackground
}

enum MemesAPI {
    static let baseURL = "https://meme-generator-sberschool.herokuapp.com/"
    enum EndPoint {
        static let imageThumbPath = "thumbs/"
        static let APIPath        = "api/memes"
    }
}
