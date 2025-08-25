//
//  Song.swift
//  music-fullapp
//
//  Created by toño on 23/08/25.
//

import Foundation

struct Song: Identifiable, Codable {
    let id: Int
    let title: String
    let artist: String
    let album: String
    let year: Int
    let genre: String
    let imageURL: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, artist, album, year, genre, description
        case imageURL = "image_url"
    }
}
