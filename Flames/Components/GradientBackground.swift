import SwiftUI

struct GradientBackground: View {
    var body: some View {
        ZStack {
            Color(red: 0.06, green: 0.06, blue: 0.12)
                .ignoresSafeArea()

            GeometryReader { proxy in
                // Violet glow — top leading
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [
                                Color(red: 0.48, green: 0.18, blue: 0.92).opacity(0.42),
                                .clear
                            ],
                            center: .center,
                            startRadius: 0,
                            endRadius: proxy.size.width * 0.55
                        )
                    )
                    .frame(width: proxy.size.width * 1.1, height: proxy.size.width * 1.1)
                    .offset(x: -proxy.size.width * 0.28, y: -proxy.size.height * 0.12)
                    .blur(radius: 32)

                // Rose glow — bottom trailing
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [
                                Color(red: 0.90, green: 0.18, blue: 0.48).opacity(0.35),
                                .clear
                            ],
                            center: .center,
                            startRadius: 0,
                            endRadius: proxy.size.width * 0.45
                        )
                    )
                    .frame(width: proxy.size.width * 0.92, height: proxy.size.width * 0.92)
                    .offset(x: proxy.size.width * 0.42, y: proxy.size.height * 0.58)
                    .blur(radius: 32)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    GradientBackground()
}
