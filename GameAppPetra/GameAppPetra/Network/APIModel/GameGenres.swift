//
//  GameGanres.swift
//  GameApp
//
//  Created by Akademija on 12.06.2023..
//

import Foundation

struct Game: Decodable{
    let id: Int
    let slug: String
    let name: String
    let added: Int
}

struct Genre: Decodable {
    let id: Int
    let name: String
    let slug: String
    let games_count: Int
    let image_background: String
    let games: [Game]
}

 struct GenresResponse: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Genre]
    
    init(count: Int, next: String?, previous: String?, results: [Genre]) {
        self.count = count
        self.next = next
        self.previous = previous
        self.results = results
    }
    
}
