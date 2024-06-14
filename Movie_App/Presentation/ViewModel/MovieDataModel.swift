import RealmSwift
import SwiftUI

class MyDataViewModel: ObservableObject {
    private let realm = try! Realm()
    @Published var tasks: Results<MyDataModel>?
    
    init() {
        getRealmData()
    }
    
    func getRealmData() {
        tasks = realm.objects(MyDataModel.self).sorted(byKeyPath: "titleText", ascending: false)
    }
    
    func saveData(titleText: String, timeText: String) {
        let data = MyDataModel(titleText: titleText, timeText: timeText)
        do {
            try realm.write {
                realm.add(data)
            }
            getRealmData()
        } catch {
            print("Error saving data: \(error)")
        }
    }
}
