import SwiftUI

struct PrimaryButton: View {
    let title: String
    var systemImage: String? = nil
    var action: () -> Void

    @State private var isPressed = false

    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                if let systemImage {
                    Image(systemName: systemImage)
                        .font(.system(size: 15, weight: .semibold))
                }
                Text(title)
                    .font(.headline)
                    .tracking(0.3)
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 17)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 0.55, green: 0.20, blue: 0.95),
                                Color(red: 0.90, green: 0.18, blue: 0.52)
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .shadow(
                        color: Color(red: 0.65, green: 0.18, blue: 0.85).opacity(isPressed ? 0.30 : 0.55),
                        radius: isPressed ? 8 : 20,
                        x: 0,
                        y: isPressed ? 2 : 8
                    )
            )
        }
        .buttonStyle(.plain)
        .scaleEffect(isPressed ? 0.97 : 1.0)
        .animation(.spring(response: 0.25, dampingFraction: 0.75), value: isPressed)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in isPressed = true }
                .onEnded { _ in isPressed = false }
        )
    }
}

#Preview {
    PrimaryButton(title: "Check FLAMES", systemImage: "sparkles") {}
        .padding()
        .background(GradientBackground())
}
