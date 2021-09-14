//
//  ButtonTableViewCell.swift
//  Lecture15
//
//  Created by Илья Мудрый on 19.07.2021.
//

import UIKit

final class SettingTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "SettingCell"
    
    private var isChecked = false
    private struct DoneButton {
        static let filled = UIImage(systemName: "circle.fill")
        static let empty = UIImage(systemName: "circle")
        private init() { }
    }
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.Palette.textColor
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var checkmarkImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        backgroundColor = UIColor.Palette.accent
        setCheckmark(isChecked)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Setup Constraints
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    override func updateConstraints() {
        contentView.addSubview(title)
        contentView.addSubview(checkmarkImage)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            title.trailingAnchor.constraint(equalTo: checkmarkImage.leadingAnchor)
        ])
        NSLayoutConstraint.activate([
            checkmarkImage.widthAnchor.constraint(equalToConstant: 40),
            checkmarkImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            checkmarkImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            checkmarkImage.leadingAnchor.constraint(equalTo: title.trailingAnchor),
            checkmarkImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
        super.updateConstraints()
    }
    
    // MARK: - Cell methods
    
    override func prepareForReuse() {
        self.title.text = nil
        self.setCheckmark(false)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
    }
    
    // MARK: - Configure cell methods
    
    public func setTitle(_ text: String) {
        self.title.text = text
    }
    
    public func setCheckmark(_ checkmark: Bool) {
        if checkmark {
            checkmarkImage.image = DoneButton.filled
            isChecked = false
        } else {
            checkmarkImage.image = DoneButton.empty
            isChecked = true
        }
    }
    
    @objc func checkmarkTapped() {
        if isChecked {
            checkmarkImage.image = DoneButton.empty
            isChecked = false
        } else {
            checkmarkImage.image = DoneButton.filled
            isChecked = true
        }
    }
}
