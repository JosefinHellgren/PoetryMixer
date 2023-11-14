//
//  PoetryDj.swift
//  WeatherPoetry
//
//  Created by josefin hellgren on 2023-10-25.
//

import Foundation

class PoetryDj : ObservableObject {
    
    static func mixTwoPoems(poem1: [String], poem2: [String]) -> [String] {
        var remixedPoem = poem1 + poem2
        remixedPoem.shuffle()
        return remixedPoem
    }
    static func mixPoems(userPoem: String, poem: inout PoemResponse?) {
        if let userPoemText = Archive.loadPoemWithTitle(title: userPoem),
           let poemLines = poem?.lines {
            let mixedLines = PoetryDj.mixTwoPoems(poem1: poemLines, poem2: userPoemText)
            poem = PoemResponse(title: "Remixed Poem", author: "You and \(poem?.author ?? "some other poet")", lines: mixedLines)
        }
    }
}
