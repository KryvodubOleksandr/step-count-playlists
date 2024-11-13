//
//  AudioTrack.swift
//  StepCountPlaylists
//
//  Created by Oleksandr Kryvodub on 12.11.2024.
//

import Foundation

struct AudioTrack: Identifiable {
    let title: String
    let activityLevel: ActivityLevel
    
    var id: String { title }
}

extension AudioTrack {
    static var mockTracks: [Self] {
        [
            AudioTrack(title: "Calm waves", activityLevel: .low),
            AudioTrack(title: "Gentle Drift", activityLevel: .low),
            AudioTrack(title: "Soft Echoes", activityLevel: .low),
            AudioTrack(title: "Whispers of Calm", activityLevel: .low),
            
            AudioTrack(title: "Focus on yourself", activityLevel: .moderate),
            AudioTrack(title: "Steady Flow", activityLevel: .moderate),
            AudioTrack(title: "Midday Groove", activityLevel: .moderate),
            AudioTrack(title: "Balanced Pulse", activityLevel: .moderate),
            
            AudioTrack(title: "High energy boost", activityLevel: .high),
            AudioTrack(title: "Ignite the Beat", activityLevel: .high),
            AudioTrack(title: "Surge Ahead", activityLevel: .high),
            AudioTrack(title: "Electric Pulse", activityLevel: .high)
        ]
    }
}

enum ActivityLevel: String {
    case low = "Relaxing"
    case moderate = "Focused"
    case high = "Energizing"
}
