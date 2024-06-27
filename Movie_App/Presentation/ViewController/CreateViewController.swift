import SwiftUI
import RealmSwift
import Alamofire

struct CreateView: View {
    @ObservedObject var viewModel: MyDataViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var isPresented = false
    @State private var title = ""
    @State private var time = ""
    @State private var date = Date()
    @State private var kind = ""
    @State private var famousLine = ""
    @State private var rating: Int = 0
    @State private var image: UIImage?
    @State private var imageUrl: String?
    
    
    var body: some View {
        NavigationView {
            ZStack{
                //Color.black
                 // .edgesIgnoringSafeArea(.all)
                
                VStack{
                    HStack(spacing: 10) {
                        ForEach(1..<6) { index in
                            Image(systemName: index <= rating ? "star.fill" : "star")
                                .resizable()
                                .frame(width: 32, height: 32)
                                .foregroundColor(index <= rating ? Color.yellow : Color.yellow)
                                .onTapGesture {
                                    rating = index
                                }
                        }
                    }
                    .padding()
                    
                    Text("평점을 매겨주세요")
                        .foregroundColor(.black)
                        .padding(.bottom, 20)
                    
                    TextField("영화제목", text: $title)
                    TextField("러닝타임", text: $time)
                    //TextField("평점", text: $kind)
                    DatePicker("날짜", selection: $date, displayedComponents: .date)
                    TextField("기억에 남는 명대사를 적어보세요!", text: $famousLine)
                    Button("Save") {
                        isPresented = true
                        viewModel.saveData(titleText: title, timeText: time, dateText: date , rating: rating, famousLineText: famousLine)
                        presentationMode.wrappedValue.dismiss()
                    }
                    .sheet(isPresented: $isPresented){
                        MainView()
                    }
                    Spacer()
                    
                        .navigationBarItems(trailing: Button("Cancel") {
                            presentationMode.wrappedValue.dismiss()
                        })
                }
            }
        }
    }
}


#Preview {
    CreateView(viewModel: MyDataViewModel())
}

