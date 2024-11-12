//
//  Playlist.swift
//  StepCountPlaylists
//
//  Created by Alexander Sharko on 12.11.2024.
//

import Foundation

struct Playlist: Identifiable {
    let title: String
    let activityLevel: ActivityLevel
    
    var id: String { title }
}

extension Playlist {
    static var mockPlaylists: [Self] {
        [
            Playlist(title: "Calm waves", activityLevel: .low),
            Playlist(title: "Gentle Drift", activityLevel: .low),
            Playlist(title: "Soft Echoes", activityLevel: .low),
            Playlist(title: "Whispers of Calm", activityLevel: .low),
            
            Playlist(title: "Focus on yourself", activityLevel: .moderate),
            Playlist(title: "Steady Flow", activityLevel: .moderate),
            Playlist(title: "Midday Groove", activityLevel: .moderate),
            Playlist(title: "Balanced Pulse", activityLevel: .moderate),
            
            Playlist(title: "High energy boost", activityLevel: .high),
            Playlist(title: "Ignite the Beat", activityLevel: .high),
            Playlist(title: "Surge Ahead", activityLevel: .high),
            Playlist(title: "Electric Pulse", activityLevel: .high)
        ]
    }
}
