//
//  LoginViewController.swift
//  Movie_App
//
//  Created by 이예빈 on 2024/05/14.
//

import UIKit

class PosterViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /*
    // 로그인 -> 메인화면 전환
    @IBAction func goLogin(_ sender: Any)
    {
        guard let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "MainView") as? ViewController else { return }
        // as?
        // Casting : 데이터 타입을 변환
        // 캐스팅에 성공하면 ViewController 실행
        // 캐스팅에 실패하면 return
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainVC, animated: false)
        // SceneDelegate 로 캐스팅 되어 changeRootViewController 를 가져올 수 있다.
        // SceneDelegate의 changeRootViewController 메서드 호출
        // 파라미터로 넘길 값 : mainVC
    }
     */
}
