//
//  Preview.swift
//  MemeGenerator
//
//  Created by Илья Мудрый on 11.09.2021.
//

import UIKit

final class Preview: UIView {
    
    // MARK: - VARIABLES
    // MARK: Meme
    
    private lazy var meme: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = false
        imageView.backgroundColor = .blue
        imageView.image = UIImage(systemName: "photo")
        return imageView
    }()
    
    // MARK: - Lifecycle
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init() {
        super.init(frame: .zero)
        backgroundColor = UIColor.black
        updateUI()
    }
    
    // MARK: - Constraints
    
    private func updateUI() {
        addSubview(meme)
        NSLayoutConstraint.activate([
            meme.widthAnchor.constraint(equalTo: widthAnchor),
            meme.heightAnchor.constraint(equalTo: meme.widthAnchor),
            meme.centerXAnchor.constraint(equalTo: centerXAnchor),
            meme.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    // MARK: - Image methods
    
    func setMeme(_ meme: UIImage) {
        self.meme.image = meme
    }
    
    // Return meme for saving
    func getMeme() -> UIImage? {
        return meme.image
    }
    
}
