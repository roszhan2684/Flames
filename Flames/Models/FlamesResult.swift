import Foundation

struct FlamesResult: Identifiable, Codable {
    let id: UUID
    let originalFirstName: String
    let originalSecondName: String
    let normalizedFirstName: String
    let normalizedSecondName: String
    let remainingCount: Int
    let removedLettersSummary: String
    let resultLetter: String
    let resultMeaning: String
    let resultDescription: String
    let timestamp: Date

    init(
        id: UUID = UUID(),
        originalFirstName: String,
        originalSecondName: String,
        normalizedFirstName: String,
        normalizedSecondName: String,
        remainingCount: Int,
        removedLettersSummary: String,
        resultLetter: String,
        resultMeaning: String,
        resultDescription: String,
        timestamp: Date = Date()
    ) {
        self.id = id
        self.originalFirstName = originalFirstName
        self.originalSecondName = originalSecondName
        self.normalizedFirstName = normalizedFirstName
        self.normalizedSecondName = normalizedSecondName
        self.remainingCount = remainingCount
        self.removedLettersSummary = removedLettersSummary
        self.resultLetter = resultLetter
        self.resultMeaning = resultMeaning
        self.resultDescription = resultDescription
        self.timestamp = timestamp
    }
}
