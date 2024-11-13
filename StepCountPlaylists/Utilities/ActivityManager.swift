//
//  ActivityManager.swift
//  StepCountPlaylists
//
//  Created by Oleksandr Kryvodub on 13.11.2024.
//

import Foundation

enum ActivityManager {
    
    static func calculateActivity(from stepsByDate: [Date: Int]) -> ActivityLevel {
        var avgStepCountForHour: [Int: Int] = [:]
        // Calculating average steps for every hour throughout last week
        for value in 0...23 {
            let nearestHourDate = Date().adding(hours: value).nearestHour()
            avgStepCountForHour[nearestHourDate.asHours] = calculateStepsFor(hours: value, date: nearestHourDate, stepsByDate: stepsByDate)
        }

        let maxStepCount = Array(avgStepCountForHour.values).max() ?? 0
        let minStepCount = Array(avgStepCountForHour.values).min() ?? 0
        let avgStepCount = minStepCount + maxStepCount / 2
        let lowerBound = minStepCount + avgStepCount / 2
        let upperBound = maxStepCount - avgStepCount / 2
        let stepsForNow = avgStepCountForHour[Date().asHours] ?? 0
        
        if stepsForNow < lowerBound {
            return .low
        } else if stepsForNow >= lowerBound && stepsForNow < upperBound {
            return .moderate
        } else {
            return .high
        }
    }
    
    // Iterating through every day of the week to calculate an average step for a given time
    private static func calculateStepsFor(hours: Int, date: Date, stepsByDate: [Date: Int]) -> Int {
        var stepCountArray: [Int] = []
        for value in -7...0 {
            let date = date.adding(days: value)
            if let steps = stepsByDate[date] {
                stepCountArray.append(steps)
            }
        }

        let avgStepCount = stepCountArray.reduce(0, +) / stepCountArray.count
        return avgStepCount
    }
}
