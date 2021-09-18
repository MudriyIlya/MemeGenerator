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
        spinner.color = UIColor.Palette.spinnerColor
        spinner.tag = 777
        spinner.startAnimating()
        
        addSubview(spinner)
        NSLayoutConstraint.activate([
            spinner.topAnchor.constraint(equalTo: topAnchor),
            spinner.bottomAnchor.constraint(equalTo: bottomAnchor),
            spinner.leadingAnchor.constraint(equalTo: leadingAnchor),
            spinner.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func stopSpinner() {
        subviews.forEach {
            if $0.tag == 777 { $0.removeFromSuperview() }
        }
    }
}
