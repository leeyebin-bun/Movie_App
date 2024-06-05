
import UIKit
import RealmSwift
import SwiftUI
import SplineRuntime


struct MainView: View {
    var body: some View {
        ZStack{
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                MenuBar()
                .padding()
                Spacer()
            }
        }
    }
}

struct MenuBar: View {
    var body: some View {
        ZStack {
            // 배경색 설정
            Color(red: 191/255, green: 255/255, blue: 0/255)
                .frame(width: 330 , height: 45)
                .cornerRadius(13)
                
            HStack {
                Button(action: {
                    // 버튼 액션
                    
                }) {
                    Text("Note")
                        //.frame(width: 200)
                        .foregroundColor(.black)
                        .font(.system(size: 13))
                        .bold()
                        //.padding()
                        .padding(.leading, 40)
                    Spacer()
                }
                
               //Spacer()
                
                Button(action: {
                    // 버튼 액션
                    
                }) {
                    Text("...")
                        .foregroundColor(.black)
                        .font(.system(size: 15))
                        .bold()
                        .padding(.trailing, 40)
                }
            }
            .padding(.vertical, 20)
        }
    }
}

/*
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
*/

#Preview {
    MainView()
}

