//
//  LibraryCollectionView.swift
//  Marketplace
//
//  Created by Илья Мудрый on 29.08.2021.
//

import UIKit

final class LibraryCollectionView: UICollectionView {
    
    // MARK: Properties
    
    private let inset: CGFloat = 5.0
    
    // MARK: Initialization
    
    convenience init() {
        self.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
        setupView()
        setupLibraryLayout()
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupView()
        setupLibraryLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup Collection View
    
    private func setupView() {
        backgroundColor = UIColor.clear
        showsVerticalScrollIndicator = false
    }
    
    // MARK: Compositional Layout
    
    private func setupLibraryLayout() {

        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        // Line Group
        let nestedGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                     heightDimension: .fractionalWidth(0.5))
        let nestedGroup = NSCollectionLayoutGroup.horizontal(layoutSize: nestedGroupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: nestedGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        let collectionCompositionalLayout = UICollectionViewCompositionalLayout(section: section)
        setCollectionViewLayout(collectionCompositionalLayout, animated: false)
    }

}
