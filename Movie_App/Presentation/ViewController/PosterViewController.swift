//
//  LoginViewController.swift
//  Movie_App
//
//  Created by 이예빈 on 2024/05/14.
//

import UIKit
import RealmSwift

class PosterViewController: UIViewController {
    
    @IBOutlet weak var targetButton: UIButton!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var memoButton: UIButton!
    @IBOutlet weak var calButton: UIButton!
    @IBOutlet weak var posterCellView: UIView!
    @IBOutlet weak var posterCellView_2: UIView!
    @IBOutlet weak var posterCellView_3: UIView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var captionText: UILabel!
    @IBOutlet weak var posterButton: UIButton!
    
    var data : String = ""
    // var dataDelegate : SendDataDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.targetButton.layer.masksToBounds = true
        self.targetButton.layer.cornerRadius = 15
        self.targetButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        
        self.memoButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.calButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        
        self.navigationBar.layer.masksToBounds = true
        self.navigationBar.layer.cornerRadius = 15
        
        self.posterCellView.layer.masksToBounds = true
        self.posterCellView.layer.cornerRadius = 15
        self.posterCellView_2.layer.masksToBounds = true
        self.posterCellView_2.layer.cornerRadius = 15
        self.posterCellView_3.layer.masksToBounds = true
        self.posterCellView_3.layer.cornerRadius = 15
         
        self.titleText.text = data
        //dataDelegate?.recieveData(response: "delegate works well~")
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
     메인에서 플러스버튼 누를시 이동
     */
    @IBAction func OnClickAddButton(_ sender: Any) {
        //let storyboard = UIStoryboard(name:"CreateView" , bundle: nil)
        guard let createVC = self.storyboard?.instantiateViewController(identifier: "CreateView") else { return }
        // 화면전환 애니메이션 설정
        createVC.modalTransitionStyle = .coverVertical
        // 전환된 화면이 보여지는 방법 설정
        createVC.modalPresentationStyle = .fullScreen
        
        self.present(createVC, animated: true, completion: nil)
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
