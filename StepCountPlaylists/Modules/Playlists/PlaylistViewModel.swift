//
//  PlaylistViewModel.swift
//  StepCountPlaylists
//
//  Created by Oleksandr Kryvodub on 12.11.2024.
//

import Foundation
import SwiftUI

final class PlaylistViewModel: ObservableObject {
    @Published var activityLevel: ActivityLevel?
    private let hkStepsManager: HKStepsLoading
    
    init(hkStepsManager: HKStepsLoading) {
        self.activityLevel = nil
        self.hkStepsManager = hkStepsManager
    }
    
    func getActivity() throws {
        try hkStepsManager.loadStepsByDate { [weak self] stepsByDate in
            DispatchQueue.main.async {
                self?.activityLevel = ActivityManager.calculateActivity(from: stepsByDate)
            }
        }
    }
}
