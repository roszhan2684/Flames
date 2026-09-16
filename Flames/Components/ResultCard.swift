import SwiftUI

struct ResultCard: View {
    let resultLetter: String
    let meaning: String
    let description: String

    private var accentColor: Color {
        AppConstants.flameColors[resultLetter] ?? .white
    }

    var body: some View {
        VStack(spacing: 20) {
            // Letter badge with color glow
            ZStack {
                Circle()
                    .fill(accentColor.opacity(0.18))
                    .frame(width: 130, height: 130)
                    .blur(radius: 24)

                Circle()
                    .fill(Color.white.opacity(0.05))
                    .frame(width: 100, height: 100)
                    .overlay(
                        Circle()
                            .strokeBorder(accentColor.opacity(0.45), lineWidth: 1.5)
                    )

                Text(resultLetter)
                    .font(.system(size: 48, weight: .bold, design: .rounded))
                    .foregroundStyle(accentColor)
            }

            VStack(spacing: 6) {
                Text(meaning)
                    .font(.title2.weight(.bold))
                    .foregroundStyle(.white)

                Text(description)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white.opacity(0.58))
                    .lineSpacing(4)
            }
        }
        .padding(28)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(Color.white.opacity(0.06))
                .overlay(
                    RoundedRectangle(cornerRadius: 28, style: .continuous)
                        .strokeBorder(accentColor.opacity(0.28), lineWidth: 1)
                )
        )
    }
}

#Preview {
    ResultCard(resultLetter: "L", meaning: "Love", description: "Heart-eye vibes. There is a strong romantic spark here.")
        .padding()
        .background(GradientBackground())
}
