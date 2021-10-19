//
//  AppDelegate.swift
//  Filter Cam
//
//  Created by leeesangheee on 2021/10/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        
        window?.rootViewController = MainViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
}
