//
//  PlaylistsView.swift
//  StepCountPlaylists
//
//  Created by Oleksandr Kryvodub on 12.11.2024.
//

import SwiftUI

struct PlaylistsView: View {
    
    @StateObject var playlistsVM = ViewModelProvider.playlists
    
    var body: some View {
        Group {
            if let activityLevel = playlistsVM.activityLevel {
                Text("Your average activity for this time of day is: \(activityLevel.rawValue)")
                    .font(.title)
            } else {
                ProgressView()
            }
        }
        .padding()
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

#Preview {
    PlaylistsView()
}
