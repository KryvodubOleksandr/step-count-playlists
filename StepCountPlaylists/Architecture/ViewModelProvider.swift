//
//  ViewModelProvider.swift
//  StepCountPlaylists
//
//  Created by Oleksandr Kryvodub on 12.11.2024.
//

import Foundation

enum ViewModelProvider {
    static var playlist: PlaylistViewModel {
        PlaylistViewModel(hkStepsManager: healthKitManager)
    }
    
    static var root: RootViewModel {
        RootViewModel(hkAuthorizationManager: healthKitManager)
    }
}
