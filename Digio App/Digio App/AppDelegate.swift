//
//  AppDelegate.swift
//  Digio App
//
//  Created by Felipe Santolim on 01/03/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var mainFlow: MainFlow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.mainFlow = MainFlow(navigation: UINavigationController())
        self.mainFlow?.start()
        
        return true
    }
}

