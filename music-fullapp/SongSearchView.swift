//
//  SongSearchView.swift
//  music-fullapp
//
//  Created by toño on 25/08/25.
//

import SwiftUI

struct SongSearchView: View {
    @StateObject private var vm = SongSearchViewModel()

    var body: some View {
        NavigationStack {
            if vm.isLoadingInitial {
                ProgressView("Loading songs...") // Loading indicator when fetching initial songs
            } else if vm.displayedSongs.isEmpty && vm.query.count >= 2 && !vm.isSearching {
                ContentUnavailableView("No results for \(vm.query)", systemImage: "magnifyingglass")
            } else {
                List(vm.displayedSongs) { song in
                    NavigationLink(destination: SongDetailsView(song: song, imageURL: song.imageURL)) {
                        VStack(alignment: .leading) {
                            Text(song.title)
                                .font(.headline)
                            Text(song.artist)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text(song.album)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
        }
        .navigationTitle("Songs")
        .task { await vm.loadInitial() }
        .searchable(text: $vm.query, prompt: "Search songs")
        .onChange(of: vm.query) { _, _ in
            vm.search() // Trigger search when the query changes
        }
        .onSubmit(of: .search) {
            vm.search() // Handle submission
        }
    }
}

#Preview {
    SongSearchView()
}
