//
//  SceneDelegate.swift
//  Movie_App
//
//  Created by 이예빈 on 2024/05/14.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    // 로그인 여부 확인
    var isLogged: Bool = false // 테스트
    
    func changeRootViewController(_ vc: UIViewController , animated: Bool)
    {
        guard let window = self.window else {return}
        window.rootViewController = vc //전환
        
        // 화면전환 애니메이션 추가
        UIView.transition(with: window, duration: 0.4, options: [.transitionCrossDissolve], animations: nil, completion: nil)
    }
    
    // func scene은 처음 앱에 접근할때 최초로 1번 실행한다
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let _ = (scene as? UIWindowScene) else { return }
        
        let storyboard = UIStoryboard(name:"Main" , bundle: nil) //Main.Storyboard 가져오기
       
        if isLogged == false {
                    // 로그인 안된 상태
                    guard let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginView") as? LoginViewController else { return }
                    window?.rootViewController = loginVC
                } else {
                    // 로그인 된 상태
                    guard let mainVC = storyboard.instantiateViewController(withIdentifier: "MainView") as? ViewController else { return }
                    window?.rootViewController = mainVC
                }
            }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
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

