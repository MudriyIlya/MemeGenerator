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
    
    private lazy var spinnerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var networkService: NetworkServiceProtocol
    private var coreDataService: CoreDataServiceProtocol
    private var memesData = MemesCollection()
    
    // MARK: - Initialization
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.networkService = NetworkService()
        self.coreDataService = CoreDataService()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Palette.backgroundColor
        title = "Выбери шаблон"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(newMemeFromScratch))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadDataFromServer()
    }
    
    override func viewWillLayoutSubviews() {
        setupConstraints()
    }
    
    // MARK: - Setup Constraints
    
    func setupConstraints() {
        view.addSubview(topMemesCollectionView)
        NSLayoutConstraint.activate([
            topMemesCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            topMemesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            topMemesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topMemesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc private func newMemeFromScratch() {
        let editViewController = EditViewController()
        navigationController?.pushViewController(editViewController, animated: true)
    }
    
    // MARK: - Load Data
    
    private func loadDataFromServer() {
        view.startSpinner()
        networkService.getMemes { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let responseData):
                self.prepareDataForUI(responseData)
            case .failure(let error):
                DispatchQueue.main.async {
                    self.view.stopSpinner()
                    self.showErrorAlert(with: error.message)
                    self.coreDataService.getMemesFromDatabase(completion: { memeResponse in
                        switch memeResponse {
                        case .success(let coreDataResult):
                            self.prepareMemesFromCoreDataForUI(coreDataResult)
                        case .failure(let coreDataError):
                            print("Ошибка загрузки мемов из CoreData \(coreDataError)")
                        }
                    })
                }
            }
        }
    }
    
    private func prepareDataForUI(_ response: [MemeDataResponse]) {
        var memesToCoreData = [Meme]()
        response.forEach { memeData in
            let newMeme = Meme(id: memeData.id, category: Category(memeData.category), imageURL: memeData.imageURL)
            self.memesData.append(newMeme, for: newMeme.category)
            memesToCoreData.append(newMeme)
        }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.coreDataService.deleteAll()
            self.coreDataService.save(memesToCoreData)
            self.topMemesCollectionView.reloadData()
            self.view.stopSpinner()
        }
    }
    
    private func prepareMemesFromCoreDataForUI(_ response: [Meme]) {
        response.forEach { meme in
            let newMeme = Meme(id: meme.id, category: Category(meme.category.current), imageURL: meme.imageURL)
            self.memesData.append(newMeme, for: newMeme.category)
        }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.topMemesCollectionView.reloadData()
        }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let categories = memesData.allCategories()
        if let memes = memesData.memes(in: categories[indexPath.section]) {
            let meme = memes[indexPath.row]
            let editViewController = EditViewController(withMeme: meme)
            navigationController?.pushViewController(editViewController, animated: true)
        }
    }
}
