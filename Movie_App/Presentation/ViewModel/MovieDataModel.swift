import RealmSwift

class MyDataViewModel: ObservableObject {
    private var realm: Realm

    @Published var tasks: Results<MyDataModel>?
    
    init() {
        // Realm 인스턴스 초기화
        do {
            self.realm = try Realm()
        } catch {
            fatalError("Failed to open Realm: \(error.localizedDescription)")
        }
        
        // Realm에서 데이터 불러오기
        self.tasks = realm.objects(MyDataModel.self).sorted(byKeyPath: "titleText", ascending: false)
    }
    
    // 데이터 저장
    func saveData(titleText: String, timeText: String, dateText: Date, rating: Int, famousLineText: String) {
        let data = MyDataModel(titleText: titleText, timeText: timeText, dateText: dateText, rating: rating, famousLineText: famousLineText)
        
        do {
            try realm.write {
                realm.add(data)
            }
        } catch {
            print("Error saving data: \(error)")
        }
        
        // 데이터가 변경되었음을 알림
        getRealmData()
    }
    
    // 데이터 업데이트
    func getRealmData() {
        tasks = realm.objects(MyDataModel.self).sorted(byKeyPath: "titleText", ascending: false)
    }
}
