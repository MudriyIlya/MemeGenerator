//
//  UIViewExtension.swift
//  MemeGenerator
//
//  Created by Илья Мудрый on 08.09.2021.
//

import UIKit

extension UIView {
    
    // MARK: Loader extension for Views
    
    func startSpinner() {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.tag = 777
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
    
    // MARK: Set Opaque
    func setOpaqueBackground() {
        alpha = 1.0
        backgroundColor = Constants.defaultBackgroundColor
    }
}
