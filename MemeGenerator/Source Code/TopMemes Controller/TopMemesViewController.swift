//
//  TopMemesViewController.swift
//  Marketplace
//
//  Created by Илья Мудрый on 21.08.2021.
//

import UIKit

final class TopMemesViewController: UIViewController {
    
    // MARK: - Variables
    
    private lazy var topMemesCollectionView: MemeCollectionView = {
        let collectionView = MemeCollectionView(enableHeader: true)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MemeCell.self, forCellWithReuseIdentifier: MemeCell.identifier)
        collectionView.register(SectionHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SectionHeader.identifier)
        return collectionView
    }()
    
    private var networkService: NetworkServiceProtocol
    private var memesData = MemesCollection()
    
    // MARK: - Initialization
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.networkService = NetworkService()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemGray2
        title = "Выбери шаблон"
        loadDataFromServer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        setupList()
    }
    
    // MARK: - Load Data
    private func loadDataFromServer() {
        view.startSpinner()
        networkService.getMemes { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let responseData):
                self.dataMapper(responseData)
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showErrorAlert(with: error.message)
                    self.view.stopSpinner()
                }
            }
        }
    }
    
    private func dataMapper(_ response: [MemeDataResponse]) {
        response.forEach { memeData in
            let newMeme = Meme(id: memeData.id, category: Category(memeData.category), imageURL: memeData.imageURL)
            self.memesData.append(newMeme, for: newMeme.category)
        }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.topMemesCollectionView.reloadData()
            self.view.stopSpinner()
        }
    }
    
    // MARK: - Constraints
    
    func setupList() {
        view.addSubview(topMemesCollectionView)
        NSLayoutConstraint.activate([
            topMemesCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            topMemesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            topMemesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            topMemesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }
}

// MARK: - Collection View Delegate

extension TopMemesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return memesData.countCategories()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let categories = memesData.allCategories()
        guard let memes = memesData.memes(in: categories[section]) else { return 0 }
        return memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemeCell.identifier,
                                                            for: indexPath) as? MemeCell else { return MemeCell() }
        let categories = memesData.allCategories()
        if let memes = memesData.memes(in: categories[indexPath.section]) {
            cell.configureCell(with: memes[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                      withReuseIdentifier: SectionHeader.identifier,
                                                                                      for: indexPath) as? SectionHeader
            else { return SectionHeader() }
            let categories = memesData.allCategories()
            guard let memes = memesData.memes(in: categories[indexPath.section]) else { return SectionHeader() }
            if indexPath.section < memes.count {
                sectionHeader.label.text = memes[indexPath.section].category.current.uppercased()
            }
            return sectionHeader
        } else {
            // No footer
            return UICollectionReusableView()
        }
    }
}
