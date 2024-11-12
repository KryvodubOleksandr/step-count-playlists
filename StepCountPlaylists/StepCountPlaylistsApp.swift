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
    
    @State private var isAuthorized: Bool = false

    var body: some Scene {
        WindowGroup {
            if isAuthorized {
                PlaylistView()
            } else {
                Text("")
                    .onAppear {
                        getHealthKitAuthorization {
                            isAuthorized = $0
                        }
                    }
            }
        }
    }
}

//MARK: - getHealthKitAuthorization
extension StepCountPlaylistsApp {
    private func getHealthKitAuthorization(completion: @escaping (Bool) -> Void) {
        let healthKitTypes: Set = [HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!]
        healthStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { (success, error) in
            completion(success)
        }
    }
}
