import SwiftUI

struct ResultView: View {
    @ObservedObject var viewModel: FlamesViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var cardVisible = false

    private var accentColor: Color {
        guard let letter = viewModel.result?.resultLetter else { return .white }
        return AppConstants.flameColors[letter] ?? .white
    }

    var body: some View {
        ZStack {
            GradientBackground()

            // Subtle per-result color wash
            accentColor
                .opacity(0.05)
                .ignoresSafeArea()

            ScrollView {
                if let result = viewModel.result {
                    VStack(spacing: 24) {
                        // Names header
                        VStack(spacing: 6) {
                            HStack(spacing: 10) {
                                Text(result.originalFirstName)
                                    .font(.title3.weight(.semibold))
                                    .foregroundStyle(.white)
                                Image(systemName: "heart.fill")
                                    .font(.caption)
                                    .foregroundStyle(accentColor)
                                Text(result.originalSecondName)
                                    .font(.title3.weight(.semibold))
                                    .foregroundStyle(.white)
                            }
                            Text("your flames result")
                                .font(.caption.weight(.light))
                                .tracking(2)
                                .textCase(.uppercase)
                                .foregroundStyle(.white.opacity(0.36))
                        }
                        .padding(.top, 16)

                        // Result card with spring reveal
                        ResultCard(
                            resultLetter: result.resultLetter,
                            meaning: result.resultMeaning,
                            description: result.resultDescription
                        )
                        .scaleEffect(cardVisible ? 1.0 : 0.86)
                        .opacity(cardVisible ? 1.0 : 0.0)
                        .animation(.spring(response: 0.55, dampingFraction: 0.72).delay(0.15), value: cardVisible)

                        // Stat cards
                        HStack(spacing: 12) {
                            statCard(
                                icon: "number",
                                label: "Remaining",
                                value: "\(result.remainingCount)"
                            )
                            statCard(
                                icon: "minus.circle",
                                label: "Common Letters",
                                value: result.removedLettersSummary
                            )
                        }
                        .opacity(cardVisible ? 1.0 : 0.0)
                        .animation(.easeOut(duration: 0.4).delay(0.40), value: cardVisible)

                        // Actions
                        HStack(spacing: 12) {
                            PrimaryButton(title: "Try Again", systemImage: "arrow.counterclockwise") {
                                withAnimation(.easeInOut) {
                                    viewModel.resetForNew()
                                    dismiss()
                                }
                            }

                            ShareLink(item: viewModel.shareText) {
                                HStack(spacing: 8) {
                                    Image(systemName: "square.and.arrow.up")
                                        .font(.system(size: 14, weight: .semibold))
                                    Text("Share")
                                        .font(.headline)
                                        .tracking(0.3)
                                }
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 17)
                                .background(
                                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                                        .fill(Color.white.opacity(0.08))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                                .strokeBorder(Color.white.opacity(0.14), lineWidth: 1)
                                        )
                                )
                            }
                        }
                        .opacity(cardVisible ? 1.0 : 0.0)
                        .animation(.easeOut(duration: 0.4).delay(0.52), value: cardVisible)
                    }
                    .padding(.horizontal, 28)
                    .padding(.bottom, 40)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear { cardVisible = true }
    }

    private func statCard(icon: String, label: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(accentColor.opacity(0.80))
                Text(label)
                    .font(.caption.weight(.semibold))
                    .tracking(0.5)
                    .foregroundStyle(.white.opacity(0.42))
            }
            Text(value)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.white)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Color.white.opacity(0.06))
                .overlay(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .strokeBorder(Color.white.opacity(0.10), lineWidth: 1)
                )
        )
    }
}

#Preview {
    let vm = FlamesViewModel()
    vm.result = FlamesCalculator().calculate(firstName: "Alex", secondName: "Sam")
    vm.isShowingResult = true
    return NavigationStack {
        ResultView(viewModel: vm)
    }
}
