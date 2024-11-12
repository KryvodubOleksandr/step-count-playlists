//
//  RootViewModel.swift
//  StepCountPlaylists
//
//  Created by Alexander Sharko on 12.11.2024.
//

import Foundation
import HealthKit

class RootViewModel: ObservableObject {
    @Published var authorizationStatus: HKAuthorizationStatus
    private let hkAuthorizingStore: HKAuthorizing
    private let hkObjectType: HKObjectType
    
    init(hkAuthorizingStore: HKAuthorizing) {
        self.hkAuthorizingStore = hkAuthorizingStore
        self.hkObjectType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        self.authorizationStatus = healthStore.authorizationStatus(for: hkObjectType)
    }
    
    @MainActor
    func getHealthKitAuthorization() async throws {
        let healthKitTypes: Set = [HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!]
        try await hkAuthorizingStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes)
        self.authorizationStatus = hkAuthorizingStore.authorizationStatus(for: hkObjectType)
    }
}
