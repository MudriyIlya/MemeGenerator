//
//  TopMemesViewController.swift
//  Marketplace
//
//  Created by Илья Мудрый on 21.08.2021.
//

import UIKit

final class TopMemesViewController: UIViewController {

    // MARK: - Variables
    
    private lazy var listCollectionView: MemeCollectionView = {
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
        view.backgroundColor = .green
        title = "Выбери шаблон"
        setupList()
    }
    
    // MARK: - Constraints
    
    func setupList() {
        view.addSubview(listCollectionView)
        NSLayoutConstraint.activate([
            listCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            listCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            listCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            listCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }
}

// MARK: - Collection View Delegate

extension TopMemesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemeCell.identifier,
                                                            for: indexPath) as? MemeCell else { return MemeCell() }
        cell.configureCell(UIImage(systemName: "scribble"), title: "")
        return cell
    }
}
