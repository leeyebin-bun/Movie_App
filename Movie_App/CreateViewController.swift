import UIKit
import RealmSwift
import SwiftUI
import SplineRuntime

struct CreateView: View {
    @State private var isDatePickerVisible = false
    @State private var selectedDate = Date()
    
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
