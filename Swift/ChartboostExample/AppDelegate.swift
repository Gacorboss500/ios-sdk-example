//
//  AppDelegate.swift
//  ChartboostExample
//
//  Created by Arnau Marti on 08/07/2020.
//  Copyright © 2020 Chartboost. All rights reserved.
//

import UIKit
import AppTrackingTransparency

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("Chartboost SDK Version ", Chartboost.getSDKVersion() ?? "")
        
        Chartboost.addDataUseConsent(.CCPA(.optInSale))
        Chartboost.addDataUseConsent(.GDPR(.behavioral))

        Chartboost.setLoggingLevel(.info)

        Chartboost.start(withAppId: "4f21c409cd1cb2fb7000001b",
                         appSignature: "92e2de2fd7070327bdeb54c15a5295309c6fcd2d") { (success) in
                            let vc = self.window?.rootViewController as? ViewController
                            vc?.log(message: success ? "Chartboost initialized successfully!" : "Chartboost failed to initialize.")
        }
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        if #available(iOS 14, *) {
            if ATTrackingManager.trackingAuthorizationStatus == .notDetermined {
                ATTrackingManager.requestTrackingAuthorization { status in
                    print("Tracking authorization status changed: \(status.rawValue)")
                }
            } else {
                print("Tracking authorization status: \(ATTrackingManager.trackingAuthorizationStatus.rawValue)")
            }
        }
    }
}

