
import UIKit
import RealmSwift
import SwiftUI
import SplineRuntime

class ViewModel: ObservableObject {
    private let realm = try! Realm()
    @Published var tasks: Results<MyDataModel>?
    
    init() {
        getRealmData()
    }
    
    public func getRealmData() {
        tasks = realm.objects(MyDataModel.self).sorted(byKeyPath: "titleText", ascending: false)
    }
}


struct MainView: View {
    @State private var isCreateViewPresented = false
   
    var body: some View {
        ZStack{
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                MenuBar(isCreateViewPresented: $isCreateViewPresented)
                .padding()
                Spacer()
            }
        }
    }
}

struct MenuBar: View {
    @Binding var isCreateViewPresented: Bool
    @ObservedResults(MyDataModel.self) var dataModels
    @StateObject var viewModel = ViewModel()
    
    // MenuBar 의 상태를 MainView 에 전달하고 업데이트
    var body: some View {
        ZStack {
            // 배경색 설정
            Color(red: 191/255, green: 255/255, blue: 0/255)
                .frame(width: 330 , height: 45)
                .cornerRadius(13)
            
            HStack {
                Button(action: {
                    // 버튼 액션
                    
                }) {
                    Text("Note")
                        .foregroundColor(.black)
                        .font(.system(size: 13))
                        .bold()
                        .padding(.leading, 40)
                }
                Spacer()
                
                Button(action: {
                    self.isCreateViewPresented.toggle()
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(.black)
                        .font(.system(size: 15))
                        .padding(.trailing, 40)
                }
            }
            .padding(.vertical, 20)
        }
        .sheet(isPresented: $isCreateViewPresented) {
            CreateView()
        }
        /*
         HStack {
         
         Color.gray
         .opacity(0.3)
         .frame(width: 330 , height: 200)
         .cornerRadius(13)
         }
         */
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: 220), spacing: 20)
            ], spacing: 20) {
                if let tasks = viewModel.tasks {
                    ForEach(tasks) { task in
                        RoundedRectangle(cornerRadius: 13)
                            .foregroundColor(Color.gray.opacity(0.3))
                            .frame(height: 200)
                            .overlay(
                                VStack {
                                    Text(task.titleText)
                                        .foregroundColor(.white)
                                    Spacer()
                                    Text(task.timeText)
                                        .foregroundColor(.white)
                                }
                                .padding()
                            )
                            .padding()
                    }
                } else {
                    Text("Loading...")
                        .foregroundColor(.white)
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.getRealmData()
        }
    }
}

#Preview {
    MainView()
}

