import Foundation

struct FlamesCalculator {
    func calculate(firstName: String, secondName: String) -> FlamesResult {
        let normalizedFirst = firstName.normalizedName
        let normalizedSecond = secondName.normalizedName

        let removalResult = removeCommonLetters(first: normalizedFirst, second: normalizedSecond)
        let remainingCountRaw = removalResult.remainingFirst.count + removalResult.remainingSecond.count

        let resultLetter: String
        let remainingCount: Int

        if remainingCountRaw == 0 {
            // If all letters cancel out, use F and display a 0 count.
            resultLetter = "F"
            remainingCount = 0
        } else {
            resultLetter = eliminateFlames(count: remainingCountRaw)
            remainingCount = remainingCountRaw
        }

        let meaning = AppConstants.flameMeanings[resultLetter] ?? ""
        let description = AppConstants.flameDescriptions[resultLetter] ?? ""

        return FlamesResult(
            originalFirstName: firstName,
            originalSecondName: secondName,
            normalizedFirstName: normalizedFirst,
            normalizedSecondName: normalizedSecond,
            remainingCount: remainingCount,
            removedLettersSummary: removalResult.removedSummary,
            resultLetter: resultLetter,
            resultMeaning: meaning,
            resultDescription: description
        )
    }

    private func eliminateFlames(count: Int) -> String {
        var flames: [String] = ["F", "L", "A", "M", "E", "S"]
        var index = 0

        while flames.count > 1 {
            index = (index + count - 1) % flames.count
            flames.remove(at: index)
        }

        return flames[0]
    }

    // Removes matching letters using frequency-based pairing, not just unique sets.
    private func removeCommonLetters(first: String, second: String) -> RemovalResult {
        var firstArray = Array(first)
        var secondArray = Array(second)

        var secondCounts: [Character: Int] = [:]
        for char in secondArray {
            secondCounts[char, default: 0] += 1
        }

        var removedFromFirst: [Character] = []
        var remainingFirst: [Character] = []

        for char in firstArray {
            if let available = secondCounts[char], available > 0 {
                removedFromFirst.append(char)
                secondCounts[char] = available - 1
            } else {
                remainingFirst.append(char)
            }
        }

        var firstCounts: [Character: Int] = [:]
        for char in firstArray {
            firstCounts[char, default: 0] += 1
        }

        var removedFromSecond: [Character] = []
        var remainingSecond: [Character] = []

        for char in secondArray {
            if let available = firstCounts[char], available > 0 {
                removedFromSecond.append(char)
                firstCounts[char] = available - 1
            } else {
                remainingSecond.append(char)
            }
        }

        let removedSummary = removedSummaryText(removedFromFirst: removedFromFirst, removedFromSecond: removedFromSecond)
        return RemovalResult(
            remainingFirst: remainingFirst,
            remainingSecond: remainingSecond,
            removedSummary: removedSummary
        )
    }

    private func removedSummaryText(removedFromFirst: [Character], removedFromSecond: [Character]) -> String {
        let totalRemoved = removedFromFirst.count + removedFromSecond.count
        if totalRemoved == 0 {
            return "No common letters removed"
        }

        let display = (removedFromFirst + removedFromSecond)
            .map { String($0).uppercased() }
            .joined(separator: " ")

        return "Removed: \(display)"
    }

    private struct RemovalResult {
        let remainingFirst: [Character]
        let remainingSecond: [Character]
        let removedSummary: String
    }
}
