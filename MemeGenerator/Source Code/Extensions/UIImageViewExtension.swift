//
//  UIImageViewExtension.swift
//  MemeGenerator
//
//  Created by Илья Мудрый on 11.09.2021.
//

import UIKit

extension UIImageView {
    
    func downloadFullImageFromServer(by nameURL: String) {
        startSpinner()
        NetworkService().loadMemeImage(imageURL: nameURL, thumb: false) { [weak self] data in
            DispatchQueue.main.async {
                guard let self = self,
                      let data = data else { return }
                self.image = UIImage(data: data)
                self.stopSpinner()
            }
        }
    }
    
    func downloadThumbImageFromServer(by nameURL: String) {
        startSpinner()
        NetworkService().loadMemeImage(imageURL: nameURL, thumb: true) { [weak self] data in
            DispatchQueue.main.async {
                guard let self = self,
                      let data = data else { return }
                self.image = UIImage(data: data)
                self.stopSpinner()
            }
        }
    }
}
