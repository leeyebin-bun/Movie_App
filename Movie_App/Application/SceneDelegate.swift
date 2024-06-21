//
//  SceneDelegate.swift
//  Movie_App
//
//  Created by 이예빈 on 2024/05/14.
//

import UIKit
import SwiftUI
import RealmSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    /*
     func changeRootViewController(_ vc: UIViewController , animated: Bool)
     {
     guard let window = self.window else {return}
     window.rootViewController = vc //전환
     
     // 화면전환 애니메이션 추가
     UIView.transition(with: window, duration: 0.4, options: [.transitionCrossDissolve], animations: nil, completion: nil)
     }
     */
    
    // func scene은 처음 앱에 접근할때 최초로 1번 실행한다
    // 장면 연결 설정 코드
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        /*
         guard let _ = (scene as? UIWindowScene) else { return }
         let storyboard = UIStoryboard(name:"Main" , bundle: nil) //Main.Storyboard 가져오기
         
         //PosterView
         guard let posterVC = storyboard.instantiateViewController(withIdentifier: "PosterView") as? PosterViewController else { return }
         
         //MainView
         guard let mainVC = storyboard.instantiateViewController(withIdentifier: "MainView") as?
         MainViewController else { return }
         
         //CreateView
         guard let createVC = storyboard.instantiateViewController(withIdentifier: "CreateView") as?
         CreateViewController else { return }
         
         window?.rootViewController = mainVC
         
        */
        
        // Realm 초기화 및 기본 설정
        // Realm Configuration 설정
        let realmConfig = Realm.Configuration(
            schemaVersion: 2, // 최신 스키마 버전
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 2 {
                    // 이전 데이터베이스 스키마에서 새로운 데이터베이스 스키마로 마이그레이션 수행
                    // migration.enumerateObjects(ofType:...) 등의 메서드를 사용하여 필요한 마이그레이션 작업을 수행
                }
            })

        // Realm Configuration을 기본으로 설정
        Realm.Configuration.defaultConfiguration = realmConfig
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let contentView = ContentView()
            
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
        
        func sceneDidDisconnect(_ scene: UIScene) {
            // Called as the scene is being released by the system.
            // This occurs shortly after the scene enters the background, or when its session is discarded.
            // Release any resources associated with this scene that can be re-created the next time the scene connects.
            // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
        }
        
        func sceneDidBecomeActive(_ scene: UIScene) {
            // 장면 활성화될 때 호출
        }
        
        func sceneWillResignActive(_ scene: UIScene) {
            // 장면 비활성화될 때 호출
        }
        
        func sceneWillEnterForeground(_ scene: UIScene) {
            // Called as the scene transitions from the background to the foreground.
            // Use this method to undo the changes made on entering the background.
        }
        
        func sceneDidEnterBackground(_ scene: UIScene) {
            // Called as the scene transitions from the foreground to the background.
            // Use this method to save data, release shared resources, and store enough scene-specific state information
            // to restore the scene back to its current state.
        }
        
        
    }
    
}
