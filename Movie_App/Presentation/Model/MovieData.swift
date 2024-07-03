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
    @Persisted var rating: Int = 0
    @Persisted var famousLineText: String = ""
    @Persisted var imageUrl: String? = nil
    
    convenience init(titleText: String, timeText: String, dateText: Date, rating: Int, famousLineText: String , imageUrl: String) {
        self.init()
        self.titleText = titleText
        self.timeText = timeText
        self.dateText = dateText
        self.rating = rating
        self.famousLineText = famousLineText
        self.imageUrl = imageUrl
    }
}

class ImageData: Identifiable {
    var id = UUID()
    var rating: Int
    var imageName: String

    init(imageName: String, rating: Int) {
        self.rating = rating
        self.imageName = imageName
    }
}

