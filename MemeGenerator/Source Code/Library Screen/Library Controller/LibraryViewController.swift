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
        title = "Твои мемасики"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "paintbrush"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(openSettings))
    }
    
    override func viewWillLayoutSubviews() {
        setupConstraints()
    }
    
    // MARK: - Setup Constraints
    
    func setupConstraints() {
        view.addSubview(libraryCollectionView)
        NSLayoutConstraint.activate([
            libraryCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            libraryCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            libraryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            libraryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // MARK: - Buttons
    @objc private func openSettings() {
        let settingsView = SettingsViewController()
        navigationController?.pushViewController(settingsView, animated: true)
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
            cell.configureCell(with: UIImage(systemName: "plus.circle"))
        } else {
            cell.configureCell(with: UIImage(systemName: "circle"))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            let topMemeController = TopMemesViewController()
            navigationController?.pushViewController(topMemeController, animated: true)
        } else {
            // TODO: брать картинку из массива мемов
            guard let image = UIImage(systemName: "pencil") else { return }
            let previewViewController = PreviewViewController(withImage: image)
            navigationController?.pushViewController(previewViewController, animated: true)
        }
    }
}
