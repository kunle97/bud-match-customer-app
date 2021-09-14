//
//  AppDelegate.swift
//  Kronik
//
//  Created by Kunle Ademefun on 5/26/21.
//

import UIKit
//import PayPalCheckout
@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UIApplication.shared.statusBarStyle = .lightContent
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
//        STPPaymentConfiguration.shared.publishableKey = STRIPE_PUBLIC_KEY
        let path = "api/driver/orders/latest/"
        let url_mode = [
            "sandbox_url":"http://127.0.0.1:8000/\(path)",
            "live_url": "https://www.budmatchapp.com/\(path)"
        ]
        
        let client_id = [
            "facilitator_sbx": "ARBTLf9WqEoBc6a1hvLX1RioZUg1tqsuK4hbrZIg6arGDKiDPgvBVeoutcBJoyED3HsmEebzsSV1YPom",
            "merchant_sbx": "AT6tmwRVGh8LI7TPomHZUkFBYWv7OHYCwLWKArrlA-Iwa5b73iSaTuPuHxOvaQ--e5l5VHFXjnZKFDSU",
            "merchant_live": "AYZPKv-gygwRQO91_vobWkE8TNCOEXfLYJnuRGTP1UZN33w4WxSot3uEFsvKOAGPt3sJUg8GUu50hILG"
        ]
        
//        let config = CheckoutConfig(
//            clientID: client_id["merchant_sbx"]!,
//            returnUrl: "com.dox.Kronik://paypalpay",
//            environment: .sandbox
//        )
//
//        Checkout.set(config: config)
        
//        return ApplicationDelegate.shared.application(
//            application,  didFinishLaunchingWithOptions: launchOptions
//        )
        return true
    }
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        return ApplicationDelegate.shared.application(
//            app,
//            open: url,
//            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?,
//            annotation: nil
//        )
//    }
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

