import SwiftUI
import RealmSwift

struct MainImageView: View {
    @StateObject private var viewModel = MyDataViewModel()
    @State private var isPresented = false
    
    let planetImage = ["1","2","3","4","5","6","7","8","9","10"]
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
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
                    Spacer()
                    if let task = viewModel.tasks?.first {
                        let imageIndex = min(viewModel.tasks?.count ?? 0, planetImage.count) - 1
                        Image(uiImage: UIImage(named: planetImage[imageIndex]) ?? UIImage())
                        //해당 이미지를 찾지 못하면 빈 이미지 출력하기
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.yellow)
                    } else {
                        Text("Loading...")
                    }
                }
            }
            .onAppear {
                viewModel.getRealmData()
            }
        }
    }
}

#Preview {
    MainImageView()
}
