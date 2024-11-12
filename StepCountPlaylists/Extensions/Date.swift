//
//  Date.swift
//  StepCountPlaylists
//
//  Created by Alexander Sharko on 12.11.2024.
//

import Foundation

extension Date {
    func nearestHour() -> Date {
        return Date(timeIntervalSinceReferenceDate:
                (timeIntervalSinceReferenceDate / 3600.0).rounded(.toNearestOrEven) * 3600.0)
    }
    
    func adding(days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: self)!
    }
    
    func adding(hours: Int) -> Date {
        return Calendar.current.date(byAdding: .hour, value: hours, to: self)!
    }
    
    var asHours: Int {
        Int(DateFormatter.hourStyle.string(from: self)) ?? 0
    }
}

extension DateFormatter {
    static var hourStyle: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        return formatter
    }()
}
