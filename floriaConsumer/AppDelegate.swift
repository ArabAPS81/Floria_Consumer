//
//  AppDelegate.swift
//  floriaConsumer
//
//  Created by mac on 14/02/1441 AH.
//  Copyright © 1441 Obida. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        LocationManager.sharedManager.initializeLocationManager()
        if Defaults.init().isUserLogged{
            let storyboard = UIStoryboard(name: "MainScreen", bundle: nil)
            let homeVC = storyboard.instantiateViewController(withIdentifier: "homeNav") as! HomeNav
            window?.rootViewController = homeVC
        }else {
            if Defaults().getIfFirstTime() || true {
                let storyboard = UIStoryboard(name: "Splash", bundle: nil)
                let homeVC = storyboard.instantiateInitialViewController()
                window?.rootViewController = homeVC
            } else {
                let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
                let homeVC = storyboard.instantiateInitialViewController()
                window?.rootViewController = homeVC
            }
        }
        IQKeyboardManager.shared.enable = true
        setUpFirbaseNotification(application: application)
        
        return true
    }
    
    func setUpFirbaseNotification(application: UIApplication) {
        
        FirebaseApp.configure()

           // [START set_messaging_delegate]
        Messaging.messaging().delegate = self
        
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
          UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        } else {
          let settings: UIUserNotificationSettings =
          UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()
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
        
    }


}

// MARK: UserNotification delegate

extension AppDelegate: UNUserNotificationCenterDelegate {

  // Receive displayed notifications for iOS 10 devices.
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    let userInfo = notification.request.content.userInfo

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)
    // Print message ID.
    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID: \(messageID)")
    }

    // Print full message.
    print(userInfo)

    // Change this to your preferred presentation option
    completionHandler([])
  }

  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
    let userInfo = response.notification.request.content.userInfo
    // Print message ID.
    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID: \(messageID)")
    }

    // Print full message.
    print(userInfo)

    completionHandler()
  }
}


// MARK: Firemessaging delegate
extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        let deviceId = NSUUID().uuidString
        let service = AuthenticationService.init(delegate: self)
        service.postDeviceToken(fcmToken, deviceId: deviceId)
        
    }
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
      print("Received data message: \(remoteMessage.appData)")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "orderStatusChanged"), object: nil)
    }
}

extension AppDelegate: WebServiceDelegate {
    func didRecieveData(data: Codable) {
        
    }
    
    func didFailToReceiveDataWithError(error: Error) {
        
    }
    
    
}

