
import UIKit
import RealmSwift
import SwiftUI
import SplineRuntime


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
    }
}

#Preview {
    MainView()
}

