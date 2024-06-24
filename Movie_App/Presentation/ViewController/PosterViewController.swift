import SwiftUI
import RealmSwift

struct PosterView: View {
    @ObservedObject var viewModel = MyDataViewModel()
    @State private var isCreateViewPresented = false
    @State private var isPosterViewPresented = false
    var imageData: ImageData
    
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
                                            RoundedRectangle(cornerRadius: 13)
                                                .fill(Color.gray.opacity(0.3))
                                                .frame(width: 330, height: 200)
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
                }
            }
        }
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

