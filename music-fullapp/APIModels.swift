//
//  APIModels.swift
//  music-fullapp
//
//  Created by toño on 23/08/25.
//


struct WelcomeResponse : Codable {
    let message: String
}

struct Wrapper : Codable {
    let items: [Song]
}

struct SongResponse : Codable {
    let song : Song
}

