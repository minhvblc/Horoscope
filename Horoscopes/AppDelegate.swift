//
//  AppDelegate.swift
//  ddddddd
//
//  Created by Nguyen Duc Minh on 1/25/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func scheduleNotification(at date: Date) {

            var dateComponents = DateComponents()
            dateComponents.hour = 9
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

            
            let content = UNMutableNotificationContent()
            content.title = "Daily Horoscope"
            content.body = "Let's check your today horoscope"
            content.sound = UNNotificationSound.default
            
            let request = UNNotificationRequest(identifier: "textNotification", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            UNUserNotificationCenter.current().add(request) {(error) in
                if let error = error {
                    print("Uh oh! We had an error: \(error)")
                }
                print(request.content.title)
            }
        }



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

 
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}

