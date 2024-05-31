//
//  ViewController.swift
//  Movie_App
//
//  Created by 이예빈 on 2024/05/14.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //크기 굵기 넓이
        self.startButton.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: .bold, width: .standard)
        //저장할 데이터 생성
        let user = Model()
        user.name = "yebong"
        user.age = 28
        
        //Realm 불러오기
        let realm = try! Realm()
        //Realm 파일 위치
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        //데이터 저장하기
        try! realm.write{
            realm.add(user)
        }
        
        //print("users", realm.objects(Model.self))
        
        //데이터 가져오기
        let myUser = realm.objects(Model.self).filter("name == 'yebong'").first
        //print("myUsers",myUser!)
        //self.view.backgroundColor = .systemBackground // IOS 다크모드 / 라이트모드 적용
       
    }

}

