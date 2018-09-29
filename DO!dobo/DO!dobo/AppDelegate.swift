//
//  AppDelegate.swift
//  DO!dobo
//
//  Created by 김예은 on 2018. 9. 16..
//  Copyright © 2018년 kyeahen. All rights reserved.
//

import UIKit
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        // Set the Google Place API's autocomplete UI control
        GMSPlacesClient.provideAPIKey(googlePlacesKey)
        // Customize the UI of GMSAutocompleteViewController
        // Set some colors (colorLiteral is convenient)
        let barColor: UIColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let backgroundColor: UIColor =  #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        let textColor: UIColor = #colorLiteral(red: 0.2509803922, green: 0.2509803922, blue: 0.2509803922, alpha: 1)
        // Navigation bar background.
        UINavigationBar.appearance().barTintColor = barColor
        UINavigationBar.appearance().tintColor = #colorLiteral(red: 0.4705882353, green: 0.7843137255, blue: 0.7764705882, alpha: 1)
        // Color and font of typed text in the search bar.
        let searchBarTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: textColor, NSAttributedStringKey.font.rawValue: UIFont(name: "Apple SD Gothic Neo", size: 16)]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = searchBarTextAttributes
        // Color of the placeholder text in the search bar prior to text entry.
        let placeholderAttributes = [NSAttributedStringKey.foregroundColor: backgroundColor, NSAttributedStringKey.font: UIFont(name: "Apple SD Gothic Neo", size: 15)]
        // Color of the default search text.
        var attributedPlaceholder = NSAttributedString(string: "코스 검색", attributes: placeholderAttributes)
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = attributedPlaceholder
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?)
        -> UIInterfaceOrientationMask {
            return [.portrait]
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

