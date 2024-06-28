import SwiftUI
import SplineRuntime
import FirebaseAuth

struct ContentView: View {
    @State private var isPresented = false
    @State private var isUserAuthenticated = Auth.auth().currentUser != nil
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // 3D Header
                Header()
                    .frame(height: 530)
                
                VStack(spacing: 20) {
                    Text("Let's Eat Movie")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 30))
                    Text("It will be easier than you think!")
                        .foregroundColor(Color(UIColor(red: 191/255, green: 255/255, blue: 0/255, alpha: 1.0)))
                        .font(.system(size: 16))
                    
                    Button(action: {
                        self.isPresented.toggle()
                    }) {
                        Text("Start")
                            .fontWeight(.bold)
                            .padding()
                            .frame(width: 250)
                            .background(Color(UIColor(red: 191/255, green: 255/255, blue: 0/255, alpha: 1.0)))
                            .foregroundColor(.black)
                            .cornerRadius(20)
                    }
                    .sheet(isPresented: $isPresented) {
                        if isUserAuthenticated {
                            CreateBGView()
                        } else {
                            LoginView(isUserAuthenticated: $isUserAuthenticated)
                        }
                    }
                    .padding()
                    
                    Spacer()
                }
            }
        }
        .onAppear {
            // 인증 상태 변경을 감지하여 isUserAuthenticated 업데이트
            Auth.auth().addStateDidChangeListener { _, user in
                isUserAuthenticated = user != nil
            }
        }
    }
}

// Header View (Spline Runtime 사용 예시)
struct Header: View {
    var body: some View {
        let url = URL(string: "https://build.spline.design/TfTFKrASp3EMpzwRLbgf/scene.splineswift")!
        if let splineView = try? SplineView(sceneFileURL: url) {
            return AnyView(splineView.ignoresSafeArea(.all))
        } else {
            return AnyView(EmptyView())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
