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
        imageView.image = nil
        return imageView
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.Palette.backgroundColor
        cornerRadius()
        setupShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
        improveScrollingPerformance()
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
    
    private func cornerRadius() {
        contentView.layer.cornerRadius = Constants.cornerRadius
        contentView.layer.masksToBounds = true
        layer.cornerRadius = Constants.cornerRadius
        layer.masksToBounds = false
    }
    
    private func setupShadow() {
        layer.shadowRadius = 2.0
        layer.shadowColor = UIColor.Palette.shadowColor?.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    private func improveScrollingPerformance() {
        layer.shadowPath = UIBezierPath(roundedRect: bounds,
                                        cornerRadius: Constants.cornerRadius).cgPath
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
