//
//  URLSessionAPIClient.swift
//  GameApp
//
//  Created by Akademija on 12.06.2023..
//

import Foundation

struct NetworkManager {
    
    func fetchGenres() async throws -> GenresResponse? {
        guard let url = URL(string: "https://api.rawg.io/api/genres?key=08795c3e1e2245d9a95a1c3c017f0323") else { return nil }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode(GenresResponse.self, from: data)
            return decodedData
        } catch {
            print("Error fetching genres:", error)
            throw error
        }
    }
    
    func fetchDetails(id: Int) async throws -> DetailResponse? {
        guard let url = URL(string: "https://api.rawg.io/api/games/\(String(id))?key=08795c3e1e2245d9a95a1c3c017f0323") else { return nil }
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decodedData = try JSONDecoder().decode(DetailResponse.self, from: data)
        return decodedData
    }
    
}







