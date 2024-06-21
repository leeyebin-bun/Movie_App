import SwiftUI
import RealmSwift

struct MainView: View {
    @StateObject private var viewModel = MyDataViewModel()
    @State private var isCreateViewPresented = false
    @State private var isPosterViewPresented = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                            ForEach(0..<6) { index in
                                Button(action: {
                                    isCreateViewPresented = true
                                }) {
                                    VStack {
                                        RoundedRectangle(cornerRadius: 13)
                                            .frame(width: 150, height: 150) // Adjust size as needed
                                            .overlay(
                                                Image("Th\(index + 1)")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                            )
                                    }
                                    .padding(10)
                                    .cornerRadius(15)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(10)
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
                        CreateBGView(viewModel: viewModel)
                    }
                }
                .onAppear {
                    viewModel.getRealmData()
                }
            }
        }
    }
}

// 날짜 yyyy-mm-dd로 출력하는 함수
func formatDate(_ date: Date?) -> String {
    guard let date = date else {
        return ""
    }
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    return dateFormatter.string(from: date)
}

#Preview {
    MainView()
}

