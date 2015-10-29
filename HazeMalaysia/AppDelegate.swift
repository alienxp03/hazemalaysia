//
//  AppDelegate.swift
//  HazeIndex
//
//  Created by Muhammad Azuan Zira Zairein on 13/10/2015.
//  Copyright © 2015 Muhammad Azuan Zira Zairein. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        UINavigationBar.appearance().tintColor = .whiteColor()
        setup()
        return true
    }
}

extension AppDelegate {
    func setup() {
        UITabBar.appearance().translucent = false
        
        if Settings.firstLaunch == nil {
            let viewController = UIStoryboard(name: "Introduction", bundle: nil).instantiateViewControllerWithIdentifier("IntroductionViewController")
            window?.rootViewController = viewController
            window?.makeKeyAndVisible()
        } else {
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
            window?.rootViewController = viewController
            window?.makeKeyAndVisible()
        }
        
        Initializers.setup()
    }
    
    func showIntroduction() {
        
    }
}