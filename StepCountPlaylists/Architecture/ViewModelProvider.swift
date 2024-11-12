//
//  ViewModelProvider.swift
//  StepCountPlaylists
//
//  Created by Alexander Sharko on 12.11.2024.
//

import Foundation

enum ViewModelProvider {
    static var playlists: PlaylistsViewModel {
        PlaylistsViewModel(stepCountStore: healthStore)
    }
}
