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

    var body: some View {
        VStack {
            Text(welcome.isEmpty ? "Loading..." : welcome)
                .padding()
        }
        .task {
            await loadWelcome()
        }
    }

    @MainActor
    private func loadWelcome() async {
        do {
            welcome = try await api.welcomeMessage()
        } catch {
            welcome = "Failed: \(error.localizedDescription)"
        }
    }
}

#Preview {
    ContentView()
}
