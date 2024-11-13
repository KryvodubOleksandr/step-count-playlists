//
//  Array.swift
//  StepCountPlaylists
//
//  Created by Oleksandr Kryvodub on 13.11.2024.
//

import Foundation
import HealthKit

extension Array where Element == HKAuthorizationStatus {
    var minimumCommonStatus: HKAuthorizationStatus {
        var minComStatus: HKAuthorizationStatus = .sharingAuthorized
        self.forEach { status in
            if status == .notDetermined || status == .sharingDenied {
                minComStatus = status
            }
        }
        return minComStatus
    }
}
