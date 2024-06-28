import SwiftUI
import FirebaseStorage

class ImageUploadViewModel: ObservableObject {
    @Published var imageUrl: String?
    @Published var uploadProgress: Double = 0.0

    func uploadImage(image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get image data"])
            completion(.failure(error))
            return
        }

        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imageUUID = UUID().uuidString
        let imageRef = storageRef.child("images/\(imageUUID).jpg")
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"

        let uploadTask = imageRef.putData(imageData, metadata: metadata) { metadata, error in
            if let error = error {
                print("Error uploading image: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }

            imageRef.downloadURL { url, error in
                if let error = error {
                    print("Error getting download URL: \(error.localizedDescription)")
                    completion(.failure(error))
                    return
                }

                guard let downloadURL = url else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get download URL"])
                    print("Download URL is nil: \(error.localizedDescription)")
                    completion(.failure(error))
                    return
                }

                print("Image uploaded successfully. Download URL: \(downloadURL.absoluteString)")
                self.imageUrl = downloadURL.absoluteString
                completion(.success(downloadURL.absoluteString))
            }
        }

        uploadTask.observe(.progress) { snapshot in
            guard let progress = snapshot.progress else { return }
            self.uploadProgress = Double(progress.completedUnitCount) / Double(progress.totalUnitCount) * 100.0
        }

        uploadTask.observe(.failure) { snapshot in
            if let error = snapshot.error {
                print("Upload failed: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
}
