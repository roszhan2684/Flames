import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = FlamesViewModel()
    @State private var showSplash = true

    var body: some View {
        NavigationStack {
            ZStack {
                if showSplash {
                    SplashView {
                        withAnimation(.easeInOut) {
                            showSplash = false
                        }
                    }
                    .transition(.opacity)
                } else {
                    HomeView(viewModel: viewModel)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
