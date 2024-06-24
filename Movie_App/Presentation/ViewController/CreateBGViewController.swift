import SwiftUI
import RealmSwift

struct CreateBGView : View {
    @ObservedObject var viewModel = MyDataViewModel()
    @State private var isPresented = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("행성을 선택해주세요")
                        .foregroundColor(Color.white)
                        .font(.title3)
                    
                    HStack(spacing:20){
                        Button(action: {
                            isPresented = true
                        }) {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 100, height: 100)
                            
                        }
                        .sheet(isPresented: $isPresented) {
                            MainImageView(viewModel: viewModel)
                        }
                        Button(action: {
                            // 아직 하나만 열어둘게용 ..
                        }) {
                            
                            Circle()
                                .fill(Color.green)
                                .frame(width: 100, height: 100)
                        }
                        
                    }
                    .padding(40)
                }
                
            }
        }
        
    }
}

#Preview {
    CreateBGView()
}
