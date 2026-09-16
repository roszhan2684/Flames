import Foundation

extension String {
    var normalizedName: String {
        trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
            .replacingOccurrences(of: " ", with: "")
    }

    var containsOnlyAllowedNameCharacters: Bool {
        rangeOfCharacter(from: AppConstants.inputAllowedCharacters.inverted) == nil
    }

    var lettersArray: [Character] {
        Array(normalizedName)
    }
}
