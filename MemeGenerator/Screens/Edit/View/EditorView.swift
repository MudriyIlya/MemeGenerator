//
//  EditorView.swift
//  MemeGenerator
//
//  Created by Илья Мудрый on 12.09.2021.
//

import UIKit

final class EditorView: UIView {
    
    // MARK: - Variables
    
    // MARK: Callbacks
    var imageTap: (() -> Void)?
    var addTextButtonTap: (() -> Void)?
    
    // MARK: Views
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.backgroundColor = UIColor.white
        return imageView
    }()
    
    private lazy var addTextButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.accessibilityIdentifier = "AddTextButton"
        button.layer.cornerRadius = Constants.cornerRadius
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(addTextButtonTapped), for: .touchUpInside)
        button.setImage(UIImage(systemName: "textformat.alt"), for: .normal)
        button.tintColor = UIColor.Palette.buttonColor
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    private lazy var addImageButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.accessibilityIdentifier = "AddImageButton"
        button.layer.cornerRadius = Constants.cornerRadius
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(addImageButtonTapped), for: .touchUpInside)
        button.setImage(UIImage(systemName: "photo"), for: .normal)
        button.tintColor = UIColor.Palette.buttonColor
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    private lazy var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.Palette.backgroundColor?.withAlphaComponent(0.7)
        return view
    }()
    
    private lazy var trash: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.clear
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.Palette.editorBackground
        imageView.tintColor = UIColor.Palette.tint
        imageView.image = UIImage(systemName: "trash")
        imageView.isHidden = true
        return imageView
    }()
    
    // MARK: Anchors
    private(set) lazy var centerMemeX = imageView.centerXAnchor
    private(set) lazy var centerMemeY = imageView.centerYAnchor
    
    // MARK: - Lifecycle
    
    required init() {
        super.init(frame: .zero)
        backgroundColor = UIColor.Palette.editorBackground
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        container.addSubview(addTextButton)
        container.addSubview(addImageButton)
        addSubview(container)
        
        addSubview(imageView)
        addSubview(trash)
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            container.heightAnchor.constraint(equalToConstant: 49),
            
            addTextButton.widthAnchor.constraint(equalTo: addImageButton.widthAnchor),
            addImageButton.widthAnchor.constraint(equalTo: addTextButton.widthAnchor),
            
            addTextButton.topAnchor.constraint(equalTo: container.topAnchor),
            addTextButton.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            addTextButton.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            addTextButton.trailingAnchor.constraint(equalTo: addImageButton.leadingAnchor),
            
            addImageButton.leadingAnchor.constraint(equalTo: addTextButton.trailingAnchor),
            addImageButton.topAnchor.constraint(equalTo: container.topAnchor),
            addImageButton.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            addImageButton.trailingAnchor.constraint(equalTo: container.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            trash.widthAnchor.constraint(equalToConstant: 44),
            trash.heightAnchor.constraint(equalTo: trash.widthAnchor),
            trash.centerXAnchor.constraint(equalTo: centerXAnchor),
            trash.bottomAnchor.constraint(equalTo: container.topAnchor, constant: -20)
        ])
    }
    
    // MARK: - Buttons
    
    @objc func addTextButtonTapped() {
        addTextButtonTap?()
    }
    
    @objc func addImageButtonTapped() {
        imageTap?()
    }
    
    // MARK: - Meme methods
    
    func downloadMemeFromServer(_ url: String) {
        self.imageView.downloadFullImageFromServer(by: url)
    }
    
    func add(_ image: UIImage) {
        let newImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        newImageView.isUserInteractionEnabled = true
        newImageView.contentMode = .scaleAspectFill
        enablePinch(newImageView)
        enableRotation(newImageView)
        enableDragging(newImageView)
        newImageView.image = image
        newImageView.center = imageView.center
        newImageView.backgroundColor = UIColor.clear
        addSubview(newImageView)
    }
    
    func addLabelWith(_ text: NSAttributedString) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 300))
        label.isUserInteractionEnabled = true
        enablePinch(label)
        enableRotation(label)
        enableDragging(label)
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFontMetrics.default.scaledFont(for: Constants.impactFont!)
        label.adjustsFontForContentSizeCategory = true
        label.attributedText = NSAttributedString(string: text.string,
                                                  attributes: [
                                                    NSAttributedString.Key.strokeWidth: -4.0,
                                                    NSAttributedString.Key.strokeColor: UIColor.black,
                                                    NSAttributedString.Key.foregroundColor: UIColor.white
                                                  ])
        
        label.sizeToFit()
        label.center = imageView.center
        
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
    
    func getMemeImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: imageView.frame)
        let image = renderer.image { rendererContext in
            self.layer.render(in: rendererContext.cgContext)
        }
        return image
    }
}

// MARK: - Movement of Subviews

extension EditorView {
    
    // MARK: Dragging
    
    private func enableDragging(_ view: UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        pan.delegate = self
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
        let translation = gesture.translation(in: self)
        view.center = CGPoint(x: view.center.x + translation.x,
                              y: view.center.y + translation.y)
        gesture.setTranslation(CGPoint.zero, in: view)
    }
    
    // MARK: Pinch
    
    private func enablePinch(_ view: UIView) {
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        pinch.delegate = self
        view.addGestureRecognizer(pinch)
    }
    
    @objc private func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        guard let gestureView = gesture.view else { return }
        gestureView.transform = gestureView.transform.scaledBy(x: gesture.scale,
                                                               y: gesture.scale)
        gesture.scale = 1
    }
    
    // MARK: Rotation
    
    private func enableRotation(_ view: UIView) {
        let rotate = UIRotationGestureRecognizer(target: self, action: #selector(handleRotate(_:)))
        rotate.delegate = self
        view.addGestureRecognizer(rotate)
    }
    
    @objc private func handleRotate(_ gesture: UIRotationGestureRecognizer) {
        guard let gestureView = gesture.view else { return }
        gestureView.transform = gestureView.transform.rotated(by: gesture.rotation)
        gesture.rotation = 0
    }
}

// MARK: - Gesture Recognizer Delegate

extension EditorView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
