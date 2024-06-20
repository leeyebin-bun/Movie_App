import SwiftUI
import RealmSwift

struct MainImageView: View {
    @StateObject private var viewModel = MyDataViewModel()
    @State private var isPresented = false
    
    let planetImage = ["1","2","3","4","5","6","7","8","9","10"]
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    //Color.black
                    //.edgesIgnoringSafeArea(.all)
                    Image("BG_2")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        RoundedRectangle(cornerRadius: 13)
                            .fill(Color(red: 191/255, green: 255/255, blue: 0/255))
                            .frame(width: 330, height: 50)
                            .overlay(
                                VStack {
                                    Button(action: {
                                        isPresented = true
                                    }) {
                                        Image(systemName: "plus")
                                            .foregroundColor(.black)
                                    }
                                    .sheet(isPresented: $isPresented) {
                                        MainView()
                                    }
                                }
                            )
                        if let tasks = viewModel.tasks {
                            ForEach(tasks.indices, id: \.self) { index in
                                let randomX = CGFloat.random(in: geometry.size.width * 0.25 ... geometry.size.width * 0.75)
                                let randomY = CGFloat.random(in: geometry.size.height * 0.25 ... geometry.size.height * 0.75)
                                                    
                                let imageIndex = min(index, planetImage.count - 1)
                                Image(uiImage: UIImage(named: planetImage[imageIndex]) ?? UIImage())
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .position(x:randomX , y:randomY)
                            }
                            Spacer()
                        }
                    }
                    .onAppear {
                        viewModel.getRealmData()
                    }
                }
            }
        }
    }
}

#Preview {
    MainImageView()
}
