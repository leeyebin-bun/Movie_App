import RealmSwift
import Alamofire

class MyDataViewModel: ObservableObject {
    private var realm: Realm

    @Published var tasks: Results<MyDataModel>?
    @Published var images: [ImageData] = []
    
    init() {
        // Realm 인스턴스 초기화
        do {
            self.realm = try Realm()
            self.images = [
                        ImageData(imageName: "Th1", rating: 0),
                        ImageData(imageName: "Th2", rating: 1),
                        ImageData(imageName: "Th3", rating: 2),
                        ImageData(imageName: "Th4", rating: 3),
                        ImageData(imageName: "Th5", rating: 4),
                        ImageData(imageName: "Th6", rating: 5)
                    ]
        
        } catch {
            fatalError("Failed to open Realm: \(error.localizedDescription)")
        }
        
        // Realm에서 데이터 불러오기
        self.tasks = realm.objects(MyDataModel.self).sorted(byKeyPath: "titleText", ascending: false)
    }
    
    // 데이터 저장
    func saveData(titleText: String, timeText: String, dateText: Date, rating: Int, famousLineText: String, imageUrl: String?) {
        let data = MyDataModel(titleText: titleText, timeText: timeText, dateText: dateText, rating: rating, famousLineText: famousLineText , imageUrl: imageUrl ?? "")
        
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
    
    //날짜 데이터 가져오기
    func getTasks(for date: Date) -> [MyDataModel] {
            let calendar = Calendar.current
            let startOfDay = calendar.startOfDay(for: date)
            let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
            
            let predicate = NSPredicate(format: "dateText >= %@ AND dateText < %@", startOfDay as NSDate, endOfDay as NSDate)
            return Array(realm.objects(MyDataModel.self).filter(predicate))
        }
    
    // 데이터 업데이트
    func getRealmData() {
        tasks = realm.objects(MyDataModel.self).sorted(byKeyPath: "titleText", ascending: false)
    }

}
