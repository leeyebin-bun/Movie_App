import SwiftUI
import FirebaseAuth
import Firebase

struct CreateView: View {
    @ObservedObject var viewModel: MyDataViewModel
    @StateObject private var imageUploadViewModel = ImageUploadViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var isPresented = false
    @State private var title = ""
    @State private var time = ""
    @State private var date = Date()
    @State private var famousLine = ""
    @State private var rating: Int = 0
    @State private var image: UIImage?
    @State private var imageUrl: String?
    @State private var isShowingImagePicker = false
    @State private var isUploading = false
    @State private var isUserAuthenticated = Auth.auth().currentUser != nil

    var body: some View {
        if !isUserAuthenticated {
            //LoginView()
        } else {
            NavigationView {
                VStack {
                    HStack(spacing: 10) {
                        ForEach(1..<6) { index in
                            Image(systemName: index <= rating ? "star.fill" : "star")
                                .resizable()
                                .frame(width: 32, height: 32)
                                .foregroundColor(index <= rating ? Color.yellow : Color.gray)
                                .onTapGesture {
                                    rating = index
                                }
                        }
                    }
                    .padding()

                    Text("평점을 매겨주세요")
                        .foregroundColor(.black)
                        .padding(.bottom, 20)

                    TextField("영화제목", text: $title)
                    TextField("러닝타임", text: $time)
                    DatePicker("날짜", selection: $date, displayedComponents: .date)
                    TextField("기억에 남는 명대사를 적어보세요!", text: $famousLine)

                    Button(action: {
                        self.isShowingImagePicker = true
                    }) {
                        Text("사진 선택")
                    }
                    .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
                        ImagePicker(image: $image, isShown: $isShowingImagePicker)
                    }

                    Button(action: {
                        if let image = image {
                            self.isUploading = true
                            imageUploadViewModel.uploadImage(image: image) { result in
                                switch result {
                                case .success(let url):
                                    self.imageUrl = url
                                    self.saveToFirestore()
                                case .failure(let error):
                                    print("Image upload failed: \(error.localizedDescription)")
                                    self.isUploading = false
                                }
                            }
                        } else {
                            self.saveToFirestore() // 이미지 없이 저장
                        }
                    }) {
                        if isUploading {
                            ProgressView("업로드 중...")
                        } else {
                            Text("저장")
                        }
                    }

                    Spacer()
                }
                .padding()
                .navigationBarTitle("영화 추가", displayMode: .inline)
                .navigationBarItems(trailing: Button("취소") {
                    presentationMode.wrappedValue.dismiss()
                })
            }
        }
    }

    private func loadImage() {
        guard let inputImage = image else { return }
        // 이미지 선택 후 처리할 로직 추가 가능
    }

    private func saveToFirestore() {
        // Firestore에 데이터 저장하는 로직 추가
        self.isUploading = false
        presentationMode.wrappedValue.dismiss()
    }
}


struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var isShown: Bool

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let editedImage = info[.editedImage] as? UIImage {
                parent.image = editedImage
            } else if let originalImage = info[.originalImage] as? UIImage {
                parent.image = originalImage
            }
            parent.isShown = false
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isShown = false
        }
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView(viewModel: MyDataViewModel())
    }
}
