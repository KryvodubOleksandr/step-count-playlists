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
    @Published var activityLevel: ActivityLevel?
    @Published var stepsByDate: [Date: Int] {
        didSet { calculateActivity() }
    }
    private let stepCountStore: StepCountLoading
    
    init(stepCountStore: StepCountLoading) {
        self.stepsByDate = [:]
        self.stepCountStore = stepCountStore
        self.activityLevel = nil
    }
}

//MARK: - calculateActivity
extension PlaylistsViewModel {
    private func calculateActivity() {
        var avgStepCountForHour: [Int: Int] = [:]
        for value in 0...23 {
            let nearestHourDate = Date().adding(hours: value).nearestHour()
            avgStepCountForHour[nearestHourDate.asHours] = calculateStepsFor(hours: value, date: nearestHourDate)
        }
        
        let maxStepCount = Array(avgStepCountForHour.values).max() ?? 0
        let minStepCount = Array(avgStepCountForHour.values).min() ?? 0
        let avgStepCount = minStepCount + maxStepCount / 2
        let lowerBound = minStepCount + avgStepCount / 2
        let upperBound = maxStepCount - avgStepCount / 2
        let stepsForNow = avgStepCountForHour[Date().asHours] ?? 0
        
        withAnimation {
            if stepsForNow < lowerBound {
                self.activityLevel = .low
            } else if stepsForNow >= lowerBound && stepsForNow < upperBound {
                self.activityLevel = .moderate
            } else if stepsForNow >= upperBound {
                activityLevel = .high
            }
        }
    }
    
    private func calculateStepsFor(hours: Int, date: Date) -> Int {
        var stepCountArray: [Int] = []
        for value in -7...0 {
            let date = date.adding(days: value)
            if let steps = self.stepsByDate[date] {
                stepCountArray.append(steps)
            }
        }

        let avgStepCount = stepCountArray.reduce(0, +) / stepCountArray.count
        return avgStepCount
    }
}

//MARK: - loadSteps
//extension PlaylistsViewModel {
    enum ActivityLevel: String {
        case low, moderate, high
    }
//}

//MARK: - loadSteps
extension PlaylistsViewModel {
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
