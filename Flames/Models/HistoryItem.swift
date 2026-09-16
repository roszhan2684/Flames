import Foundation

struct HistoryItem: Identifiable, Codable {
    let id: UUID
    let firstName: String
    let secondName: String
    let resultLetter: String
    let resultMeaning: String
    let remainingCount: Int
    let timestamp: Date

    init(
        id: UUID = UUID(),
        firstName: String,
        secondName: String,
        resultLetter: String,
        resultMeaning: String,
        remainingCount: Int,
        timestamp: Date = Date()
    ) {
        self.id = id
        self.firstName = firstName
        self.secondName = secondName
        self.resultLetter = resultLetter
        self.resultMeaning = resultMeaning
        self.remainingCount = remainingCount
        self.timestamp = timestamp
    }
}
