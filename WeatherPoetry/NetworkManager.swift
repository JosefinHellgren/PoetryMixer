//
//  NetworkManager.swift
//  WeatherPoetry
//
//  Created by josefin hellgren on 2023-10-19.
//

import Foundation

enum ApiError: Error {
    case cannotDecode
    case error
}

class NetworkManager {
    
    static func getRandomPoem() async throws -> PoemResponse {
        let url = URL(string: "https://poetrydb.org/random")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        let randomPoem = try decoder.decode([PoemResponse].self, from: data)
     
        if let poem = randomPoem.first {
            return poem
        } else {
    
            throw ApiError.cannotDecode
        }
    }
}

struct PoemResponse: Codable, Equatable, Hashable,Identifiable {
    let id = UUID()
    let title: String
    let author: String
    var lines: [String]
    
    mutating func shuffleLines() {
        self.lines.shuffle()
    }
    static func == (lhs: PoemResponse, rhs: PoemResponse) -> Bool {
           return lhs.title == rhs.title &&
                  lhs.author == rhs.author &&
                  lhs.lines == rhs.lines
       }
}







