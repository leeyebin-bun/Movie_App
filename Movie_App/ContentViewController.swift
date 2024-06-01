import SwiftUI
import SplineRuntime
import UIKit

struct ContentView: View {
    var body: some View {
        ZStack{
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                //3D
                Header()
                    .frame(height: 530)
                
                VStack(spacing:20)
                {
                    Text("Let's eat Movie")
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 30))
                    Text("It will be easier than you think !")
                        .foregroundColor(Color(UIColor(red: 191/255, green: 255/255, blue: 0/255, alpha: 1.0)))
                        .font(.system(size: 16))
                    
                    Button(action: {
                        Coordinator().presentCreateView()
                    })
                    {
                        Text("Start")
                            .fontWeight(.bold) // 버튼 텍스트 크기 설정
                            //.fontWeight(.bold) // 버튼 텍스트 굵게 설정
                            .padding()
                            .frame(width: 300)
                            .background(Color(UIColor(red: 191/255, green: 255/255, blue: 0/255, alpha: 1.0)))
                            .foregroundColor(.black)
                            .cornerRadius(20)
                    }
                }
                .padding()
                Spacer()
            }
        }
    }
}

struct Coordinator {
    func presentCreateView() {
        guard let keyWindow = UIApplication.shared.windows.filter({$0.isKeyWindow}).first,
              let rootViewController = keyWindow.rootViewController else {
            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let posterVC = storyboard.instantiateViewController(withIdentifier: "PosterView") as? UIViewController else {
            return
        }
        
        posterVC.modalTransitionStyle = .coverVertical
        posterVC.modalPresentationStyle = .fullScreen
        
        rootViewController.present(posterVC, animated: true, completion: nil)
    }
}

struct Header:View {
    var body: some View {
        let url = URL(string: "https://build.spline.design/TfTFKrASp3EMpzwRLbgf/scene.splineswift")!
        try? SplineView(sceneFileURL: url).ignoresSafeArea(.all)
    }
}

struct Movie_App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

/*
#Preview {
    ContentView()
}
*/
