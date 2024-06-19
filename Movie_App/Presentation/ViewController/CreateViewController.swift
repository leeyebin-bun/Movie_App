import SwiftUI
import RealmSwift

struct CreateView: View {
    @ObservedObject var viewModel: MyDataViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var title = ""
    @State private var time = ""
    @State private var date = Date()
    // @State private var photo: Data? = nil
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Time", text: $time)
                DatePicker("Select Date", selection: $date, displayedComponents: .date)
                
                Button("Save") {
                    viewModel.saveData(titleText: title, timeText: time, dateText: date)
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .navigationTitle("Create Task")
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

#Preview {
    CreateView(viewModel: MyDataViewModel())
}

