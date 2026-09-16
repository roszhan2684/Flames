import SwiftUI

struct AboutView: View {
    @StateObject private var historyViewModel = HistoryViewModel()
    @State private var isShowingClearHistoryAlert = false

    var body: some View {
        ZStack {
            GradientBackground()

            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    // Header
                    VStack(alignment: .leading, spacing: 6) {
                        Text("About")
                            .font(.system(size: 28, weight: .black, design: .rounded))
                            .tracking(1)
                            .foregroundStyle(.white)
                        Text("How it all works")
                            .font(.caption.weight(.light))
                            .tracking(2)
                            .textCase(.uppercase)
                            .foregroundStyle(.white.opacity(0.33))
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 6)

                    infoSection(
                        title: "What is FLAMES?",
                        body: "A playful game that pairs two names and uses the remaining letters to reveal a fun relationship vibe."
                    )

                    infoSection(
                        title: "How it Works",
                        body: "Remove common letters from both names.\nCount what remains.\nUse the count to eliminate letters in F-L-A-M-E-S.\nThe last letter standing reveals your result."
                    )

                    // Legend with color badges
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Legend")
                            .font(.caption.weight(.semibold))
                            .tracking(1.5)
                            .textCase(.uppercase)
                            .foregroundStyle(.white.opacity(0.42))

                        VStack(spacing: 10) {
                            ForEach(["F", "L", "A", "M", "E", "S"], id: \.self) { letter in
                                let color = AppConstants.flameColors[letter] ?? .white
                                let meaning = AppConstants.flameMeanings[letter] ?? ""
                                HStack(spacing: 12) {
                                    ZStack {
                                        Circle()
                                            .fill(color.opacity(0.14))
                                            .frame(width: 36, height: 36)
                                            .overlay(
                                                Circle().strokeBorder(color.opacity(0.32), lineWidth: 1)
                                            )
                                        Text(letter)
                                            .font(.system(size: 15, weight: .bold, design: .rounded))
                                            .foregroundStyle(color)
                                    }
                                    Text(meaning)
                                        .font(.subheadline.weight(.medium))
                                        .foregroundStyle(.white.opacity(0.78))
                                    Spacer()
                                }
                            }
                        }
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

                    infoSection(
                        title: "Legal",
                        body: "Terms of Service: Add your terms link or text here.\nPrivacy Policy: Add your privacy policy link or text here."
                    )

                    Button {
                        isShowingClearHistoryAlert = true
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "trash")
                                .font(.system(size: 13, weight: .medium))
                            Text("Clear History")
                                .font(.subheadline.weight(.semibold))
                        }
                        .foregroundStyle(Color(red: 1.0, green: 0.48, blue: 0.48))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(
                            RoundedRectangle(cornerRadius: 14, style: .continuous)
                                .fill(Color(red: 1.0, green: 0.35, blue: 0.35).opacity(0.10))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                                        .strokeBorder(Color(red: 1.0, green: 0.35, blue: 0.35).opacity(0.20), lineWidth: 1)
                                )
                        )
                    }
                }
                .padding(.horizontal, 28)
                .padding(.bottom, 40)
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Clear History?", isPresented: $isShowingClearHistoryAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Clear", role: .destructive) {
                historyViewModel.clearAll()
            }
        } message: {
            Text("This will remove all saved FLAMES results from this device.")
        }
    }

    private func infoSection(title: String, body: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.caption.weight(.semibold))
                .tracking(1.5)
                .textCase(.uppercase)
                .foregroundStyle(.white.opacity(0.42))
            Text(body)
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.70))
                .lineSpacing(5)
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
    NavigationStack {
        AboutView()
    }
}
