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
        tabBarController?.tabBar.isHidden = true
        title = "Сделай мем"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                            target: self,
                                                            action: #selector(saveMemeButtonTapped))
        addTextButtonTapped()
        addImageButtonTapped()
        let tap = UITapGestureRecognizer(target: self, action: #selector(endOfTextEditing))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
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
            textView.centerYAnchor.constraint(equalTo: textViewBackground.centerYAnchor),
            textView.leadingAnchor.constraint(equalTo: textViewBackground.leadingAnchor, constant: 100),
            textView.trailingAnchor.constraint(equalTo: textViewBackground.trailingAnchor, constant: -100)
        ])
    }
    
    // MARK: - Buttons
    
    // Add Text to Meme
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
    
    // Add Image to Meme
    private func addImageButtonTapped() {
        editor.imageTap = { [weak self] in
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            
            func openCamera() {
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    imagePicker.sourceType = .camera
                    self?.present(imagePicker, animated: true)
                } else {
                    let alert = UIAlertController(title: "Упс! Что-то пошло не так...", message: "На Вашем устройстве нет камеры", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ясно", style: .default, handler: nil))
                    self?.present(alert, animated: true)
                }
            }
            
            func openLibrary() {
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    imagePicker.sourceType = .photoLibrary
                    self?.present(imagePicker, animated: true)
                } else {
                    let alert = UIAlertController(title: "Упс! Что-то пошло не так...", message: "У Вас нет доступа к галерее", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ясно", style: .default, handler: nil))
                    self?.present(alert, animated: true)
                }
            }
            
            let alert = UIAlertController(title: "Откуда хотите выбрать изображение?", message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Камера", style: .default, handler: { _ in
                openCamera()
            }))
            alert.addAction(UIAlertAction(title: "Галерея", style: .default, handler: { _ in
                openLibrary()
            }))
            alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
            self?.present(alert, animated: true)
        }
    }
    
    // Save Meme
    @objc private func saveMemeButtonTapped() {
        showNameAlertController()
    }
    
    // Hide Text Editor
    @objc func endOfTextEditing() {
        if !textView.attributedText.isEqual(to: NSAttributedString(string: "")) {
            editor.addLabelWith(self.textView.attributedText)
        }
        textView.attributedText = NSAttributedString(string: "")
        hideKeyboard()
    }
    
    // Hide Keyboard
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

// MARK: - Image Picker Delegate

extension EditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        editor.add(image)
        dismiss(animated: true)
    }
}

// MARK: - Save Meme to File System

extension EditViewController {
    
    private func showNameAlertController() {
        let nameAlertController = UIAlertController(title: "Сохранить как:", message: nil, preferredStyle: .alert)
        nameAlertController.addTextField { (textField: UITextField) in
            textField.placeholder = "IMG\(StorageService().count() + 1)"
            textField.text = ""
            textField.clearButtonMode = .whileEditing
        }
        
        let saveAndReturnAction = UIAlertAction(title: "Сохранить", style: .default) { [weak self] _ in
            guard let self = self,
                  var imageName = nameAlertController.textFields?.first?.text else { return }
            if imageName == "" { imageName = "IMG\(StorageService().count() + 1)" }
            self.saveMeme(imageName, completion: self.backToLibrary)
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        nameAlertController.addAction(saveAndReturnAction)
        nameAlertController.addAction(cancelAction)
        
        self.navigationController?.present(nameAlertController, animated: true, completion: nil)
    }
    
    private func saveMeme(_ name: String, completion: () -> Void) {
        let imageToSave = editor.getMemeImage()
        StorageService().save(imageToSave, with: name, completion: completion)
    }
    
    private func backToLibrary() {
        tabBarController?.tabBar.isHidden = false
        tabBarController?.selectedIndex = 0
        navigationController?.popViewController(animated: true)
    }
}
