//
//  Storyboard.swift
//  iStudy
//
//  Created by Kien Trung on 2022/10/28.
//

import UIKit

enum StoryboardName: String {
    case main = "Main"
}

struct Storyboard {
    static func load<T: UIViewController>(_ name: StoryboardName, type: T.Type, isInitial: Bool? = false) -> T {
        let vcName = String(describing: type)
        if isInitial == true {
            guard let vc = UIStoryboard(name: name.rawValue, bundle: nil).instantiateInitialViewController() as? T else {
                fatalError("Cannot initialize storyboard with name \(name.rawValue)")
            }
            return vc
        }

        guard let vc = UIStoryboard(name: name.rawValue, bundle: nil).instantiateViewController(withIdentifier: vcName) as? T else {
            fatalError("Cannot initialize storyboard with name \(name.rawValue)")
        }
        return vc
    }
}

