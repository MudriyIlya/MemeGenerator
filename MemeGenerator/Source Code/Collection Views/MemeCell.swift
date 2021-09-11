//
//  LibraryCell.swift
//  Marketplace
//
//  Created by Илья Мудрый on 29.08.2021.
//

import UIKit

final class MemeCell: UICollectionViewCell {
    
    // MARK: Variables
    
    static let identifier = "MemeCell"
    
    // Image
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // Title
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.layer.cornerRadius = 1
        label.backgroundColor = UIColor(white: 1, alpha: 0.57)
        label.font = UIFont.systemFont(ofSize: label.font.pointSize + 2, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setOpaqueBackground()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    
    private func setupConstraints() {
        contentView.addSubview(imageView)
        contentView.addSubview(title)
        
        NSLayoutConstraint.activate([
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            title.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -5),
            title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            title.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    // MARK: Configuration
    
    func configureCell(_ image: UIImage?, title: String) {
        setOpaqueBackground()
        self.imageView.image = image
        self.title.text = title
    }
    
    func configureCell(with meme: Meme) {
        setOpaqueBackground()
        imageView.downloadThumbImageFromServer(by: meme.imageURL)
        title.text = ""
    }
    
    override func prepareForReuse() {
        setOpaqueBackground()
        imageView.image = nil
        title.text = ""
    }
    
    // Image methods
    
    func setImage(image: UIImage? = nil) {
        imageView.image = image
    }
    
    func getImage() -> UIImage {
        guard let image = imageView.image else { return UIImage() }
        return image
    }
    
    // Title methods
    
    func setTitle(_ title: String) {
        self.title.text = title
    }
    
    func getTitle() -> String {
        guard let text = title.text else { return "" }
        return text
    }
}
