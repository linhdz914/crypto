//
//  Array+Extensions.swift
//  JAUIKit
//
//  Created by Andy on 06/03/2023.
//

import Foundation

public extension Array {
    mutating func modifyForEach(_ body: (_ index: Index, _ element: inout Element) -> ()) {
        for index in indices {
            modifyElement(atIndex: index) { body(index, &$0) }
        }
    }
    
    mutating func modifyElement(atIndex index: Index, _ modifyElement: (_ element: inout Element) -> ()) {
        var element = self[index]
        modifyElement(&element)
        self[index] = element
    }
}

public extension Array where Element: Equatable {
    mutating func modify(at item: Element, _ modifyElement: (_ element: inout Element) -> ()) {
        if let firstIndex = self.firstIndex(of: item) {
            var element = self[firstIndex]
            modifyElement(&element)
            self[firstIndex] = element
        }
    }
}
