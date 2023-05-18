//
//  AppDelegate.swift
//  Currrency
//
//  Created by Linh on 18/05/2023.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
                window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                window?.makeKeyAndVisible()

                return true
    }

    // MARK: UISceneSession Lifecycle



}

