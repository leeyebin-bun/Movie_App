import SwiftUI
import SplineRuntime

struct ContentView: View {
    var body: some View {
        VStack{
            //3D
            Header()
                .frame(height: 500)
            
            VStack(spacing:30)
            {
                Text("Welcome")
                    .bold()
                Button("Start")
                {
                    
                }
            }
            Spacer()
        }
    }
}


struct Header:View {
    var body: some View {
        let url = URL(string: "https://build.spline.design/JlziB7XG8zYuLskwh5lq/scene.splineswift")!
        
        try? SplineView(sceneFileURL: url).ignoresSafeArea(.all)
    }
}

struct Movie_App: App { // YourAppNameApp을 실제 프로젝트 이름으로 변경
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
