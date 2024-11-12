//
//  PlaylistsViewModel.swift
//  StepCountPlaylists
//
//  Created by Oleksandr Kryvodub on 12.11.2024.
//

import Foundation
import SwiftUI
import HealthKit

final class PlaylistsViewModel: ObservableObject {
    @Published var stepsByDate: [Date: Int]
    private let stepCountStore: StepCountLoading
    
    init(stepCountStore: StepCountLoading) {
        self.stepsByDate = [:]
        self.stepCountStore = stepCountStore
    }
    
    private func getQuery() throws -> HKStatisticsCollectionQuery {
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
    
    func loadSteps() throws {
        guard let startOfWeek = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: Date()) else {
            throw CalendarError.dateCreation
        }
        var stepsByDateDict: [Date: Int] = [:]
        let query = try getQuery()
        
        query.initialResultsHandler = { [weak self] query, results, error in
            guard let self else { return }
            results?.enumerateStatistics(from: startOfWeek, to: Date()) { result, _ in
                let stepCount = Int(result.sumQuantity()?.doubleValue(for: HKUnit.count()) ?? 0)
                stepsByDateDict[result.startDate] = stepCount
            }
            
            DispatchQueue.main.async {
                self.stepsByDate = stepsByDateDict
            }
        }
        
        stepCountStore.execute(query)
    }
}
