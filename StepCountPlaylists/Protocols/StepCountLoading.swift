//
//  StepCountLoading.swift
//  StepCountPlaylists
//
//  Created by Oleksandr Kryvodub on 12.11.2024.
//

import Foundation
import HealthKit

extension HKHealthStore: StepCountLoading {}

protocol StepCountLoading {
    func execute(_ query: HKQuery)
}
