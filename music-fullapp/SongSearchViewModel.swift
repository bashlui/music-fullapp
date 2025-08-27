//
//  SongSearchViewModel.swift
//  music-fullapp
//
//  Created by toño on 25/08/25.
//

import SwiftUI

@MainActor
class SongSearchViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var allSongs: [Song] = []
    @Published var results: [Song] = []
    @Published var isLoadingInitial = false
    @Published var isSearching = false
    
    private let api = MusicAPIService()
    private var searchTask: Task<Void, Never>?

    // Display all songs if the query is less than 2 characters
    var displayedSongs: [Song] {
        query.trimmingCharacters(in: .whitespacesAndNewlines).count >= 2 ? results : allSongs
    }

    // Fetch initial songs
    func loadInitial() async {
        guard allSongs.isEmpty else { return }
        isLoadingInitial = true
        defer { isLoadingInitial = false }
        do {
            allSongs = try await api.fetchSongs()
        } catch {
            allSongs = []
            print("Initial fetch failed:", error)
        }
    }
    
    // Search function with debouncing
    func search() {
        // Cancel previous search task
        searchTask?.cancel()
        
        // Create a new search task with a debounce effect
        searchTask = Task {
            let q = query.trimmingCharacters(in: .whitespacesAndNewlines)
            guard q.count >= 2 else {
                results = []
                return
            }
            try? await Task.sleep(nanoseconds: 300_000_000) // 0.3 seconds debounce
            
            // Cancel if the task was interrupted
            guard !Task.isCancelled else { return }

            do {
                isSearching = true
                results = try await api.searchSongs(query: q)
            } catch {
                results = []
                print("Search failed:", error)
            }
            isSearching = false
        }
    }
}

