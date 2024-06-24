//import SwiftUI
//import UIKit
//
//func signUp(userId: String, pwd: String, name: String, age: String, imgData: Data) {
//    // 헤더 작성 (Content-type 지정)
//    let header: HTTPHeaders = [ "Content-Type" : "multipart/form-data" ]
//        
//    // 파라미터
//    let params: Parameters = [
//        "user_id": userId,
//        "pwd": pwd,
//        "name": name,
//        "age": age
//    ]
//        
//    AF.upload(multipartFormData: { MultipartFormData in
//        for (key, value) in params {
//        MultipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
//    }
//        // 이미지 추가 (이미지 없을 경우 고려)
//        if let image = imgData?.pngData() {
//            MultipartFormData.append(image, withName: "image", fileName: "\(name).jpg", mimeType: "image/jpg")
//        }
//    }, to: signUpURL, usingThreshold: UInt64.init(), method: .post, headers: header).responseData { response in
//        switch response.result {
//        case .success:
//               guard let statusCode = response.response?.statusCode else { return }
//            guard let data = response.value else { return }
//            completion(judgeSignUpData(status: statusCode, data: data))
//        case .failure(let err):
//            print(err)
//            completion(.networkFail)
//        }
//    }
//}
//
//private func judgeSignUpData(status: Int, data: Data) -> NetworkResult<Any> {
//    // 통신을 통해 전달받은 데이터를 decode
//    switch status {
//    case 200:
//        let decoder = JSONDecoder()
//        guard let decodedData = try? decoder.decode(TokenModel.self, from: data) else { return .pathErr }
//        print("회원가입 :: Success")
//        return .success(decodedData)
//    case 400..<500:
//        return .requestErr
//    case 500:
//        return .serverErr
//    default:
//        return .networkFail
//        
//    }
//}
