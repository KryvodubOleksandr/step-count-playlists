//
//  HealthKitManager.swift
//  StepCountPlaylists
//
//  Created by Oleksandr Kryvodub on 13.11.2024.
//

import Foundation
import HealthKit

final class HealthKitManager {
    let store: HKHealthStore
    
    init(store: HKHealthStore) {
        self.store = store
    }
}

//MARK: - HKAuthorizing
extension HealthKitManager: HKAuthorizing {
    func requestAuthorizations(for types: Set<HKSampleType>) async throws -> [HKAuthorizationStatus] {
        try await store.requestAuthorization(toShare: types, read: types)
        return getAuthorizationStatuses(for: types)
    }
    
    func getAuthorizationStatuses(for types: Set<HKSampleType>) -> [HKAuthorizationStatus] {
        types.map { store.authorizationStatus(for: $0) }
    }
}

//MARK: - HKStepsLoading
extension HealthKitManager: HKStepsLoading {
    func loadStepsByDate(completion: @escaping ([Date: Int]) -> Void) throws {
        guard let startOfWeek = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: Date()) else {
            throw CalendarError.dateCreation
        }
        var stepsByDateDict: [Date: Int] = [:]
        let query = try prepareQuery()
        
        query.initialResultsHandler = { query, results, error in
            results?.enumerateStatistics(from: startOfWeek, to: Date()) { result, _ in
                let stepCount = Int(result.sumQuantity()?.doubleValue(for: HKUnit.count()) ?? 0)
                stepsByDateDict[result.startDate] = stepCount
            }
            completion(stepsByDateDict)
        }
        
        store.execute(query)
    }
    
    private func prepareQuery() throws -> HKStatisticsCollectionQuery {
        guard let stepCountType = HKObjectType.quantityType(forIdentifier: .stepCount) else {
            throw HealthKitError.stepCountType
        }
        
        var interval = DateComponents()
        interval.hour = 1
        
        let calendar = Calendar.current
        guard let anchorDate = calendar.date(bySettingHour: 12, minute: 0, second: 0, of: Date()) else {
            throw CalendarError.dateCreation
        }

        let query = HKStatisticsCollectionQuery.init(
            quantityType: stepCountType,
            quantitySamplePredicate: nil,
            options: .cumulativeSum,
            anchorDate: anchorDate,
            intervalComponents: interval
        )
        return query
    }
}
