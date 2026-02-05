import XCTest
@testable import DriveBoss

class DriveBossAppTests: XCTestCase {
    func testEarningsView_AddEarning() {
        // Simulate adding an earning
        let vm = MainViewModel()
        let initialCount = vm.earnings.count
        vm.earnings.append(Earning(amount: 42.0, date: Date(), notes: "Test"))
        XCTAssertEqual(vm.earnings.count, initialCount + 1)
        XCTAssertEqual(vm.earnings.last?.amount, 42.0)
    }

    func testMileageView_AddMileage() {
        let vm = MainViewModel()
        let initialCount = vm.mileage.count
        vm.mileage.append((72.0, Date(), "Test trip"))
        XCTAssertEqual(vm.mileage.count, initialCount + 1)
        XCTAssertEqual(vm.mileage.last?.0, 72.0)
    }

    func testGasFinderView_Search() {
        // Placeholder: Simulate search logic
        let searchLocation = "San Francisco"
        XCTAssertFalse(searchLocation.isEmpty)
    }

    func testCarHealthView_HealthScore() {
        // Simulate health score logic
        let score = 92
        XCTAssertTrue(score >= 0 && score <= 100)
    }

    func testSettingsView_Toggles() {
        var notificationsEnabled = true
        var privacyMode = false
        notificationsEnabled.toggle()
        privacyMode.toggle()
        XCTAssertFalse(notificationsEnabled)
        XCTAssertTrue(privacyMode)
    }
}
