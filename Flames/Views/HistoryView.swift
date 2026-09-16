import SwiftUI

struct HistoryView: View {
    @StateObject private var viewModel = HistoryViewModel()

    var body: some View {
        ZStack {
            GradientBackground()

            VStack(alignment: .leading, spacing: 0) {
                // Header
                VStack(alignment: .leading, spacing: 6) {
                    Text("History")
                        .font(.system(size: 28, weight: .black, design: .rounded))
                        .tracking(1)
                        .foregroundStyle(.white)
                    Text("\(viewModel.items.count) match\(viewModel.items.count == 1 ? "" : "es")")
                        .font(.caption.weight(.light))
                        .tracking(1.5)
                        .textCase(.uppercase)
                        .foregroundStyle(.white.opacity(0.33))
                }
                .padding(.top, 20)
                .padding(.horizontal, 28)
                .padding(.bottom, 20)

                if viewModel.items.isEmpty {
                    VStack(spacing: 14) {
                        Image(systemName: "clock.badge.xmark")
                            .font(.system(size: 36, weight: .light))
                            .foregroundStyle(.white.opacity(0.22))
                        Text("No matches yet")
                            .font(.subheadline.weight(.medium))
                            .foregroundStyle(.white.opacity(0.42))
                        Text("Start a new FLAMES check to see your history here.")
                            .font(.caption)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white.opacity(0.26))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 60)
                    .padding(.horizontal, 28)

                    Spacer()
                } else {
                    List {
                        ForEach(viewModel.items) { item in
                            historyRow(item: item)
                                .listRowBackground(Color.clear)
                                .listRowInsets(EdgeInsets(top: 5, leading: 28, bottom: 5, trailing: 28))
                                .listRowSeparator(.hidden)
                        }
                        .onDelete(perform: viewModel.delete)
                    }
                    .scrollContentBackground(.hidden)
                    .listStyle(.plain)

                    Button {
                        viewModel.clearAll()
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "trash")
                                .font(.system(size: 13, weight: .medium))
                            Text("Clear All")
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
                    .padding(.horizontal, 28)
                    .padding(.bottom, 36)
                }
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { viewModel.load() }
    }

    private func historyRow(item: HistoryItem) -> some View {
        let accent = AppConstants.flameColors[item.resultLetter] ?? .white
        return HStack(spacing: 14) {
            // Colored letter badge
            ZStack {
                Circle()
                    .fill(accent.opacity(0.14))
                    .frame(width: 44, height: 44)
                    .overlay(
                        Circle().strokeBorder(accent.opacity(0.32), lineWidth: 1)
                    )
                Text(item.resultLetter)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundStyle(accent)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("\(item.firstName)  ·  \(item.secondName)")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.white)
                Text(item.resultMeaning)
                    .font(.caption.weight(.medium))
                    .foregroundStyle(accent.opacity(0.82))
            }

            Spacer()

            Text("\(item.remainingCount)")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.white.opacity(0.28))
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Color.white.opacity(0.06))
                .overlay(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .strokeBorder(Color.white.opacity(0.09), lineWidth: 1)
                )
        )
    }
}

#Preview {
    NavigationStack {
        HistoryView()
    }
}
