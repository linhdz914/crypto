//
//  Encodable+Extension.swift
//  iStudy
//

import Foundation

struct JSON {
    static let encoder = JSONEncoder()
}

extension Encodable {
    subscript(key: String) -> Any? {
        return dictionary[key]
    }
    var dictionary: [String: Any] {
        let tmp = (try? JSONSerialization.jsonObject(with: JSON.encoder.encode(self))) as? [String: Any] ?? [:]
        return tmp
    }
    
    var jsonString: String {
        if let theJSONData = try?  JSONSerialization.data( withJSONObject: dictionary, options: []),
        let theJSONText = String(data: theJSONData, encoding: String.Encoding.ascii)
        {
            return theJSONText
        }
        return ""
    }
}
