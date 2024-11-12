//
//  HKAuthorizable.swift
//  StepCountPlaylists
//
//  Created by Alexander Sharko on 12.11.2024.
//

import Foundation
import HealthKit

extension HKHealthStore: HKAuthorizing {}

protocol HKAuthorizing {
    func requestAuthorization(toShare typesToShare: Set<HKSampleType>, read typesToRead: Set<HKObjectType>) async throws
    func authorizationStatus(for type: HKObjectType) -> HKAuthorizationStatus
}
