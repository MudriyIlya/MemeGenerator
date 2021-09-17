//
//  EditViewController.swift
//  MemeGenerator
//
//  Created by Илья Мудрый on 11.09.2021.
//

import UIKit

final class EditViewController: UIViewController {
    
    // MARK: - Variables
    
    private lazy var editor: EditorView = {
        let view = EditorView()
        return view
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.delegate = self
        textView.isScrollEnabled = false
        textView.backgroundColor = UIColor.clear
        textView.textAlignment = .center
        textView.text = ""
        textView.isHidden = true
        return textView
    }()
    
    private lazy var textViewBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.Palette.filterBackground
        view.isHidden = true
        return view
    }()
    
    // MARK: - Initialization
    
    convenience init(withMeme meme: Meme) {
        self.init(nibName: nil, bundle: nil)
        self.editor.downloadMemeFromServer(meme.imageURL)
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = editor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Сделай мем"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                            target: self,
                                                            action: #selector(saveMemeButtonTapped))
        // TODO:
        addTextButtonTapped()
        let tap = UITapGestureRecognizer(target: self, action: #selector(endOfTextEditing))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillLayoutSubviews() {
        setupTextEditorConstraints()
    }
    
    // MARK: - Setup Constraints
    
    private func setupTextEditorConstraints() {
        textViewBackground.addSubview(textView)
        view.addSubview(textViewBackground)
        NSLayoutConstraint.activate([
            textViewBackground.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textViewBackground.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            textViewBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textViewBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            textView.centerXAnchor.constraint(equalTo: textViewBackground.centerXAnchor),
            textView.bottomAnchor.constraint(equalTo: textViewBackground.centerYAnchor, constant: textViewBackground.bounds.height * 0.5),
            textView.leadingAnchor.constraint(equalTo: textViewBackground.leadingAnchor, constant: 100),
            textView.trailingAnchor.constraint(equalTo: textViewBackground.trailingAnchor, constant: -100),
            textView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // MARK: - Buttons
    
    // MARK: Add Text to Meme
    private func addTextButtonTapped() {
        editor.addTextButtonTap = { [weak self] in
            guard let self = self else { return }
            self.textViewBackground.isHidden = false
            self.textView.isHidden = false
            self.textView.text = "Жги 🔥"
            self.textView.becomeFirstResponder()
            self.textViewDidChange(self.textView)
        }
    }
    
    // MARK: Save Meme
    @objc private func saveMemeButtonTapped() {
        let image = editor.getMemeImage()
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let alert = UIAlertController(title: "Ошибка сохранения", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Грустно...", style: .default))
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Готово", message: "Демотиватор сохранился в Фото", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Круто!", style: .default))
            present(alert, animated: true)
        }
    }
    
    // MARK: Hide Text Editor and Keyboard
    @objc func endOfTextEditing() {
        if !textView.attributedText.isEqual(to: NSAttributedString(string: "")) {
            editor.addLabelWith(self.textView.attributedText)
        }
        textView.attributedText = NSAttributedString(string: "")
        hideKeyboard()
    }
    
    @objc private func hideKeyboard() {
        textViewBackground.isHidden = true
        textView.isHidden = true
        textView.resignFirstResponder()
    }
}

// MARK: - UITextView Delegate

extension EditViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: self.textView.frame.width,
                          height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach { constraint in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
}
