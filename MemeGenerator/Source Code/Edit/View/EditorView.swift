//
//  EditorView.swift
//  MemeGenerator
//
//  Created by Илья Мудрый on 12.09.2021.
//

import UIKit

final class EditorView: UIView {
    
    // MARK: - VARIABLES
    
    // MARK: Callbacks
    var addTextButtonTap: (() -> Void)?
    
    // MARK: Views
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(systemName: "photo")
        imageView.backgroundColor = .magenta
        return imageView
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var addTextButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        //        button.accessibilityIdentifier = "Add Text Button"
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(addTextButtonTapped), for: .touchUpInside)
        button.setTitle("Текст", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.systemGreen
        return button
    }()
    
    private lazy var addImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(addImageButtonTapped), for: .touchUpInside)
        button.setTitle("Изображение", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.systemGreen
        return button
    }()
    
    private lazy var trash: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.clear
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "trash")
        imageView.isHidden = true
        return imageView
    }()
    
    private(set) lazy var centerMemeX = imageView.centerXAnchor
    private(set) lazy var centerMemeY = imageView.centerYAnchor
    
    // MARK: - Lifecycle
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init() {
        super.init(frame: .zero)
        backgroundColor = UIColor.systemGray4
        updateUI()
        prepareTrash()
    }
    
    // MARK: - Constraints
    
    private func updateUI() {
        addSubview(buttonsStackView)
        addSubview(imageView)
        buttonsStackView.addArrangedSubview(addTextButton)
        buttonsStackView.addArrangedSubview(addImageButton)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            buttonsStackView.heightAnchor.constraint(equalToConstant: 40),
            buttonsStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            buttonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            buttonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            addTextButton.widthAnchor.constraint(equalTo: addImageButton.widthAnchor),
            addImageButton.widthAnchor.constraint(equalTo: addTextButton.widthAnchor)
        ])
    }
    
    private func prepareTrash() {
        addSubview(trash)
        NSLayoutConstraint.activate([
            trash.widthAnchor.constraint(equalToConstant: 44),
            trash.heightAnchor.constraint(equalTo: trash.widthAnchor),
            trash.centerXAnchor.constraint(equalTo: centerXAnchor),
            trash.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: - Buttons
    
    @objc func addTextButtonTapped() {
        addTextButtonTap?()
    }
    
    @objc func addImageButtonTapped() {
        // TODO: image from PHOTO
        let newImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        enablePinch(newImageView)
        enableRotation(newImageView)
        enableDragging(newImageView)
        newImageView.isUserInteractionEnabled = true
        newImageView.center = imageView.center
        newImageView.backgroundColor = UIColor.random()
        addSubview(newImageView)
    }
    
    // MARK: - Image methods
    
    func downloadMemeFromServer(_ url: String) {
        self.imageView.downloadFullImageFromServer(by: url)
    }
    
    func addLabelWith(_ text: NSAttributedString) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        enablePinch(label)
        enableRotation(label)
        enableDragging(label)
        label.center = center
        label.isUserInteractionEnabled = true
//        label.backgroundColor = .random()
        label.numberOfLines = 0
        label.attributedText = text
        label.sizeToFit()
        addSubview(label)
    }
    
    func deleteView(_ view: UIView) {
        if view.frame.intersects(trash.frame) {
            UIView.animate(withDuration: 0.3) {
                view.alpha = 0
                view.removeFromSuperview()
            }
        }
    }
}

// MARK: - Movement

extension EditorView {
    
    // MARK: Dragging
    
    func enableDragging(_ view: UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        view.addGestureRecognizer(pan)
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let gestureView = gesture.view else { return }
        switch gesture.state {
        case .began, .changed:
            trash.isHidden = false
            moveViewWithPan(gestureView, gesture: gesture)
        case .ended:
            deleteView(gestureView)
            trash.isHidden = true
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
    
    func enablePinch(_ view: UIView) {
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        view.addGestureRecognizer(pinch)
    }
    
    @objc private func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        guard let gestureView = gesture.view else { return }
        gestureView.transform = gestureView.transform.scaledBy(x: gesture.scale,
                                                               y: gesture.scale)
        gesture.scale = 1
    }
    
    // MARK: Rotation
    
    func enableRotation(_ view: UIView) {
        let rotate = UIRotationGestureRecognizer(target: self, action: #selector(handleRotate(_:)))
        view.addGestureRecognizer(rotate)
    }
    
    @objc private func handleRotate(_ gesture: UIRotationGestureRecognizer) {
        guard let gestureView = gesture.view else { return }
        gestureView.transform = gestureView.transform.rotated(by: gesture.rotation)
        gesture.rotation = 0
    }
}
