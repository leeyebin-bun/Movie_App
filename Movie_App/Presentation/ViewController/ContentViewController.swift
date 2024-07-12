import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @State private var isPresented = false

    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    VStack(spacing: 20) {
                        Text("Let's Eat Movie")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.system(size: 30))
                        Text("It will be easier than you think!")
                            .foregroundColor(Color(UIColor(red: 191/255, green: 255/255, blue: 0/255, alpha: 1.0)))
                            .font(.system(size: 16))
                        
                        NavigationLink(destination: CalendarView()) {
                            Text("Start")
                                .fontWeight(.bold)
                                .padding()
                                .frame(width: 250)
                                .background(Color(UIColor(red: 191/255, green: 255/255, blue: 0/255, alpha: 1.0)))
                                .foregroundColor(.black)
                                .cornerRadius(20)
                        }
                        
                        Spacer()
                    }
                    .padding()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
