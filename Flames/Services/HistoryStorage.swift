import Foundation

struct HistoryStorage {
    private let defaults = UserDefaults.standard

    func load() -> [HistoryItem] {
        guard let data = defaults.data(forKey: AppConstants.historyKey) else {
            return []
        }
        let decoder = JSONDecoder()
        return (try? decoder.decode([HistoryItem].self, from: data)) ?? []
    }

    func save(result: FlamesResult) {
        var items = load()
        let newItem = HistoryItem(
            firstName: result.originalFirstName,
            secondName: result.originalSecondName,
            resultLetter: result.resultLetter,
            resultMeaning: result.resultMeaning,
            remainingCount: result.remainingCount,
            timestamp: result.timestamp
        )
        items.insert(newItem, at: 0)
        persist(items)
    }

    func delete(id: UUID) {
        var items = load()
        items.removeAll { $0.id == id }
        persist(items)
    }

    func clear() {
        defaults.removeObject(forKey: AppConstants.historyKey)
    }

    private func persist(_ items: [HistoryItem]) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(items) {
            defaults.set(data, forKey: AppConstants.historyKey)
        }
    }
}
