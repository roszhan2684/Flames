import Foundation
import Combine

@MainActor
final class FlamesViewModel: ObservableObject {
    @Published var firstName: String = ""
    @Published var secondName: String = ""
    @Published var errorMessage: String = ""
    @Published var result: FlamesResult?
    @Published var isShowingResult: Bool = false

    private let calculator = FlamesCalculator()
    private let historyStorage = HistoryStorage()

    func validateInputs() -> Bool {
        errorMessage = ""

        if firstName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            secondName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errorMessage = "Please enter both names."
            return false
        }

        if !firstName.containsOnlyAllowedNameCharacters || !secondName.containsOnlyAllowedNameCharacters {
            errorMessage = "Names can only contain letters and spaces."
            return false
        }

        return true
    }

    func calculateResult() {
        guard validateInputs() else { return }

        let computed = calculator.calculate(firstName: firstName, secondName: secondName)
        result = computed
        historyStorage.save(result: computed)
        isShowingResult = true
    }

    func resetForNew() {
        isShowingResult = false
        result = nil
        firstName = ""
        secondName = ""
        errorMessage = ""
    }

    var shareText: String {
        guard let result else { return "" }
        return "\(AppConstants.appTitle) result for \(result.originalFirstName) + \(result.originalSecondName): \(result.resultLetter) = \(result.resultMeaning)."
    }
}
