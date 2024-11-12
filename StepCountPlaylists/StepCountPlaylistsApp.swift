//
//  StepCountPlaylistsApp.swift
//  StepCountPlaylists
//
//  Created by Oleksandr Kryvodub on 12.11.2024.
//

import SwiftUI
import HealthKit
import HealthKitUI

let healthStore = HKHealthStore()

@main
struct StepCountPlaylistsApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
