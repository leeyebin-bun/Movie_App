
import UIKit
import RealmSwift
import SwiftUI
import SplineRuntime


class MainViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //버튼 폰트 크기,굵기,넓이
        self.startButton.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .bold, width: .standard)
        
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
        
        //IOS 다크모드 / 라이트모드 적용
        //self.view.backgroundColor = .systemBackground
       
    }

}

