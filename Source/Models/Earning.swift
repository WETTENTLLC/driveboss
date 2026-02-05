import Foundation

struct Earning: Codable, Identifiable {
    var id: UUID = UUID()
    var amount: Double
    var date: Date
    var notes: String?
}
