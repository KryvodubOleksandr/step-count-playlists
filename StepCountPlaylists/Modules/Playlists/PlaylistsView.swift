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
        ScrollView {
            LazyVStack {
                ForEach(dates, id: \.self) { date in
                    Text(date.description)
                }
            }
        }
        .padding()
        .onAppear {
            do {
                try playlistsVM.loadSteps()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    var dates: [Date] {
        Array(playlistsVM.stepsByDate.keys)
    }
}

#Preview {
    PlaylistsView()
}
