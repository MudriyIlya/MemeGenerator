//
//  SectionHeader.swift
//  MemeGenerator
//
//  Created by Илья Мудрый on 09.09.2021.
//

import UIKit

final class SectionHeader: UICollectionReusableView {
    
    // MARK: - Variables
    
    static let identifier = "SectionHeader"
    
    var label: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.Palette.backgroundColor
        label.textColor = UIColor.Palette.textColor
        label.text = ""
        label.font = UIFont.systemFont(ofSize: label.font.pointSize + 4, weight: .bold)
        return label
    }()
    
    // MARK: - Initialization
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.collectionCellInset),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
