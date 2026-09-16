import SwiftUI

struct SplashView: View {
    var onContinue: () -> Void

    @State private var glowOpacity: Double = 0
    @State private var iconOpacity: Double = 0
    @State private var textOpacity: Double = 0
    @State private var buttonOpacity: Double = 0

    var body: some View {
        ZStack {
            GradientBackground()

            VStack(spacing: 0) {
                Spacer()

                VStack(spacing: 36) {
                    // Flame icon with radial glow
                    ZStack {
                        Circle()
                            .fill(
                                RadialGradient(
                                    colors: [
                                        Color(red: 0.90, green: 0.18, blue: 0.52).opacity(0.55),
                                        .clear
                                    ],
                                    center: .center,
                                    startRadius: 0,
                                    endRadius: 90
                                )
                            )
                            .frame(width: 180, height: 180)
                            .opacity(glowOpacity)
                            .blur(radius: 10)

                        Image(systemName: "flame.fill")
                            .font(.system(size: 68, weight: .medium))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [
                                        Color(red: 1.0, green: 0.62, blue: 0.20),
                                        Color(red: 0.98, green: 0.27, blue: 0.52)
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .opacity(iconOpacity)
                    }

                    // Title
                    VStack(spacing: 10) {
                        Text("FLAMES")
                            .font(.system(size: 40, weight: .black, design: .rounded))
                            .tracking(10)
                            .foregroundStyle(.white)

                        Text("Discover your connection")
                            .font(.caption.weight(.light))
                            .tracking(2.5)
                            .textCase(.uppercase)
                            .foregroundStyle(.white.opacity(0.36))
                    }
                    .opacity(textOpacity)
                }

                Spacer()

                // CTA
                VStack(spacing: 14) {
                    PrimaryButton(title: "Begin", systemImage: "arrow.right") {
                        onContinue()
                    }

                    Text("The classic relationship game, reimagined")
                        .font(.caption2)
                        .tracking(0.5)
                        .foregroundStyle(.white.opacity(0.26))
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 52)
                .opacity(buttonOpacity)
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.9)) { glowOpacity = 1 }
            withAnimation(.easeOut(duration: 0.7).delay(0.25)) { iconOpacity = 1 }
            withAnimation(.easeOut(duration: 0.7).delay(0.45)) { textOpacity = 1 }
            withAnimation(.easeOut(duration: 0.7).delay(0.65)) { buttonOpacity = 1 }
        }
    }
}

#Preview {
    SplashView {}
}
