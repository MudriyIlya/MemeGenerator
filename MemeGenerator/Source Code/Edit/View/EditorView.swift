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
    
    // MARK: - Buttons
    
    @objc func addTextButtonTapped() {
        addTextButtonTap?()
    }
    
    @objc func addImageButtonTapped() {
        // TODO: image from PHOTO
        let newImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        newImageView.isUserInteractionEnabled = true
        newImageView.center = imageView.center
        newImageView.enablePinch()
        newImageView.enableRotation()
        newImageView.enableDragging()
        newImageView.backgroundColor = UIColor.random()
        imageView.addSubview(newImageView)
    }
    
    // MARK: - Image methods
    
    func downloadMemeFromServer(_ url: String) {
        self.imageView.downloadFullImageFromServer(by: url)
    }
    
    func addLabelWith(_ text: NSAttributedString) {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        label.enablePinch()
        label.enableRotation()
        label.enableDragging()
        label.backgroundColor = .random()
        label.numberOfLines = 0
        label.attributedText = text
        label.sizeToFit()
        imageView.addSubview(label)
    }
}
