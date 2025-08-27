//
//  ContentView.swift
//  music-fullapp
//
//  Created by toño on 22/08/25.
//

import SwiftUI

struct ContentView: View {
    @State private var welcome: String = ""
    private let api = MusicAPIService()

    @MainActor
    private func loadWelcome() async {
        do {
            welcome = try await api.welcomeMessage()
        } catch {
            welcome = "Failed: \(error.localizedDescription)"
        }
    }

    var body: some View {
        NavigationStack {
            List {
                // Section for the welcome message
                Section {
                    if welcome.isEmpty {
                        ProgressView("Loading...") // Display loading indicator
                            .progressViewStyle(CircularProgressViewStyle())
                    } else {
                        Text(welcome)
                            .font(.headline)
                            .foregroundColor(.primary)
                    }
                }
                .task {
                    await loadWelcome() // Load data as soon as the view appears
                }
                
                // Navigation section to the SongSearchView
                Section {
                    NavigationLink("Search Songs") {
                        SongSearchView() // Navigate to song search view
                    }
                }
            }
            .navigationTitle("Music App")
            .navigationBarTitleDisplayMode(.inline) // Keep the title consistent
        }
    }
}

#Preview {
    ContentView()
}
