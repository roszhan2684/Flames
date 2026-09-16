import Foundation
import Combine

@MainActor
final class HistoryViewModel: ObservableObject {
    @Published private(set) var items: [HistoryItem] = []

    private let storage = HistoryStorage()

    init() {
        load()
    }

    func load() {
        items = storage.load()
    }

    func delete(at offsets: IndexSet) {
        let ids = offsets.compactMap { items[$0].id }
        ids.forEach { storage.delete(id: $0) }
        load()
    }

    func clearAll() {
        storage.clear()
        load()
    }
}
