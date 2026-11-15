import SwiftUI
import Playgrounds

struct ContentView: View {

    @State private var showHome = false

    var body: some View {

        ZStack {

            if showHome {

                HomeView()

            } else {

                SplashView()

            }
        }
        .task {

            try? await Task.sleep(for: .seconds(2))

            withAnimation(.easeInOut(duration: 0.5)) {
                showHome = true
            }
        }
    }
}

#Preview {
    ContentView()
}
