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
    
    private lazy var createNewMemeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(systemName: "plus.square")
        let tapOnCreateNewMeme = UITapGestureRecognizer(target: self, action: #selector(openTopMemes))
        imageView.addGestureRecognizer(tapOnCreateNewMeme)
        imageView.tintColor = UIColor.Palette.tint
        imageView.isHidden = true
        return imageView
    }()
    
    private var memes = [UIImage]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Palette.backgroundColor
        title = "Твои мемасики"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "paintbrush"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(openSettings))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(openTopMemes))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memes.removeAll()
        StorageService().restoreImages(completion: { memeImages in
            memeImages.forEach { self.memes.append($0) }
            DispatchQueue.main.async { [weak self] in
                self?.createNewMemeImageView.isHidden = true
                self?.libraryCollectionView.reloadData()
            }
        })
        if memes.isEmpty {
            createNewMemeImageView.isHidden = false
        }
    }
    
    @objc private func openTopMemes() {
        tabBarController?.selectedIndex = 1
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
        view.addSubview(createNewMemeImageView)
        NSLayoutConstraint.activate([
            createNewMemeImageView.widthAnchor.constraint(equalToConstant: 40),
            createNewMemeImageView.heightAnchor.constraint(equalTo: createNewMemeImageView.widthAnchor),
            createNewMemeImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createNewMemeImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
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
        return memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemeCell.identifier,
                                                            for: indexPath) as? MemeCell else { return MemeCell() }
        cell.prepareForReuse()
        cell.configureCell(with: memes[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let previewViewController = PreviewViewController(withImage: memes[indexPath.row])
        navigationController?.pushViewController(previewViewController, animated: true)
    }
}
