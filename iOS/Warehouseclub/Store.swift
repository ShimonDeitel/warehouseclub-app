import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    @Published var items: [ClubTrip] = []
    @Published var isPro: Bool = false

    static let freeLimit = 8

    private let fileURL: URL = {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        return dir.appendingPathComponent("warehouseclub_items.json")
    }()

    init() {
        load()
    }

    var canAddMore: Bool {
        isPro || items.count < Store.freeLimit
    }

    func add(_ item: ClubTrip) {
        items.insert(item, at: 0)
        save()
    }

    func update(_ item: ClubTrip) {
        guard let idx = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[idx] = item
        save()
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: ClubTrip) {
        items.removeAll { $0.id == item.id }
        save()
    }

    private func load() {
        if let data = try? Data(contentsOf: fileURL),
           let decoded = try? JSONDecoder().decode([ClubTrip].self, from: data) {
            items = decoded
        } else {
            items = Store.seedData
        }
    }

    func save() {
        if let data = try? JSONEncoder().encode(items) {
            try? data.write(to: fileURL, options: .atomic)
        }
    }

    static let seedData: [ClubTrip] = [
        ClubTrip(store: "Store 1", amountSaved: 10.0, tripDate: Date().addingTimeInterval(-86400), notes: "Notes 1"),
        ClubTrip(store: "Store 2", amountSaved: 20.0, tripDate: Date().addingTimeInterval(-172800), notes: "Notes 2"),
        ClubTrip(store: "Store 3", amountSaved: 30.0, tripDate: Date().addingTimeInterval(-259200), notes: "Notes 3")
    ]
}
