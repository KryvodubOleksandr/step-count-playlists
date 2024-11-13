//
//  HKAuthorizing.swift
//  StepCountPlaylists
//
//  Created by Oleksandr Kryvodub on 12.11.2024.
//

import Foundation
import HealthKit

protocol HKAuthorizing {
    func requestAuthorizations(for types: Set<HKSampleType>) async throws -> [HKAuthorizationStatus]
    func getAuthorizationStatuses(for types: Set<HKSampleType>) -> [HKAuthorizationStatus]
}
