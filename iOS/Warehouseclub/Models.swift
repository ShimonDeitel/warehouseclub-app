import Foundation

struct ClubTrip: Identifiable, Codable, Equatable {
    let id: UUID
    var createdAt: Date
    var store: String
    var amountSaved: Double
    var tripDate: Date
    var notes: String

    init(
        id: UUID = UUID(),
        createdAt: Date = Date(),
        store: String = "",
        amountSaved: Double = 0,
        tripDate: Date = Date(),
        notes: String = ""
    ) {
        self.id = id
        self.createdAt = createdAt
        self.store = store
        self.amountSaved = amountSaved
        self.tripDate = tripDate
        self.notes = notes
    }
}
