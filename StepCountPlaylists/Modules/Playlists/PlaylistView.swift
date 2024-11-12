//
//  PlaylistView.swift
//  StepCountPlaylists
//
//  Created by Oleksandr Kryvodub on 12.11.2024.
//

import SwiftUI

struct PlaylistView: View {
    @StateObject var playlistVM = ViewModelProvider.playlist
    @State private var audioTracks: [AudioTrack] = AudioTrack.mockTracks
    
    var body: some View {
        Group {
            if let activityLevel = playlistVM.activityLevel {
                tracksList(for: activityLevel)
            } else {
                loaderView
            }
        }
        .onAppear {
            //TODO: Add proper error handling
            do {
                try playlistVM.loadSteps()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

//MARK: - playlistsView
extension PlaylistView {
    func tracksList(for activityLevel: ActivityLevel) -> some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Here are some tracks you might like at this time of the day:")
                        .font(.body)
                    ForEach(audioTracks) { track in
                        if track.activityLevel == playlistVM.activityLevel {
                            Text(track.title)
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
            .animation(.default, value: playlistVM.activityLevel)
            .navigationTitle("\(activityLevel.rawValue) playlist")
        }
    }
}

//MARK: - loaderView
extension PlaylistView {
    var loaderView: some View {
        VStack {
            Text("Fetching your activity data...")
            ProgressView()
        }
    }
}

#Preview {
    PlaylistView()
}
