//
//  Memes.swift
//  MemeGenerator
//
//  Created by Илья Мудрый on 09.09.2021.
//

struct MemesCollection {
    
    private var allMemes = [String: [Meme]]()
    
    mutating func append(_ meme: Meme, for key: Category) {
        if var memeFromMemes = allMemes[key.current] {
            memeFromMemes.append(meme)
            allMemes[key.current] = memeFromMemes
        } else {
            allMemes[key.current] = [meme]
        }
    }
    
    func countCategories() -> Int {
        return allMemes.keys.count
    }

    func allCategories() -> [Category] {
        return Array(allMemes.keys.map { key in
            return Category(current: key)
        }).sorted { $0.current < $1.current }
    }
    
    func memes(in category: Category) -> [Meme]? {
        guard let memes = allMemes[category.current] else { return nil }
        return memes
    }
    
    func getMeme(in category: Category, for index: Int) -> Meme? {
        guard let memesFromCategory = allMemes[category.current] else { return nil }
        return memesFromCategory[index]
    }
}
