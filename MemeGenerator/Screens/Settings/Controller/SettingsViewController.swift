//
//  SettingsViewController.swift
//  MemeGenerator
//
//  Created by Илья Мудрый on 13.09.2021.
//

import UIKit

// MARK: UITableView Size Settings
private enum SettingsTable {
    static let rowHeight: CGFloat = 80
    static let height: CGFloat = rowHeight * 3
}

private enum AboutAuthor {
    static let width: CGFloat = 100
}

final class SettingsViewController: UIViewController {
    
    // MARK: - Variables
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        tableView.layer.cornerRadius = Constants.cornerRadius
        tableView.clipsToBounds = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingTableViewCell.self,
                           forCellReuseIdentifier: SettingTableViewCell.identifier)
        return tableView
    }()
    
    private lazy var instagramImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = AboutAuthor.width / 2
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var instagramLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = Constants.cornerRadius
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.textColor = UIColor.Palette.textColor
        let attributedText = NSAttributedString(string: "Илья Мудрый",
                                                attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
        label.attributedText = attributedText
        label.sizeToFit()
        label.isUserInteractionEnabled = true
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Palette.backgroundColor
        title = "Настройки"
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(instagramImageViewTapped))
        instagramImageView.addGestureRecognizer(imageTap)
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(instagramImageViewTapped))
        instagramLabel.addGestureRecognizer(labelTap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        instagramImageView.downloadInstagramImage()
    }
    
    override func viewWillLayoutSubviews() {
        setupConstraints()
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        view.addSubview(tableView)
        view.addSubview(instagramImageView)
        view.addSubview(instagramLabel)
            
        NSLayoutConstraint.activate([
            tableView.heightAnchor.constraint(equalToConstant: SettingsTable.height),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        NSLayoutConstraint.activate([
            instagramImageView.bottomAnchor.constraint(equalTo: instagramLabel.topAnchor, constant: -10),
            instagramImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            instagramImageView.widthAnchor.constraint(equalToConstant: AboutAuthor.width),
            instagramImageView.heightAnchor.constraint(equalTo: instagramImageView.widthAnchor)
        ])
        NSLayoutConstraint.activate([
            instagramLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            instagramLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func instagramImageViewTapped() {
        openInstagramViaTheURL("https://www.instagram.com/mudriy.ilya/")
    }
    
    private func openInstagramViaTheURL(_ string: String!) {
        if let url = URL(string: string), !url.absoluteString.isEmpty {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

// MARK: - UITableView Delegate
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SettingsTable.rowHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier,
                                                       for: indexPath) as? SettingTableViewCell
        else { return SettingTableViewCell() }
        
        switch indexPath.row {
        case 0:
            cell.setTitle("Системная")
        case 1:
            cell.setTitle("Светлая")
        case 2:
            cell.setTitle("Тёмная")
        default:
            cell.setTitle("Неизвестная")
        }
        
        if indexPath.row == Theme.current.rawValue {
            cell.setCheckmark(true)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SettingTableViewCell else { return }
        guard let theme = Theme(rawValue: indexPath.row) else { return }
        theme.setActive()
        cell.checkmarkTapped()
        tableView.reloadData()
    }
}
