//
//  UIViewControllerExtension.swift
//  MemeGenerator
//
//  Created by Илья Мудрый on 09.09.2021.
//

import UIKit

extension UIViewController {
    
    // MARK: Error Alert
    
    func showErrorAlert(with message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: "Упс! Что-то пошло не так...",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Грустненько 😢", style: .default, handler: handler))
        present(alert, animated: true)
    }
    
}
