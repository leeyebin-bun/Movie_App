import SwiftUI
import RealmSwift

struct CreateView: View {
    @ObservedObject var viewModel: MyDataViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var isPresented = false
    @State private var title = ""
    @State private var time = ""
    @State private var date = Date()
    @State private var kind = ""
    @State private var famousLine = ""
   
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Time", text: $time)
                TextField("kind", text: $kind)
                DatePicker("Select Date", selection: $date, displayedComponents: .date)
                TextField("famousLine", text: $famousLine)
                Button("Save") {
                    isPresented = true
                    viewModel.saveData(titleText: title, timeText: time, dateText: date , kindText: kind, famousLineText: famousLine)
                    presentationMode.wrappedValue.dismiss()
                }
                .sheet(isPresented: $isPresented){
                    MainView()
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

