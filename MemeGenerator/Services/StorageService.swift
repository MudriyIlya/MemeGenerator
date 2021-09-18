//
//  StorageService.swift
//  Paint
//
//  Created by Илья Мудрый on 28.07.2021.
//

import Foundation
import UIKit

struct StorageService {
    
    // MARK: - Helper
    
    private struct Documents {
        static var path: URL {
            let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return urls[0]
        }
        
        static var files: [String] {
            let filePath = Documents.path
            do {
                let files = try FileManager.default.contentsOfDirectory(atPath: filePath.path)
                return files.filter { $0.hasSuffix(".png") || $0.hasSuffix(".jpg") || $0.hasSuffix(".jpeg") }
            } catch let error {
                print("Reading files error: ", error)
                return [String]()
            }
        }
    }
    
    // MARK: - Save
    
    func save(_ image: UIImage, with name: String, completion: () -> Void) {
        let filePath = Documents.path.appendingPathComponent(name + ".png")
        do {
            guard let data = image.pngData() else { return }
            try data.write(to: filePath)
            completion()
        } catch let error { print("Saving file to \"Documents\" error: ", error) }
    }
    
    // MARK: - Restore
    
    func restoreImages(completion: ([UIImage]) -> Void) {
        var images = [UIImage]()
        Documents.files.forEach { path in
            let filePath = Documents.path.appendingPathComponent(path)
            guard let fileData = FileManager.default.contents(atPath: filePath.path) else { return }
            guard let image = UIImage(data: fileData) else { return }
            images.append(image)
        }
        // TODO: Сортировку по дате изменения
//        #warning("Сделать сортировку по дате изменения")
        completion(images)
    }
    
    // MARK: - Count
    
    func count() -> Int {
        return Documents.files.count
    }
}
