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
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        ApplicationDelegate.shared.application(
                   application,
                   didFinishLaunchingWithOptions: launchOptions
               )
        
        // Override point for customization after application launch.
        LocationManager.sharedManager.initializeLocationManager()
        
        
        IQKeyboardManager.shared.enable = true
        setUpFirbaseNotification(application: application)
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {

        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )

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

  
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    let userInfo = notification.request.content.userInfo
    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID: \(messageID)")
    }
    print(userInfo)
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "orderStatusChanged"), object: nil)

    if let type = userInfo["type"] as? String, (type == "fawry" || type == "order") {
        if let orderIdString = userInfo["order_id"] as? String,let orderId = Int(orderIdString) {
            
            let service = OrdersServices.init(delegate: self)
            service.getOrder(id: orderId)
        }
        
    }

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
    print(userInfo)
    
    if let type = userInfo["type"] as? String, (type == "fawry" || type == "order") {
        if let orderIdString = userInfo["order_id"] as? String,let orderId = Int(orderIdString) {
            
            let service = OrdersServices.init(delegate: self)
            service.getOrder(id: orderId)
        }
        
    }

    completionHandler()
  }
}


// MARK: Firemessaging delegate
extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        _ = NSUUID().uuidString
        let service = AuthenticationService.init(delegate: self)
        service.postDeviceToken(fcmToken)
    }
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
      print("Received data message: \(remoteMessage.appData)")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "orderStatusChanged"), object: nil)
    }
}

extension AppDelegate: WebServiceDelegate {
    func didRecieveData(data: Codable) {
        if let topVC = UIApplication.topViewController(),let order = data as? OrderModel {
            
            let sb = UIStoryboard.init(name: "Orders", bundle: nil)
            let orderVC = sb.instantiateViewController(withIdentifier: "OrderViewControllerStoryboard") as! OrderViewController
            orderVC.order = order.order
            topVC.navigationController?.pushViewController(orderVC, animated: true)
        }
    }
    
    func didFailToReceiveDataWithError(error: Error) {
        
    }
    
    
}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
