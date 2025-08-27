//
//  MusicAPIService.swift
//  music-fullapp
//
//  Created by toño on 24/08/25.
//

import SwiftUI
import Foundation

class MusicAPIService {
    private let baseURL = "https://music-api-service-1cp0.onrender.com"

    struct WelcomeResponse: Decodable { let message: String }

    // Welcome message function
    func welcomeMessage() async throws -> String {
        guard let url = URL(string: "\(baseURL)/") else { throw URLError(.badURL) }
        let (data, _) = try await URLSession.shared.data(from: url)
        let res = try JSONDecoder().decode(WelcomeResponse.self, from: data)
        return res.message
    }
    
    // Fetching songs, getting all the list of songs
    func fetchSongs() async throws -> [Song] {
        guard let url = URL(string: "\(baseURL)/api/songs") else { throw URLError(.badURL) }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Song].self, from: data)
    }

    // Fetching songs by ID, just to test on the API terminal
    func fetchSong(id: Int) async throws -> Song {
        guard let url = URL(string: "\(baseURL)/api/songs/\(id)") else { throw URLError(.badURL) }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(Song.self, from: data)
    }

    // Create a song, providing the JSON, further implementation to create one on the APP.
    func createSong(_ song: Song) async throws -> Song {
        guard let url = URL(string: "\(baseURL)/api/song") else { throw URLError(.badURL) }
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.httpBody = try JSONEncoder().encode(song)
        let (data, _) = try await URLSession.shared.data(for: req)
        return try JSONDecoder().decode(Song.self, from: data)
    }

    // Searching for a song, further implementation
    func searchSongs(query: String) async throws -> [Song] {
        var comps = URLComponents(string: "\(baseURL)/api/songs/search")!
        comps.queryItems = [URLQueryItem(name: "q", value: query)]
        guard let url = comps.url else { throw URLError(.badURL) }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Song].self, from: data)
    }
}



