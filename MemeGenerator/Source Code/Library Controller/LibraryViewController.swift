//
//  LibraryViewController.swift
//  Marketplace
//
//  Created by Илья Мудрый on 21.08.2021.
//

import UIKit

final class LibraryViewController: UIViewController {
    
    // MARK: - Variables
    
    private lazy var libraryCollectionView: MemeCollectionView = {
        let collectionView = MemeCollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MemeCell.self, forCellWithReuseIdentifier: MemeCell.identifier)
        return collectionView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        title = "Твои мемасики"
    }
    
    override func viewWillLayoutSubviews() {
        setupList()
    }
    
    // MARK: - Constraints
    
    func setupList() {
        view.addSubview(libraryCollectionView)
        NSLayoutConstraint.activate([
            libraryCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            libraryCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            libraryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            libraryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }
}

// MARK: - Collection View Delegate

extension LibraryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemeCell.identifier,
                                                            for: indexPath) as? MemeCell else { return MemeCell() }
        if indexPath.section == 0 && indexPath.row == 0 {
            cell.configureCell(UIImage(systemName: "plus.circle"), title: "")
        } else {
            cell.configureCell(UIImage(systemName: "circle"), title: "мем №1")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            let topMemeController = TopMemesViewController()
            navigationController?.pushViewController(topMemeController, animated: true)
        }
    }
}
