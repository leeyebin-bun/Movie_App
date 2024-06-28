import SwiftUI
import RealmSwift
import Firebase
import FirebaseStorage
import FirebaseFirestore

struct PosterView: View {
    @ObservedObject var viewModel = MyDataViewModel()
    @State private var isCreateViewPresented = false
    @State private var isPosterViewPresented = false
    var imageData: ImageData
    
    @State private var posterImages: [String] = [] // Firebase에서 다운로드한 이미지 URL을 저장할 배열
    
    var body: some View {
        NavigationView {
            ZStack{
                Color.black
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    RoundedRectangle(cornerRadius: 13)
                        .fill(Color(red: 191/255, green: 255/255, blue: 0/255))
                        .frame(width: 330 , height: 50)
                    
                    if let tasks = viewModel.tasks {
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack {
                                ForEach(tasks, id: \.id) { task in
                                    Button(action: {
                                        isPosterViewPresented = true
                                    }) {
                                        VStack {
                                            if let imageUrl = task.imageUrl {
                                                RemoteImage(url: imageUrl)
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 330, height: 200)
                                                    .cornerRadius(13)
                                                    .overlay(
                                                        VStack {
                                                            Text(task.titleText)
                                                                .font(.headline)
                                                                .foregroundColor(.white)
                                                            Text(task.timeText)
                                                                .font(.subheadline)
                                                                .foregroundColor(.white)
                                                            Text(PosterformatDate(task.dateText))
                                                                .font(.subheadline)
                                                                .foregroundColor(.white)
                                                            Text(task.famousLineText)
                                                                .font(.headline)
                                                                .foregroundColor(.white)
                                                        }
                                                            .padding()
                                                    )
                                            } else {
                                                Text("No Image")
                                                    .foregroundColor(.white)
                                                    .frame(width: 330, height: 200)
                                                    .cornerRadius(13)
                                                    .overlay(
                                                        VStack {
                                                            Text(task.titleText)
                                                                .font(.headline)
                                                                .foregroundColor(.white)
                                                            Text(task.timeText)
                                                                .font(.subheadline)
                                                                .foregroundColor(.white)
                                                            Text(PosterformatDate(task.dateText))
                                                                .font(.subheadline)
                                                                .foregroundColor(.white)
                                                            Text(task.famousLineText)
                                                                .font(.headline)
                                                                .foregroundColor(.white)
                                                        }
                                                            .padding()
                                                    )
                                            }
                                        }
                                        .padding(.horizontal, 5)
                                    }
                                }
                            }
                        }
                    } else {
                        Text("Loading...")
                    }
                }
                .onAppear {
                    viewModel.getRealmData()
                    loadPosterImages() // Firebase에서 이미지 URL들을 불러옴
                }
            }
        }
    }
    
    // Firebase에서 이미지 URL을 가져와 posterImages 배열에 저장
    private func loadPosterImages() {
        let db = Firestore.firestore()
        db.collection("movies").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching documents: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No documents")
                return
            }
            
            for document in documents {
                if let imageUrl = document.data()["imageUrl"] as? String {
                    self.posterImages.append(imageUrl)
                }
            }
        }
    }
}

// 이미지 다운로드 및 표시를 위한 View
struct RemoteImage: View {
    let url: String
    @StateObject private var imageLoader = ImageLoader()
    
    var body: some View {
        if let uiImage = imageLoader.image {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .onAppear {
                    imageLoader.loadImage(url: url)
                }
        }
    }
}

// 이미지 다운로더 클래스
class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    func loadImage(url: String) {
        guard let imageUrl = URL(string: url) else {
            return
        }
        
        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                return
            }
            
            guard let data = data, let loadedImage = UIImage(data: data) else {
                print("Invalid image data")
                return
            }
            
            DispatchQueue.main.async {
                self.image = loadedImage
            }
        }.resume()
    }
}

// 날짜 yyyy-mm-dd로 출력하는 함수
func PosterformatDate(_ date: Date?) -> String {
    guard let date = date else {
        return ""
    }
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    return dateFormatter.string(from: date)
}
