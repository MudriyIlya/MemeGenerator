//
//  MemesCollectionTests.swift
//  MemeGeneratorTests
//
//  Created by Илья Мудрый on 10.09.2021.
//

import XCTest
@testable import MemeGenerator

class MemesCollectionTests: XCTestCase {
    
    var memesCollection: MemesCollection!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        memesCollection = MemesCollection()
    }
    
    override func tearDownWithError() throws {
        memesCollection = nil
        try super.tearDownWithError()
    }
    
    // MARK: Append Memes
    
    func testAppendNewMemeToEmptyCollection() {
        // arrange
        let emptyMemeCollection = MemesCollection()
        let meme = Meme(id: nil, category: Category("dogs"), imageURL: "https://host/dog.png")
        // act
        memesCollection.append(meme, for: meme.category)
        // assert
        let message = "Количество записей равно количеству записуй в пустой коллекции!"
        XCTAssertNotEqual(emptyMemeCollection.countCategories(), memesCollection.countCategories(), message)
    }
    
    // MARK: Count Categories
    
    func testAllCategoriesQuantityEqualsToOneWhenCollectionIsNotEmpty() {
        // arrange
        let meme = Meme(id: nil, category: Category("cats"), imageURL: "https://host/cat.png")
        // act
        memesCollection.append(meme, for: meme.category)
        let countMemesCategories = memesCollection.countCategories()
        
        XCTAssert(countMemesCategories == 1, "Плохо, количество категорий не совпадает с ожидаемым результатом")
    }
    
    func testAllCategoriesCountEqualsZeroWhenMemesCollectionIsEmpty() {
        // arrange
        // act
        let countMemesCategories = memesCollection.countCategories()
        // assert
        XCTAssert(countMemesCategories == 0, "Поражен вашей неудачей! Здесь должно быть равно 0")
    }
    
    // MARK: Count Meme in Category
    
    func testCountMemesInCategoryIsNotEqualToZero() {
        // arrange
        let meme = Meme(id: nil, category: Category("cats"), imageURL: "https://host/cat.png")
        memesCollection.append(meme, for: meme.category)
        // act
        let category = memesCollection.allCategories()
        guard let firstCategory = category.first else { return }
        let memesCountInCategory = memesCollection.countMemes(in: firstCategory)
        // assert
        XCTAssert(memesCountInCategory != 0, "Поражен вашей неудачей! Здесь НЕ должно быть равно 0")
    }
    
    func testCountMemesInNonExistInCategoryIsEqualToZero() {
        // arrange
        // act
        let memesCountInCategory = memesCollection.countMemes(in: Category("aliens"))
        // assert
        XCTAssertEqual(memesCountInCategory, 0, "Поражен вашей неудачей! Здесь НЕ должно быть равно 0")
    }
    
    // MARK: Get Memes in Non Existing Category
    
    func testGetMemesInNonExistingCategoryEqualsNil() {
        // arrange
        // act
        let memesInCategory = memesCollection.memes(in: Category("aliens"))
        // assert
        XCTAssertNil(memesInCategory, "Такая категория существует, проверь на несуществующей")
    }
    
    // MARK: Get Meme in Existing Category
    
    func testGetMemeInExistingCategoryIsNotEqualNil() {
        // arrange
        let meme = Meme(id: nil, category: Category("cats"), imageURL: "https://host/cat.png")
        memesCollection.append(meme, for: meme.category)
        // act
        let category = memesCollection.allCategories()
        guard let firstCategory = category.first else { return }
        let memeInCategory = memesCollection.meme(in: firstCategory, for: 0)
        // assert
        XCTAssertNotNil(memeInCategory, "Элемента не существует вернулся nil")
    }
    
    // MARK: Get Meme in Non Existing Category
    
    func testGetMemeInNonExistingCategoryIsEqualNil() {
        // arrange
        let meme = Meme(id: nil, category: Category("cats"), imageURL: "https://host/cat.png")
        memesCollection.append(meme, for: meme.category)
        // act
        let memeInCategory = memesCollection.meme(in: Category("aliens"), for: 0)
        // assert
        XCTAssertNil(memeInCategory, "Такая категория существует nil не вернулся")
    }
    
    // MARK: Get Meme in Existing Category for Not Existing index
    
    func testGetMemeInExistingCategoryForNonExistingIndexIsNil() {
        // arrange
        let meme = Meme(id: nil, category: Category("cats"), imageURL: "https://host/cat.png")
        memesCollection.append(meme, for: meme.category)
        // act
        let category = memesCollection.allCategories()
        guard let firstCategory = category.first else { return }
        let memeInCategory = memesCollection.meme(in: firstCategory, for: 3)
        // assert
        XCTAssertNil(memeInCategory, "Такой элемент существует nil не вернулся")
    }
    
    func testRemoveAllFromMemesCollection() {
        for index in 0..<10 {
            let meme = Meme(id: nil, category: Category("cats"), imageURL: "https://host/cat\(index).png")
            memesCollection.append(meme, for: meme.category)
        }
        
        // act
        memesCollection.removeAll()
        let countMemesCategories = memesCollection.countCategories()
        
        XCTAssert(countMemesCategories == 0, "Плохо, коллекция не очистилась")
    }
    
    func testCollectionReturnMemesInCategory() {
        for index in 0..<3 {
            let meme = Meme(id: nil, category: Category("cats"), imageURL: "https://host/cat\(index).png")
            memesCollection.append(meme, for: meme.category)
        }
        for index in 0..<2 {
            let meme = Meme(id: nil, category: Category("dogs"), imageURL: "https://host/dog\(index).png")
            memesCollection.append(meme, for: meme.category)
        }
        for index in 0..<5 {
            let meme = Meme(id: nil, category: Category("people"), imageURL: "https://host/people\(index).png")
            memesCollection.append(meme, for: meme.category)
        }
        
        // act
        var catsCategory: Category!
        memesCollection.allCategories().forEach { category in
            catsCategory = category
        }
        let memesInCatsCategory = memesCollection.memes(in: catsCategory)
        
        XCTAssertNotNil(memesInCatsCategory, "Плохо, не получил ожидаемых мемасов")
    }
}
