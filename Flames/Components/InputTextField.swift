import SwiftUI

struct InputTextField: View {
    let title: String
    let placeholder: String
    let systemImage: String
    @Binding var text: String
    var isFocused: FocusState<Bool>.Binding? = nil

    private var focused: Bool {
        isFocused?.wrappedValue ?? false
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.caption.weight(.semibold))
                .tracking(1.5)
                .textCase(.uppercase)
                .foregroundStyle(.white.opacity(0.42))

            HStack(spacing: 12) {
                Image(systemName: systemImage)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(.white.opacity(focused ? 0.70 : 0.32))
                    .frame(width: 20)
                    .animation(.easeInOut(duration: 0.2), value: focused)

                if let isFocused {
                    TextField(placeholder, text: $text)
                        .textInputAutocapitalization(.words)
                        .disableAutocorrection(true)
                        .foregroundStyle(.white)
                        .tint(.white)
                        .focused(isFocused)
                } else {
                    TextField(placeholder, text: $text)
                        .textInputAutocapitalization(.words)
                        .disableAutocorrection(true)
                        .foregroundStyle(.white)
                        .tint(.white)
                }
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Color.white.opacity(focused ? 0.10 : 0.06))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .strokeBorder(
                                focused ? Color.white.opacity(0.30) : Color.white.opacity(0.10),
                                lineWidth: 1
                            )
                    )
                    .animation(.easeInOut(duration: 0.2), value: focused)
            )
        }
    }
}

#Preview {
    InputTextField(title: "Your Name", placeholder: "Jane", systemImage: "person.fill", text: .constant(""))
        .padding()
        .background(GradientBackground())
}
