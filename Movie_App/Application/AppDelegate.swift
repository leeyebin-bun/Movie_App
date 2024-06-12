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
    
        
        // Realm Configuration 설정
        let config = Realm.Configuration(
            schemaVersion: 2, // 현재 사용하는 스키마 버전으로 변경
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 1) {
                    // MyDataModel 클래스의 'id' 속성 추가
                    migration.enumerateObjects(ofType: MyDataModel.className()) { oldObject, newObject in
                        newObject!["id"] = UUID().uuidString // 새로운 기본 키 값 할당
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

