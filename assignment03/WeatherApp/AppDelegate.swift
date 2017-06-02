//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Derrick Park on 2017-05-26.
//  Copyright © 2017 Derrick Park. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var cities = [City]()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
//        cities.append(City(name: "Vancouver"))
//        cities.append(City(name: "Victoria"))
//        cities.append(City(name: "Seattle"))
//        cities.append(City(name: "San Francisco"))
//        cities.append(City(name: "Los Angeles"))
        
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let tab = UITabBarController()
        window?.rootViewController = tab
        
        tab.viewControllers = [
            CityViewController(city: City(name: "Vancouver")),
            CityViewController(city: City(name: "Victoria")),
        ]
        
        window?.makeKeyAndVisible()
        return true
    }


}

