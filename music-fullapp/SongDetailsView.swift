//
//  SongDetailsView.swift
//  music-fullapp
//
//  Created by toño on 25/08/25.
//

import SwiftUI

struct SongDetailsView: View {
    let song: Song
    let imageURL: URL?
    var headerHeight: CGFloat = 260

    var body: some View {
        VStack(spacing: 0) {
            // --- Minimal Hero ---
            ZStack(alignment: .bottomLeading) {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .empty:
                        Rectangle()
                            .fill(Color.secondary.opacity(0.15))
                            .overlay(ProgressView())
                    case .success(let image):
                        image.resizable().scaledToFill()
                    case .failure:
                        ZStack {
                            Rectangle().fill(Color.secondary.opacity(0.15))
                            Image(systemName: "music.note")
                                .font(.system(size: 44, weight: .light))
                                .foregroundStyle(.secondary)
                        }
                    @unknown default:
                        Color.clear
                    }
                }
                .frame(height: headerHeight)
                .clipped()
                .overlay(
                    LinearGradient(
                        colors: [.black.opacity(0.55), .clear],
                        startPoint: .bottom,
                        endPoint: .top
                    )
                )

                VStack(alignment: .leading, spacing: 6) {
                    Text(song.title)
                        .font(.title.bold())
                        .foregroundStyle(.white)
                        .lineLimit(2)
                    Text(song.artist)
                        .font(.headline)
                        .foregroundStyle(.white.opacity(0.9))
                        .lineLimit(1)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 14)
            }
            // --- End Minimal Hero ---

            // ScrollView for rest of details
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Album: \(song.album)")
                    Text("Year: \(song.year)")
                    Text("Genre: \(song.genre)")
                    if !song.description.isEmpty {
                        Divider().padding(.vertical, 6)
                        Text(song.description)
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
