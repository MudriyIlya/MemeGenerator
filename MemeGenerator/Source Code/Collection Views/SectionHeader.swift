//
//  SectionHeader.swift
//  MemeGenerator
//
//  Created by Илья Мудрый on 09.09.2021.
//

import UIKit

final class SectionHeader: UICollectionReusableView {
    
    // MARK: Variables
    
    static let identifier = "SectionHeader"
    
    var label: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: label.font.pointSize + 4, weight: .bold)
        label.textColor = UIColor.red
        label.sizeToFit()
        return label
    }()
    
    // MARK: Initialization
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    // MARK: Setup UI
    
    private func setupUI() {
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 3.0),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
