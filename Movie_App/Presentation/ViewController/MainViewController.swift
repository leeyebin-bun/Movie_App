import SwiftUI
import RealmSwift

struct MainView: View {
    @StateObject private var viewModel = MyDataViewModel()
    @State private var isCreateViewPresented = false
    
    var body: some View {
        NavigationView {
            ZStack{
                Color.black
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack {
                    RoundedRectangle(cornerRadius: 13)
                        .fill(Color(red: 191/255, green: 255/255, blue: 0/255))
                        .frame(width: 330 , height: 50)
                    
                    if let tasks = viewModel.tasks {
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack {
                                ForEach(tasks, id: \.id) { task in
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
                                                    Text(formatDate(task.dateText))
                                                        .font(.subheadline)
                                                        .foregroundColor(.white)
                                                    
                                                }
                                                    .padding()
                                            )
                                    }
                                    .padding(.horizontal, 5)
                                }
                            }
                        }
                    } else {
                        Text("Loading...")
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
                }
                .navigationTitle("Tasks")
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

