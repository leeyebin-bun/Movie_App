import SwiftUI
import RealmSwift

struct MainImageView: View {
    @StateObject private var viewModel = MyDataViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    if let task = viewModel.tasks?.first {
                        Image(uiImage: imageForTask(task))
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.yellow)
                    } else {
                        Text("Loading...")
                    }
                }
                .padding()
                
                Spacer()
            }
            .onAppear {
                viewModel.getRealmData()
            }
        }
    }
    
    func imageForTask(_ task: MyDataModel) -> UIImage {
        switch viewModel.tasks?.count ?? 0 {
        case 0:
            return UIImage(named:"1")!
        default:
            return UIImage(named:"2")! // 기본 이미지
        }
    }
}

#Preview {
    MainImageView()
}
