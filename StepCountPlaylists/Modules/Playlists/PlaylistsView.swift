//
//  PlaylistsView.swift
//  StepCountPlaylists
//
//  Created by Oleksandr Kryvodub on 12.11.2024.
//

import SwiftUI

struct PlaylistsView: View {
    @StateObject var playlistsVM = ViewModelProvider.playlists
    @State private var playlists: [Playlist] = Playlist.mockPlaylists
    
    var body: some View {
        Group {
            if let activityLevel = playlistsVM.activityLevel {
                playlistsView(for: activityLevel)
            } else {
                loaderView
            }
        }
        .onAppear {
            //TODO: Add proper error handling
            do {
                try playlistsVM.loadSteps()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

//MARK: - playlistsView
extension PlaylistsView {
    func playlistsView(for activityLevel: ActivityLevel) -> some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Here are some playlists that might match your typical (\(activityLevel.rawValue)) energy level for this time of day:")
                        .font(.body)
                    ForEach(playlists) { playlist in
                        if playlist.activityLevel == playlistsVM.activityLevel {
                            Text(playlist.title)
                                .font(.title2)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .frame(height: 70)
                                .background {
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color.gray.opacity(0.3))
                                }
                        }
                    }
                }
                .padding()
            }
            .animation(.default, value: playlistsVM.activityLevel)
            .navigationTitle("Playlists")
        }
    }
}

//MARK: - loaderView
extension PlaylistsView {
    var loaderView: some View {
        VStack {
            Text("Fetching your activity data...")
            ProgressView()
        }
    }
}

#Preview {
    PlaylistsView()
}
