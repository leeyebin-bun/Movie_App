import SwiftUI
import RealmSwift

struct CreateView: View {
    @ObservedObject var viewModel: MyDataViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var title = ""
    @State private var time = ""
   // @State private var photo: Data? = nil
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Time", text: $time)
                // Add photo selection UI here
                Button("Save") {
                    viewModel.saveData(titleText: title, timeText: time)
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

