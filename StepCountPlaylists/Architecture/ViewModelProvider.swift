//
//  ViewModelProvider.swift
//  StepCountPlaylists
//
//  Created by Alexander Sharko on 12.11.2024.
//

import Foundation

enum ViewModelProvider {
    static var playlist: PlaylistViewModel {
        PlaylistViewModel(stepCountStore: healthStore)
    }
    
    static var root: RootViewModel {
        RootViewModel(hkAuthorizingStore: healthStore)
    }
}
