//
//  MusicAPIService.swift
//  music-fullapp
//
//  Created by toño on 24/08/25.
//

import Foundation

struct WelcomeResponse : Codable {
    let message: String
}

struct Wrapper : Codable {
    let items: [Song]
}

struct SongResponse : Codable {
    let song : Song
}

private let baseURL = "https://music-api-service-1cp0.onrender.com"

func welcomeMessage() async throws -> String {
        guard let url = URL(string: "\(baseURL)/") else { throw URLError(.badURL) }
        let (data, _) = try await URLSession.shared.data(from: url)

        // Decode as an array of strings and return the first
        let messages = try JSONDecoder().decode([String].self, from: data)
        guard let message = messages.first else { throw URLError(.cannotParseResponse) }
        return message
    }
    
func fetchSongs() async throws -> [Song] {
    guard let url = URL(string: "\(baseURL)/songs") else {
        throw URLError(.badURL)
    }
    let (data, _) = try await URLSession.shared.data(from: url)
    let wrapper = try JSONDecoder().decode(Wrapper.self, from: data)
    return wrapper.items
}
 

func fetchSong(id: Int) async throws -> Song {
    guard let url = URL(string: "\(baseURL)/api/song") else {
        throw URLError(.badURL)
    }
    let (data, _) = try await URLSession.shared.data(from: url)
    return try JSONDecoder().decode(Song.self, from: data)
}

func createSong(_ song: Song) async throws -> Song {
    guard let url = URL(string: "\(baseURL)/songs") else {
        throw URLError(.badURL)
    }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = try JSONEncoder().encode(song)

    let (data, _) = try await URLSession.shared.data(for: request)
    return try JSONDecoder().decode(Song.self, from: data)
}


