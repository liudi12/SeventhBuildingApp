//
//  AppDelegate.swift
//  SeventhBuildingApp0113
//
//  Created by cmStudent on 2021/07/06.
//

import UIKit
import Realm
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        copyRealm()
        //解决版本问题
        let config = Realm.Configuration(schemaVersion: 2, migrationBlock: { migration, oldSchemaVersion in
            if (oldSchemaVersion < 2) {
                // Nothing to do!
            }
        })
        Realm.Configuration.defaultConfiguration = config
        let configCheck = Realm.Configuration();
        do {
            let fileUrlIs = try schemaVersionAtURL(configCheck.fileURL!)
            print("schema version \(fileUrlIs)")
        } catch  {
            print(error)
        }
        return true
    }

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

extension AppDelegate {
    // Realmファイルをコピーする
    fileprivate func copyRealm() {
        let defaultRealmPath = Realm.Configuration.defaultConfiguration.fileURL!
        
        // 存在する場合は何もしない
        if FileManager.default.fileExists(atPath: defaultRealmPath.path) {
            return
        }
        
        let bundleRealmPath = Bundle.main.url(forResource: "default2", withExtension: "realm")
        do {
            try FileManager.default.copyItem(at: bundleRealmPath!, to: defaultRealmPath)
        } catch let error {
            print("error copying realm file: \(error)")
        }
    }
}
