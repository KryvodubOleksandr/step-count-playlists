//
//  RootViewModel.swift
//  StepCountPlaylists
//
//  Created by Oleksandr Kryvodub on 12.11.2024.
//

import Foundation
import HealthKit

class RootViewModel: ObservableObject {
    @Published var authorizationStatus: HKAuthorizationStatus
    private let hkAuthorizationManager: HKAuthorizing
    private let hkObjectType: HKSampleType
    
    init(hkAuthorizationManager: HKAuthorizing) {
        self.hkAuthorizationManager = hkAuthorizationManager
        self.hkObjectType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        self.authorizationStatus = hkAuthorizationManager.getAuthorizationStatuses(for: [hkObjectType]).minimumCommonStatus
    }
    
    @MainActor
    func requestAuthorizations() async throws {
        let statuses = try await hkAuthorizationManager.requestAuthorizations(for: [hkObjectType])
        self.authorizationStatus = statuses.minimumCommonStatus
    }
}
