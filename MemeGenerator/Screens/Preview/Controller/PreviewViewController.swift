//
//  PreviewViewController.swift
//  MemeGenerator
//
//  Created by Илья Мудрый on 11.09.2021.
//

import UIKit

final class PreviewViewController: UIViewController {

    // MARK: - Variables
    
    private lazy var preview: Preview = {
        let view = Preview()
        return view
    }()
    
    // MARK: - Initialization
    
    convenience init(withImage image: UIImage) {
        self.init(nibName: nil, bundle: nil)
        self.preview.setMeme(image)
    }
    
    // MARK: - Lifecycle

    override func loadView() {
        view = preview
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.down"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(saveToCameraRollButtonPressed))
        let tap = UITapGestureRecognizer(target: self, action: #selector(navigationBarHiddenToggle))
        view.addGestureRecognizer(tap)
    }
    
    // MARK: - Hide / Show Elements
    
    @objc private func navigationBarHiddenToggle() {
        if preview.backgroundColor == UIColor.black {
            preview.setDefaultBackground()
        } else {
            preview.backgroundColor = UIColor.black
        }
        navigationController?.navigationBar.isHidden.toggle()
        tabBarController?.tabBar.isHidden.toggle()
    }
    
    // MARK: - Save to Camera Roll
    
    @objc private func saveToCameraRollButtonPressed() {
        guard let image = preview.getMeme() else { return }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let alert = UIAlertController(title: "Ошибка сохранения", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Грустно...", style: .default))
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Готово", message: "Мем сохранился в Фото", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Круто!", style: .default))
            present(alert, animated: true)
        }
    }
}
