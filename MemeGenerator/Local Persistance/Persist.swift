//
//  Persist.swift
//  MemeGenerator
//
//  Created by Илья Мудрый on 14.09.2021.
//

import Foundation

@propertyWrapper struct Persist<T> {
    
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get { UserDefaults.standard.object(forKey: key) as? T ?? defaultValue }
        set { UserDefaults.standard.setValue(newValue, forKey: key) }
    }
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
}
