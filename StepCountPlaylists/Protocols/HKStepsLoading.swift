//
//  HKStepsLoading.swift
//  StepCountPlaylists
//
//  Created by Oleksandr Kryvodub on 12.11.2024.
//

import Foundation

protocol HKStepsLoading {
    func loadStepsByDate(completion: @escaping ([Date: Int]) -> Void) throws
}
