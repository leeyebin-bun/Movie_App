import SwiftUI
import Alamofire

class ImageUploadViewModel: ObservableObject {
    
    func uploadImage(image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            completion(.failure(UploadError.invalidImageData))
            return
        }
        
        // Alamofire를 사용하여 이미지 업로드
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
            // 필요에 따라 다른 필드 추가 가능
        }, to: "https://api.example.com/upload")
        .response { response in
            switch response.result {
            case .success(let data):
                // 이미지 업로드 성공
                // 서버에서 반환된 imageUrl 처리
                if let data = data, let imageUrl = String(data: data, encoding: .utf8) {
                    completion(.success(imageUrl))
                } else {
                    completion(.failure(UploadError.invalidResponse))
                }
            case .failure(let error):
                // 이미지 업로드 실패
                completion(.failure(error))
            }
        }
    }
    
    enum UploadError: Error {
        case invalidImageData
        case invalidResponse
    }
}

