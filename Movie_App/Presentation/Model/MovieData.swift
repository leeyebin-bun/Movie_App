import UIKit
import RealmSwift
import SwiftUI
import SplineRuntime


// 사용자에게 보여질 데이터의 Model 정의
class MyDataModel: Object, Identifiable {
   // @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var titleText: String = ""
    @Persisted var timeText: String = ""
    @Persisted var dateText: Date?
    
    convenience init(titleText: String, timeText: String, dateText: Date) {
        self.init()
        self.titleText = titleText
        self.timeText = timeText
        self.dateText = dateText
    }
}
