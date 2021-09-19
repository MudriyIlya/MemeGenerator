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
    
    // MARK: - Count
    
    func count() -> Int {
        return Documents.files.count
    }
    
    // MARK: - Save
    func save(_ meme: PreviewMeme, completion: () -> Void) {
        let filePath = Documents.path.appendingPathComponent(meme.name + ".png")
        do {
            guard let data = meme.image.pngData() else { return }
            try data.write(to: filePath)
            completion()
        } catch let error { print("Saving file to \"Documents\" error: ", error) }
    }
    
    // MARK: - Restore
    
    func restorePreviewMemes(completion: ([PreviewMeme]) -> Void) {
        var images = [PreviewMeme]()
        Documents.files.forEach { path in
            let filePath = Documents.path.appendingPathComponent(path)
            guard let fileData = FileManager.default.contents(atPath: filePath.path) else { return }
            guard let image = UIImage(data: fileData) else { return }
            images.append(PreviewMeme(withName: filePath.deletingPathExtension().lastPathComponent, image: image))
        }
        completion(images.sorted { $0.name > $1.name })
    }
    
    // MARK: - Remove
    
    func remove(previewMeme meme: PreviewMeme, completion: () -> Void) {
        let filePath = Documents.path.appendingPathComponent(meme.name + ".png")
        do {
            try FileManager.default.removeItem(at: filePath)
            completion()
        } catch {
            print(error)
        }
    }
}
