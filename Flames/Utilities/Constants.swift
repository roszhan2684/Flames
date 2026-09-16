import SwiftUI

enum AppConstants {
    static let appTitle = "FLAMES"
    static let subtitle = "A playful love compatibility game"

    static let flameMeanings: [String: String] = [
        "F": "Friends",
        "L": "Love",
        "A": "Affection",
        "M": "Marriage",
        "E": "Enemies",
        "S": "Siblings"
    ]

    static let flameDescriptions: [String: String] = [
        "F": "Besties energy. The bond feels easy, warm, and supportive.",
        "L": "Heart-eye vibes. There is a strong romantic spark here.",
        "A": "Soft and sweet. Care, attention, and admiration lead the way.",
        "M": "Serious intentions. The connection points toward long-term commitment.",
        "E": "Spicy tension. You challenge each other more than you cuddle.",
        "S": "Family-like energy. Comfortable, loyal, and a little teasing."
    ]

    // Rich accent color per FLAMES letter
    static let flameColors: [String: Color] = [
        "F": Color(red: 1.00, green: 0.78, blue: 0.25),  // Amber gold
        "L": Color(red: 0.98, green: 0.27, blue: 0.52),  // Hot rose
        "A": Color(red: 0.83, green: 0.48, blue: 0.98),  // Soft orchid
        "M": Color(red: 0.40, green: 0.55, blue: 1.00),  // Royal blue
        "E": Color(red: 1.00, green: 0.42, blue: 0.18),  // Fire orange
        "S": Color(red: 0.22, green: 0.90, blue: 0.72)   // Mint teal
    ]

    static let inputAllowedCharacters = CharacterSet.letters.union(.whitespaces)
    static let historyKey = "flames.history.items"
}
