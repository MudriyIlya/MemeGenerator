//
//  UIViewExtension.swift
//  MemeGenerator
//
//  Created by Илья Мудрый on 08.09.2021.
//

import UIKit

private var spinner: UIView?

extension UIView {
    
    // MARK: Loader extension for Views
    
    func startSpinner() {
        spinner = UIView(frame: bounds)
        spinner?.backgroundColor = UIColor(white: 0, alpha: 0.2)
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = center
        activityIndicator.startAnimating()
        guard let spinner = spinner else { return }
        
        spinner.addSubview(activityIndicator)
        addSubview(spinner)
    }
    
    func stopSpinner() {
        spinner?.removeFromSuperview()
        spinner = nil
    }
    
}
