//
//  UIViewExtension.swift
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
        backgroundColor = Constants.defaultBackgroundColor
    }
}

// MARK: - Movement

extension UIView {
    
    // MARK: Dragging
    
    func enableDragging() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        self.addGestureRecognizer(pan)
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let gestureView = gesture.view else { return }
        switch gesture.state {
        case .began, .changed:
            moveViewWithPan(gestureView, gesture: gesture)
        case .ended:
            break
        default:
            break
        }
    }
    
    private func moveViewWithPan(_ view: UIView, gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        view.center = CGPoint(x: view.center.x + translation.x,
                              y: view.center.y + translation.y)
        gesture.setTranslation(CGPoint.zero, in: view)
    }
    
    // MARK: Pinch
    
    func enablePinch() {
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        self.addGestureRecognizer(pinch)
    }
    
    @objc private func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        guard let gestureView = gesture.view else { return }
        gestureView.transform = gestureView.transform.scaledBy(x: gesture.scale,
                                                               y: gesture.scale)
        gesture.scale = 1
    }
    
    // MARK: Rotation
    
    func enableRotation() {
        let rotate = UIRotationGestureRecognizer(target: self, action: #selector(handleRotate(_:)))
        self.addGestureRecognizer(rotate)
    }
    
    @objc private func handleRotate(_ gesture: UIRotationGestureRecognizer) {
        guard let gestureView = gesture.view else { return }
        gestureView.transform = gestureView.transform.rotated(by: gesture.rotation)
        gesture.rotation = 0
    }
}
