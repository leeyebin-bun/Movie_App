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
    
    // 사진 업로드 요청
    func uploadImage(image: UIImage, completionHandler: @escaping (Result<String, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            completionHandler(.failure(NSError(domain: "ImageDataError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to convert image to data"])))
            return
        }
        
        let url = "https://example.com/upload"  // 서버의 업로드 API 주소
        let headers: HTTPHeaders = [
            "Content-Type": "multipart/form-data"
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
            // 다른 필요한 데이터가 있다면 여기서 추가할 수 있습니다.
        }, to: url, method: .post, headers: headers)
        .validate()
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                // 성공적으로 업로드된 경우 서버에서 반환한 데이터를 처리합니다.
                if let data = value as? [String: Any], let imageUrl = data["imageUrl"] as? String {
                    completionHandler(.success(imageUrl))
                } else {
                    completionHandler(.failure(NSError(domain: "UploadResponseError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid response format"])))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    enum UploadError: Error {
           case invalidImageData
           case invalidResponse
       }
}
