import SwiftUI
import RealmSwift

struct MainView: View {
    @ObservedObject private var viewModel = MyDataViewModel()
    @State private var isCreateViewPresented = false
    @State private var isPosterViewPresented = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    HeaderView()
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                            ForEach(viewModel.images) { imageData in
                                ImageButton(imageName: "Th\(imageData.rating + 1)", action: {
                                    isPosterViewPresented = true
                                })
                            }
                        }
                        .padding(20) // 그리드 가로 여백
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
            RoundedRectangle(cornerRadius: 13)
                .fill(Color(red: 191/255, green: 255/255, blue: 0/255))
                .frame(width: 330, height: 50)
                .padding(.top , 30)
            
            HStack(spacing: 100) {
                Button(action: {
                    // action
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(.black)
                }
                
                Button(action: {
                    // action
                }) {
                    Image(systemName: "house")
                        .foregroundColor(.black)
                }
            }
        }
    }
}

// ImageButton 컴포넌트
struct ImageButton: View {
    var imageName: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                GeometryReader { geometry in
                    Image(imageName)
                        .resizable()
                        .aspectRatio(1.0, contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.width)
                        .clipShape(RoundedRectangle(cornerRadius: 13))
                        .overlay(
                            RoundedRectangle(cornerRadius: 13)
                                .stroke(Color.black.opacity(0.5), lineWidth: 1)
                        )
                }
                .frame(height: 160) // 원하는 크기로 고정
            }
            .padding(5) // 그리드 세로 여백
            .cornerRadius(15)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    MainView()
}

