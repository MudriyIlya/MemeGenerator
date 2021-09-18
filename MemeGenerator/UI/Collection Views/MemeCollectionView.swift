//
//  LibraryCollectionView.swift
//  Marketplace
//
//  Created by Илья Мудрый on 29.08.2021.
//

import UIKit

final class MemeCollectionView: UICollectionView {
    
    // MARK: - Variables
    
    private let inset = Constants.collectionCellInset
    
    // MARK: - Initialization
    
    convenience init(enableHeader header: Bool) {
        self.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
        setupLibraryLayout(enableHeader: header)
    }
    
    convenience init() {
        self.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
        setupLibraryLayout(enableHeader: false)
    }
    
    private override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupCollection()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Collection View
    
    private func setupCollection() {
//        backgroundColor = UIColor.Palette.backgroundColor
        backgroundColor = UIColor.clear
        showsVerticalScrollIndicator = false
    }
    
    // MARK: - Compositional Layout
    
    private func setupLibraryLayout(enableHeader header: Bool) {
        
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
        
        // Header
        if header {
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                     elementKind: UICollectionView.elementKindSectionHeader,
                                                                     alignment: .top)
            section.boundarySupplementaryItems = [header]
        }
        
        let collectionCompositionalLayout = UICollectionViewCompositionalLayout(section: section)
        setCollectionViewLayout(collectionCompositionalLayout, animated: false)
    }
}
