import XCTest
@testable import Mantras

class MantraListViewModelTests: XCTestCase {
    func testViewModelInitializesAndLoadsMantras() async {
        let mockService = MockMantraDataService()
        mockService.mantrasToReturn = [Mantra(name: "Test", duration: 60)]
        let viewModel = await MantraListViewModel(dataService: mockService)

        await viewModel.getMantras()

        await MainActor.run {
            XCTAssertEqual(viewModel.mantras.count, 1, "Expected to load 1 mantra.")
            XCTAssertEqual(viewModel.mantras.first?.name, "Test", "The mantra's name did not match the expected value.")
        }
    }
}
