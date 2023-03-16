//
//  AppDelegate.swift
//  WeatherDemo
//
//  Created by iMac on 16/03/23.
//

import UIKit
import Firebase
import FirebaseAppCheck
import FirebaseFirestore
import IQKeyboardManager

var appSettings: AppSettingsModel?

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        IQKeyboardManager.shared().isEnabled = true
        
        let providerFactory = YourAppCheckProviderFactory()
        AppCheck.setAppCheckProviderFactory(providerFactory)
        FirebaseApp.configure()
        self.getAppSettingsDataFromFirestoreDatabase()
        self.checkLogin()
        
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

    // Chaeck Login
    func checkLogin() {
        if (Auth.auth().currentUser != nil) {
            let newVC = self.storyBoard.instantiateViewController(withIdentifier: "HomeNav") as! UINavigationController
            obj_AppDelegate.window?.rootViewController = newVC
        } else {
            let newVC = self.storyBoard.instantiateViewController(withIdentifier: "LoginNav") as! UINavigationController
            obj_AppDelegate.window?.rootViewController = newVC
        }
    }
    
    // Get App Settings From Firestore Database
    func getAppSettingsDataFromFirestoreDatabase() {
        let db = Firestore.firestore()
        db.collection("AppSettings").document("AppSettings").getDocument(completion: { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let document = snapshot, document.exists {
                    if let data = document.data() {
                        let appSetting = AppSettingsModel(dictionary: (data as NSDictionary))
                        appSettings = appSetting
                    }
                } else {
                    print("Document does not exist")
                }
            }
        })
    }

}

