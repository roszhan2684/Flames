import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: FlamesViewModel
    @FocusState private var isFirstFocused: Bool
    @FocusState private var isSecondFocused: Bool

    var body: some View {
        ZStack {
            GradientBackground()

            VStack(spacing: 0) {
                // Header
                VStack(spacing: 6) {
                    Text("FLAMES")
                        .font(.system(size: 28, weight: .black, design: .rounded))
                        .tracking(7)
                        .foregroundStyle(.white)
                    Text("Enter two names")
                        .font(.caption.weight(.light))
                        .tracking(2)
                        .textCase(.uppercase)
                        .foregroundStyle(.white.opacity(0.36))
                }
                .padding(.top, 44)

                Spacer()

                // Input form
                VStack(spacing: 18) {
                    InputTextField(
                        title: "First Name",
                        placeholder: "e.g. Alex",
                        systemImage: "person.fill",
                        text: $viewModel.firstName,
                        isFocused: $isFirstFocused
                    )

                    // AND divider
                    HStack(spacing: 14) {
                        Rectangle()
                            .fill(Color.white.opacity(0.08))
                            .frame(height: 1)
                        Text("AND")
                            .font(.caption2.weight(.semibold))
                            .tracking(2.5)
                            .foregroundStyle(.white.opacity(0.22))
                            .fixedSize()
                        Rectangle()
                            .fill(Color.white.opacity(0.08))
                            .frame(height: 1)
                    }

                    InputTextField(
                        title: "Second Name",
                        placeholder: "e.g. Sam",
                        systemImage: "person.2.fill",
                        text: $viewModel.secondName,
                        isFocused: $isSecondFocused
                    )

                    if !viewModel.errorMessage.isEmpty {
                        HStack(spacing: 8) {
                            Image(systemName: "exclamationmark.circle.fill")
                                .font(.caption)
                            Text(viewModel.errorMessage)
                                .font(.caption.weight(.medium))
                        }
                        .foregroundStyle(Color(red: 1.0, green: 0.50, blue: 0.50))
                        .padding(12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(Color(red: 1.0, green: 0.35, blue: 0.35).opacity(0.10))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                                        .strokeBorder(Color(red: 1.0, green: 0.35, blue: 0.35).opacity(0.22), lineWidth: 1)
                                )
                        )
                        .transition(.opacity.combined(with: .move(edge: .top)))
                    }

                    PrimaryButton(title: "Reveal FLAMES", systemImage: "sparkles") {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                            viewModel.calculateResult()
                        }
                    }
                    .padding(.top, 6)
                }
                .padding(.horizontal, 28)

                Spacer()

                // Bottom navigation
                HStack(spacing: 12) {
                    NavigationLink {
                        HistoryView()
                    } label: {
                        navButton(icon: "clock", label: "History")
                    }

                    NavigationLink {
                        AboutView()
                    } label: {
                        navButton(icon: "info.circle", label: "About")
                    }
                }
                .padding(.horizontal, 28)
                .padding(.bottom, 40)
            }
        }
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $viewModel.isShowingResult) {
            ResultView(viewModel: viewModel)
        }
        .onAppear {
            isFirstFocused = false
            isSecondFocused = false
        }
    }

    private func navButton(icon: String, label: String) -> some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 13, weight: .medium))
            Text(label)
                .font(.subheadline.weight(.medium))
        }
        .foregroundStyle(.white.opacity(0.52))
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(Color.white.opacity(0.06))
                .overlay(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .strokeBorder(Color.white.opacity(0.10), lineWidth: 1)
                )
        )
    }
}

#Preview {
    NavigationStack {
        HomeView(viewModel: FlamesViewModel())
    }
}
