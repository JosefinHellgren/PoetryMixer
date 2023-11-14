//
//  Archive.swift
//  WeatherPoetry
//
//  Created by josefin hellgren on 2023-10-26.
//

import Foundation

class Archive {
    
    static var userPoems: [String: String] {
        get {
            if let storedUserPoems = UserDefaults.standard.dictionary(forKey: "UserCreatedPoems") as? [String: String] {
                return storedUserPoems
            }
            return [:]
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "UserCreatedPoems")
        }
    }
    
    static func saveFavouritePoem(poem: PoemResponse) {
        
        let savedPoem = PoemResponse(title: poem.title , author: poem.author , lines: poem.lines)
        
        if let encodedPoem = try? JSONEncoder().encode(savedPoem) {
            
            UserDefaults.standard.set(encodedPoem, forKey: "favourite_poem_\(poem.title)")
        }
        
        
    }
    
    
    static func loadFavouritePoems() -> [PoemResponse] {
        var poems: [PoemResponse] = []
        let keys = UserDefaults.standard.dictionaryRepresentation().keys
        for key in keys {
            if key.hasPrefix("favourite_poem_") {
                if let data = UserDefaults.standard.data(forKey: key) {
                    do {
                        let decoder = JSONDecoder()
                        let poem = try decoder.decode(PoemResponse.self, from: data)
                        poems.append(poem)
                    } catch {
                        print("Error decoding poem: \(error)")
                    }
                }
            }
        }
        return poems
    }
    private func deletePoem() {
        
    }
    
    static func loadPoems() -> [String: String] {
        if let poemDictionary = UserDefaults.standard.dictionary(forKey: "UserCreatedPoems") as? [String: String] {
            return poemDictionary
        } else {
            return [:]
        }
    }
    
    static func loadPoemWithTitle(title: String) -> [String]? {
        if let userPoems = UserDefaults.standard.dictionary(forKey: "UserCreatedPoems") as? [String: String],
           let poem = userPoems[title] {
            let poemLines = poem.components(separatedBy: "\n")
            return poemLines
        } else {
            return nil
        }
    }
    
    
    static func writeYourOwnPoem(poem: String) {
        let poemLines = poem.components(separatedBy: "\n")
        if let firstLine = poemLines.first {
            var poems = userPoems
            poems[firstLine] = poem
            userPoems = poems
        }
    }
}
