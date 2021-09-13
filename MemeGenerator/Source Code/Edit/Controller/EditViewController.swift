//
//  EditViewController.swift
//  MemeGenerator
//
//  Created by Илья Мудрый on 11.09.2021.
//

import UIKit

final class EditViewController: UIViewController {
    
    // MARK: - VARIABLES
    
    private lazy var editor: EditorView = {
        let view = EditorView()
        return view
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.delegate = self
        textView.isScrollEnabled = false
        //        textView.backgroundColor = UIColor.clear
        textView.backgroundColor = UIColor.random()
        textView.textAlignment = .center
        textView.text = ""
        textView.isHidden = true
        return textView
    }()
    
    private lazy var textViewBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0, alpha: 0.4)
        view.isHidden = true
        return view
    }()
    
    // MARK: - INITIALIZATION
    
    convenience init(withMeme meme: Meme) {
        self.init(nibName: nil, bundle: nil)
        self.editor.downloadMemeFromServer(meme.imageURL)
    }
    
    // MARK: - LIFECYCLE
    
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
        let tap = UITapGestureRecognizer(target: self, action: #selector(stopTexting))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // TODO: удалить это, чтобы картинка подгружалась из инета при
        // загрузке экрана через инит, а это только хардкод
        editor.downloadMemeFromServer("people07.png")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        prepareTextView()
    }
    
    private func prepareTextView() {
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
            textView.centerYAnchor.constraint(equalTo: textViewBackground.centerYAnchor),
            textView.leadingAnchor.constraint(equalTo: textViewBackground.leadingAnchor, constant: 100),
            textView.trailingAnchor.constraint(equalTo: textViewBackground.trailingAnchor, constant: -100),
            textView.heightAnchor.constraint(equalToConstant: 40)
        ])
        textViewDidChange(textView)
    }
    
    // MARK: - BUTTONS
    
    @objc private func saveMemeButtonTapped() {
        print("мем сохранился в галерею")
    }
    
    private func addTextButtonTapped() {
        editor.addTextButtonTap = { [weak self] in
            self?.addText()
        }
    }
    
    private func addText() {
        textViewBackground.isHidden = false
        textView.isHidden = false
        textView.text = "Жги 🔥"
        textView.becomeFirstResponder()
    }
    
    @objc private func hideKeyboard() {
        textViewBackground.isHidden = true
        textView.isHidden = true
        textView.resignFirstResponder()
    }
    
    @objc func stopTexting() {
        if !textView.attributedText.isEqual(to: NSAttributedString(string: "")) {
            editor.addLabelWith(self.textView.attributedText)
        }
        textView.attributedText = NSAttributedString(string: "")
        hideKeyboard()
    }
}

// MARK: - UITEXTVIEW DELEGATE

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
    
    func textViewDidBeginEditing(_ textView: UITextView) {
//        textView.insertTextPlaceholder(with: )
//        textView.text = nil
    }
}
