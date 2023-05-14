//
//  Double+Extension.swift
//  iStudy
//

import Foundation

extension Double {
    var positionalTime: String {
        Formatter.positional.allowedUnits = self >= 3600 ?
        [.hour, .minute, .second] :
        [.minute, .second]
        let string = Formatter.positional.string(from: self)!
        return string.hasPrefix("0") && string.count > 4 ?
            .init(string.dropFirst()) : string
    }
    
    func getTimeString(style: DateComponentsFormatter.UnitsStyle) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute]
        formatter.unitsStyle = style
        return formatter.string(from: self) ?? ""
    }
    
    var timeString: String {
        let hour = Int(self) / 3600
        let minute = Int(self) / 60 % 60
        let second = Int(self) % 60
        
        if hour == 0 {
            return String(format: "%02i:%02i", minute, second)
        } else {
            return String(format: "%02i:%02i:%02i", hour, minute, second)
        }
        
    }
}
