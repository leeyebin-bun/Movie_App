import SwiftUI
import RealmSwift

struct MainView: View {
    @StateObject private var viewModel = MyDataViewModel()
    @State private var isCreateViewPresented = false
    
    var body: some View {
        NavigationView {
            VStack {
                if let tasks = viewModel.tasks {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
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
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
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

#Preview {
    MainView()
}

