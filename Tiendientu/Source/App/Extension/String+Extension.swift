//
//  String+Extension.swift
//  iStudy
//

import Foundation
import UIKit

extension String {
    var isValidCharacterPassword: Bool {
        let regex = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$"
        return range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    var isValidPhoneNumber: Bool {
        let regex = "^(0)[0-9]{5,16}$"
        return range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    var isValidName: Bool {
        let regex = "^[\\sa-zA-Z']{0,32}$"
        return range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    var isValidEmail: Bool {
        let regex = "^(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])$"
        return range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    var dateTimeFormat: Date? {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
        return formatter.date(from: self)
    }
    
    var dateTimeFormatLearningGoal: Date? {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "GMT+7")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: self)
    }
    
    var getUTCTime: String {
        if let date = self.getDateUserInput {
            let formatter = DateFormatter()
            formatter.timeZone = TimeZone(abbreviation: "UTC")
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
            return formatter.string(from: date)
        }
        return ""
    }
    
    var getDate: Date? {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
        return formatter.date(from: self)
    }
    
    var getDateUserInput: Date? {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "MM/dd/yyyy HH:mm"
        return formatter.date(from: self)
    }
    
    var getBirthDateCurrentYear: Date? {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "dd/MM/yyyy"
        guard let date = formatter.date(from: self) else { return nil }
        
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.day, .month, .year], from: date)
        dateComponents.year = Date().year
        return calendar.date(from: dateComponents)
    }
    
    var getDayInWeek: String? {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
        let date = formatter.date(from: self)
        if let date = date {
            formatter.dateFormat = "EEEE, HH:mm"
            return formatter.string(from: date)
        } else {
            return nil
        }
    }
    
    var getHourInDay: String? {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
        let date = formatter.date(from: self)
        formatter.dateFormat = "HH:mm"
        if date != nil {
            return formatter.string(from: date!)
        }
        return nil
    }
    
    var getDateTimeForField: String? {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
        let date = formatter.date(from: self)
        formatter.dateFormat = "dd-MM-yyyy"
        if date != nil {
            return formatter.string(from: date!)
        }
        return nil
    }
    
    var getDateForCalendar: String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
        let date = formatter.date(from: self)
        formatter.dateFormat = "dd MMMM, HH:mm"
        if date != nil {
            return formatter.string(from: date!)
        }
        return ""
    }
    
    var getDateAndMonth: String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
        let date = formatter.date(from: self)
        formatter.dateFormat = "dd MMM"
        if date != nil {
            return formatter.string(from: date!)
        }
        return ""
    }
    
    var getMonthAndYear: String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        let date = formatter.date(from: self)
        formatter.dateFormat = "Month yyyy"
        if date != nil {
            return formatter.string(from: date!)
        }
        return ""
    }
    
    var getDeletingTime: String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
        let date = formatter.date(from: self)
        if date != nil {
            if Calendar.current.isDateInToday(date!) {
                return "today"
            } else if Calendar.current.isDateInTomorrow(date!) {
                return "tomorrow"
            } else if date! > Date() {
                let inDays = Calendar.current.dateComponents([.day], from: Date(), to: date!).day!
                return "in \(inDays) days"
            }
        }
        return ""
    }
    
    var getNextVisitMeetingDate: String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
        let date = formatter.date(from: self)
        if let date = date {
            formatter.dateFormat = "EEEE, dd MMMM HH:mm"
            return formatter.string(from: date)
        } else {
            return ""
        }
    }
    
    var getDateOfBirth: String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "dd/MM/yyyy"
        let date = formatter.date(from: self)
        if let date = date {
            formatter.dateFormat = "dd MMMM yyyy"
            return formatter.string(from: date)
        } else {
            return ""
        }
    }
    
    var getDateTimeForVacation: String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "YYYY-MM-dd"
        let date = formatter.date(from: self)
        if let date = date {
            formatter.dateFormat = "dd MMM"
            return formatter.string(from: date)
        } else {
            return ""
        }
    }
    
    var getDayInWeekForChart: String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "YYYY-MM-dd"
        let date = formatter.date(from: self)
        if let date = date {
            formatter.dateFormat = "EEEE"
            return formatter.string(from: date)
        } else {
            return ""
        }
    }
    
    var getHoursInFloat: Float {
        let hours = self.components(separatedBy: ":").first
        let minutes = self.components(separatedBy: ":").last
        if let hours = hours, let minutes = minutes {
            if hours.count == 0 || minutes.count == 0 {
                return 0.0
            }
            let m = Float(minutes)!/60.0
            return Float(Float(hours)! + m)
        }
        return 0.0
    }
    
    var getHoursInFloatWithDate: Float {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
        let date = formatter.date(from: self)
        formatter.dateFormat = "HH:mm"
        if date != nil {
            let string = formatter.string(from: date!)
            let hours = string.components(separatedBy: ":").first
            let minutes = string.components(separatedBy: ":").last
            let m = Float(minutes!)!/60.0
            return Float(Float(hours!)! + m)
        }
        return 0.0
    }

    
    var getDayIndex: Int {
        switch self {
        case "Monday":
            return 0
        case "Tuesday":
            return 1
        case "Wednesday":
            return 2
        case "Thursday":
            return 3
        case "Friday":
            return 4
        case "Saturday":
            return 5
        case "Sunday":
            return 6
        default:
            return 0
        }
    }
    
    var capitalizedSentence: String {
        // 1
        let firstLetter = self.prefix(1).capitalized
        // 2
        let remainingLetters = self.dropFirst().lowercased()
        // 3
        return firstLetter + remainingLetters
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}

extension String {
    func toPrioriyColor() -> UIColor? {
        switch self.lowercased() {
        case "hight": return UIColor.Color_FC4A4A
        case "medium": return UIColor.Color_FEB546
        default: return UIColor.Color_2CB4EC
        }
    }
}


extension NSMutableAttributedString {
    public func appendText(text: String, font: UIFont, color: UIColor) {
        let attributedText = NSAttributedString(string: text,
                                                attributes: [.foregroundColor: color, .font: font])
        self.append(attributedText)
    }
    
    public func setLineSpacing(spacing: CGFloat = 1) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        self.addAttribute(NSAttributedString.Key.paragraphStyle,
                          value:paragraphStyle,
                          range: .init(location: 0, length: length))
    }
}
