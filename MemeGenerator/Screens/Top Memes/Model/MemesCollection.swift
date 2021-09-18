//
//  Memes.swift
//  MemeGenerator
//
//  Created by Илья Мудрый on 09.09.2021.
//

struct MemesCollection {
    
    // MARK: Variables
    
    private var allMemes = [String: [Meme]]()
    
    mutating func append(_ meme: Meme, for key: Category) {
        if var memeFromMemes = allMemes[key.current] {
            memeFromMemes.append(meme)
            allMemes[key.current] = memeFromMemes
        } else {
            allMemes[key.current] = [meme]
        }
    }
    
    // MARK: Count Methods
    
    func countCategories() -> Int {
        return allMemes.keys.count
    }
    
    func countMemes(in category: Category) -> Int {
        guard let memesFromCategory = allMemes[category.current] else { return 0 }
        return memesFromCategory.count
    }
    
    // MARK: Get Methods

    func allCategories() -> [Category] {
        return Array(allMemes.keys.map { key in
            return Category(key)
        }).sorted { $0.current < $1.current }
    }
    
    func memes(in category: Category) -> [Meme]? {
        guard let memes = allMemes[category.current] else { return nil }
        return memes
    }
    
    func meme(in category: Category, for index: Int) -> Meme? {
        guard let memesFromCategory = allMemes[category.current] else { return nil }
        if index < memesFromCategory.count {
            return memesFromCategory[index]
        } else {
            return nil
        }   
    }
    
    mutating func removeAll() {
        allMemes.removeAll()
    }
}
