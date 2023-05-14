//
//  With.swift
//  JAUIKit
//
//  Created by Andy on 06/03/2023.
//

import UIKit

public protocol With {}

public extension With where Self: AnyObject {
    @discardableResult
    func with<T>(_ property: ReferenceWritableKeyPath<Self, T>, setTo value: T) -> Self {
        self[keyPath: property] = value
        return self
    }
}

extension UIView: With {}
