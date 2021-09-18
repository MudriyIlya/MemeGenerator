//
//  LibraryCell.swift
//  Marketplace
//
//  Created by Илья Мудрый on 29.08.2021.
//

import UIKit

final class MemeCell: UICollectionViewCell {
    
    // MARK: - Variables
    
    static let identifier = "MemeCell"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.Palette.backgroundColor
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Cell
    
    private func setupConstraints() {
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    // MARK: - Configuration
    
    override func prepareForReuse() {
        backgroundColor = UIColor.Palette.backgroundColor
        imageView.image = nil
    }
    
    func configureCell(with image: UIImage?) {
        backgroundColor = UIColor.Palette.backgroundColor
        imageView.image = image
    }
    
    func configureCell(with meme: Meme) {
        backgroundColor = UIColor.Palette.backgroundColor
        imageView.downloadThumbImageFromServer(by: meme.imageURL)
    }
}
