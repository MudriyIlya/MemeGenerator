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
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Palette.backgroundColor
        title = "Настройки"
        setupConstraints()
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.heightAnchor.constraint(equalToConstant: SettingsTable.height),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
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
        cell.checkmarkButtonTapped()
        tableView.reloadData()
    }
}
