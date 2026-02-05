import Foundation

struct Car: Codable, Identifiable {
    var id: UUID = UUID()
    var make: String
    var model: String
    var year: Int
    var nickname: String?
}
