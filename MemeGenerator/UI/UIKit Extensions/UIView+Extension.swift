//
//  UIView+Extension.swift
//  MemeGenerator
//
//  Created by Илья Мудрый on 08.09.2021.
//

import UIKit

// MARK: - Loader

extension UIView {
    
    func startSpinner() {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.tag = 777
//        #warning("цвет чувака")
        spinner.color = .black
        spinner.startAnimating()
        
        addSubview(spinner)
        NSLayoutConstraint.activate([
            spinner.topAnchor.constraint(equalTo: self.topAnchor),
            spinner.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            spinner.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            spinner.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    func stopSpinner() {
        subviews.forEach {
            if $0.tag == 777 { $0.removeFromSuperview() }
        }
    }
}

// MARK: - Opaque Background

extension UIView {
    
    func setOpaqueBackground() {
        alpha = 1.0
        backgroundColor = UIColor.Palette.backgroundColor
    }
}
