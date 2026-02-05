import Foundation
import Combine

final class MainViewModel: ObservableObject {
    @Published var user: User? = nil
    @Published var cars: [Car] = []
    @Published var earnings: [Earning] = []

    private var cancellables = Set<AnyCancellable>()

    init() {
        loadSampleData()
    }

    private func loadSampleData() {
        user = User(name: "Demo User", email: "demo@example.com")
        cars = [Car(make: "Toyota", model: "Prius", year: 2018, nickname: "Work Car")]
        earnings = [Earning(amount: 120.0, date: Date(), notes: "Rideshare")]
    }
}
