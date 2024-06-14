//
//  AppDelegate.swift
//  Movie_App
//
//  Created by 이예빈 on 2024/05/14.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // 프로그램이 실행될 준비가 모두 완료되면 true를 반환
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        let config = Realm.Configuration(
            schemaVersion: 2, // 현재 스키마 버전
            migrationBlock: { migration, oldSchemaVersion in
                // 마이그레이션 필요 시 처리
                if oldSchemaVersion < 2 {
                    // 예시: 필요한 마이그레이션 작업 수행
                    migration.enumerateObjects(ofType: MyDataModel.className()) { oldObject, newObject in
                        newObject!["id"] = UUID().uuidString // 예시 마이그레이션 코드
                    }
                }
            })

        Realm.Configuration.defaultConfiguration = config
        
        print("realm 위치: ", Realm.Configuration.defaultConfiguration.fileURL!)
        // LaunchScreen 딜레이 시간 설정
        //sleep(1)
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

