//
//  Date+Extensions.swift
//  iStudy
//
//

import Foundation

extension Date {
    func timeAgoDisplay() -> String {
        if #available(iOS 13.0, *) {
            let formatter = RelativeDateTimeFormatter()
            formatter.unitsStyle = .full
            return formatter.localizedString(for: self, relativeTo: Date())
        } else {
            // Fallback on earlier versions
            return ""
        }
    }
}

extension Date {
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}
