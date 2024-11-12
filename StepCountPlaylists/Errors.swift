//
//  Errors.swift
//  StepCountPlaylists
//
//  Created by Oleksandr Kryvodub on 12.11.2024.
//

import Foundation

enum HealthKitError: LocalizedError {
    case stepCountType
    
    var errorDescription: String? {
        switch self {
        case .stepCountType:
            return "Unable to get the step count type"
        }
    }
}

enum CalendarError: LocalizedError {
    case dateCreation
    
    var errorDescription: String? {
        switch self {
        case .dateCreation:
            return "Unable to get create a date"
        }
    }
}
