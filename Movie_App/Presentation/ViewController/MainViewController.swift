import SwiftUI
import RealmSwift

struct MainView: View {
    @ObservedObject var viewModel = MyDataViewModel()
    @State private var isCreateViewPresented = false
    @State private var isPosterViewPresented = false
    @State private var selectedImageData: ImageData?

    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    HeaderView()
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 5) {
                            ForEach(viewModel.images, id: \.id) { imageData in
                                ImageButton(imageData: imageData) {
                                    selectedImageData = imageData
                                    isPosterViewPresented = true
                                }
                                .padding(5)
                                .cornerRadius(15)
                            }
                        }
                        .padding(10)
                    }
                    
                    .sheet(isPresented: $isPosterViewPresented) {
                        if let imageData = selectedImageData {
                            PosterView(imageData: imageData)
                            
                        }
                    }
                    Button(action: {
                        isCreateViewPresented.toggle()
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                            .padding()
                            .background(Color(red: 191/255, green: 255/255, blue: 0/255))
                            .clipShape(Circle())
                    }
                    .sheet(isPresented: $isCreateViewPresented) {
                        CreateView(viewModel: viewModel)
                        
                    }
                    .padding(20)
                }
                .onAppear {
                    viewModel.getRealmData()
                }
                
            }
        }
    }
}

// HeaderView 컴포넌트
struct HeaderView: View {
    var body: some View {
        VStack {
//            RoundedRectangle(cornerRadius: 13)
//                .fill(Color(red: 191/255, green: 255/255, blue: 0/255))
//                .frame(width: 330, height: 50)
//               // .padding(.top , 30)
//            
//            HStack(spacing: 100) {
//                Button(action: {
//                    // action
//                }) {
//                    Image(systemName: "plus")
//                        .foregroundColor(.black)
//                }
//                
//                Button(action: {
//                    // action
//                }) {
//                    Image(systemName: "house")
//                        .foregroundColor(.black)
//                }
//            }
        }
    }
}

// ImageButton 컴포넌트
struct ImageButton: View {
    var imageData: ImageData
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                GeometryReader { geometry in
                    Image(imageData.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.width)
                        .clipShape(RoundedRectangle(cornerRadius: 13))
                        .overlay(
                            RoundedRectangle(cornerRadius: 13)
                                .stroke(Color.black.opacity(0.5), lineWidth: 1)
                        )
                }
                .frame(height: 160)
            }
            .padding(5)
            .cornerRadius(15)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    MainView()
}

