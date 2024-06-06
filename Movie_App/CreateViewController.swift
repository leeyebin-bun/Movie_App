import UIKit
import RealmSwift
import SwiftUI
import SplineRuntime

struct CreateView: View {
    @State private var isDatePickerVisible = false
    @State private var selectedDate = Date()
    @State private var title = ""
    @State private var name = ""
    @State private var note = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                
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
            
                VStack(spacing: 100) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(Color(UIColor(red: 191/255, green: 255/255, blue: 0/255, alpha: 1.0)))
                            .frame(width: 60, height: 25)
                        Text("title")
                            .foregroundColor(.black)
                    }
                    .padding(.leading, 30) // 왼쪽 마진 추가

                    ZStack{
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(Color(UIColor(red: 191/255, green: 255/255, blue: 0/255, alpha: 1.0)))
                            .frame(width: 60, height: 25)
                        Text("time")
                            .foregroundColor(.black)
                    }
                    .padding(.leading, 30) // 왼쪽 마진 추가
                    ZStack{
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(Color(UIColor(red: 191/255, green: 255/255, blue: 0/255, alpha: 1.0)))
                            .frame(width: 60, height: 25)
                        Text("note")
                            .foregroundColor(.black)
                    }
                    .padding(.leading, 30) // 왼쪽 마진 추가
                    ZStack{
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(Color(UIColor(red: 191/255, green: 255/255, blue: 0/255, alpha: 1.0)))
                            .frame(width: 60, height: 25)
                        Text("photo")
                            .foregroundColor(.black)
                    }
                    .padding(.leading, 30) // 왼쪽 마진 추가
                }
                .padding(.bottom , 150)
                .frame(maxWidth: .infinity, alignment: .leading) // 내부 요소의 정렬을 왼쪽으로
            }
            //.frame(maxWidth: .infinity, alignment: .leading) // 최대 너비 지정
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
