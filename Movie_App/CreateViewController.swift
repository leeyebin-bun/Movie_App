import SplineRuntime
import UIKit
import RealmSwift
import SwiftUI

class MyDataModel: Object , Identifiable {
    @Persisted var titleText: String = ""
    @Persisted var timeText: String = ""
    @Persisted var imageData: Data?
}

struct CreateView: View {
    @State private var isDatePickerVisible = false
    @State private var selectedDate = Date()
    @State private var title = ""
    @State private var time = ""
    @State private var note = ""
    @State private var photo = ""
    
    @Environment(\.presentationMode) var presentationMode

   
    let realm = try! Realm() // Realm 인스턴스 생성

        // 새로운 데이터 저장 함수
        func saveData() {
            let data = MyDataModel()
            data.titleText = title
            data.timeText = time

            do {
                try realm.write {
                    realm.add(data) // Realm에 데이터 저장
                }
                presentationMode.wrappedValue.dismiss()
            } catch {
                print("저장 안됐시요 \(error)")
            }
        }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                
                // Header
                VStack {
                    Button(action: {
                        isDatePickerVisible = true
                    }) {
                        Text(dateFormatter.string(from: selectedDate))
                            .padding()
                            .foregroundColor(.white)
                    }
                    .sheet(isPresented: $isDatePickerVisible) {
                        datePickerView
                    }
                    
                    Spacer()
                }
                
                // Body
                VStack(spacing: 60) {
                    VStack {
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(Color(UIColor(red: 191/255, green: 255/255, blue: 0/255, alpha: 1.0)))
                            .frame(width: 60, height: 25)
                            .overlay(
                                Text("Title")
                                    .foregroundColor(.black)
                            )
                            .padding(.trailing, 300)
                        
                        TextField("title", text: $title)
                            .foregroundColor(.white)
                            .onChange(of: title) { titleText in
                                if titleText.count > 20 {
                                    title = String(titleText.prefix(20)) // 제목 최대글자수 20자
                                }
                            }
                        
                        ZStack {
                            // 밑줄
                            Rectangle()
                                .frame(width: 350 ,height: 2)
                                .foregroundColor(Color(UIColor(red: 191/255, green: 255/255, blue: 0/255, alpha: 1.0)))
                        }
                    }
                    
                    VStack {
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(Color(UIColor(red: 191/255, green: 255/255, blue: 0/255, alpha: 1.0)))
                            .frame(width: 60, height: 25)
                            .overlay(
                                Text("Time")
                                    .foregroundColor(.black)
                            )
                            .padding(.trailing, 300)
                        
                        TextField("time", text: $time)
                            .foregroundColor(.white)
                            .onChange(of: time) { timeText in
                                if timeText.count > 20 {
                                    time = String(timeText.prefix(20)) // 제목 최대글자수 20자
                                }
                            }
                        
                        ZStack {
                            // 밑줄
                            Rectangle()
                                .frame(width: 350 ,height: 2)
                                .foregroundColor(Color(UIColor(red: 191/255, green: 255/255, blue: 0/255, alpha: 1.0)))
                        }
                    }

                    VStack {
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(Color(UIColor(red: 191/255, green: 255/255, blue: 0/255, alpha: 1.0)))
                            .frame(width: 60, height: 25)
                            .overlay(
                                Text("Note")
                                    .foregroundColor(.black)
                            )
                            .padding(.trailing, 300)
                        
                        TextField("note", text: $note)
                            .foregroundColor(.white)
                            .onChange(of: note) { noteText in
                                if noteText.count > 20 {
                                    note = String(noteText.prefix(20)) // 제목 최대글자수 20자
                                }
                            }
                        
                        ZStack {
                            // 밑줄
                            Rectangle()
                                .frame(width: 350 ,height: 2)
                                .foregroundColor(Color(UIColor(red: 191/255, green: 255/255, blue: 0/255, alpha: 1.0)))
                        }
                    }

                    VStack {
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(Color(UIColor(red: 191/255, green: 255/255, blue: 0/255, alpha: 1.0)))
                            .frame(width: 60, height: 25)
                            .overlay(
                                Text("Photo")
                                    .foregroundColor(.black)
                            )
                            .padding(.trailing, 300)
                    }
                    
                    // 완료 버튼
                    HStack {
                        Button(action: {
                            saveData()
                        }) {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 100, height: 40)
                                .foregroundColor(Color(UIColor(red: 100/255, green: 20/255, blue: 100/255, alpha: 1.0)))
                                .overlay(Text("Done").foregroundColor(.white)) // 버튼 내용 추가
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.black.edgesIgnoringSafeArea(.all))
            }
        }
    }
    
    private var datePickerView: some View {
        DatePicker("", selection: $selectedDate, displayedComponents: .date)
            .datePickerStyle(GraphicalDatePickerStyle())
            .padding()
            .onChange(of: selectedDate) { _ in
                isDatePickerVisible = false
            }
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
}

#Preview {
    CreateView()
}

