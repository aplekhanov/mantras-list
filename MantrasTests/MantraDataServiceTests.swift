import XCTest
@testable import Mantras

class MantraDataServiceTests: XCTestCase {
    
    var service: MantraDataService!
    var mockBundle: MockBundle!
    var mockUserDefaults: MockUserDefaults!
    let testMantras = [Mantra(name: "Test Mantra", duration: 60)]
    
    override func setUp() {
        super.setUp()
        mockBundle = MockBundle()
        mockUserDefaults = MockUserDefaults()
        service = MantraDataService(bundle: mockBundle, userDefaults: mockUserDefaults)
    }
    
    override func tearDown() {
        service = nil
        mockBundle = nil
        mockUserDefaults = nil
        super.tearDown()
    }
    
    func testFetchMantras() async throws {   
        let expectedMantraName = "Ганеша Шаранам"
        let expectedDuration = 538.0
        let expectedMantrasCount = 6

        let mantras = try await service.fetchMantras()
        
        XCTAssertFalse(mantras.isEmpty, "Mantras list should not be empty.")
        XCTAssertEqual(mantras.count, expectedMantrasCount, "Mantras list should contain \(expectedMantrasCount) items.")
        XCTAssertEqual(mantras.first?.name, expectedMantraName, "The first mantra name should match the expected value.")
        XCTAssertEqual(mantras.first?.duration, expectedDuration, "The first mantra duration should match the expected value.")
    }
    
    func testFetchMantrasThrowsErrorWhenPlistNotFound() async throws {
        let service = MantraDataService(bundle: MockBundleFailing(), userDefaults: MockUserDefaults())
        
        do {
            let _ = try await service.fetchMantras()
            XCTFail("fetchMantras() should have thrown an error when the plist is not found.")
        } catch {
            guard let error = error as NSError? else {
                XCTFail("Error should be of type NSError")
                return
            }
            XCTAssertEqual(error.domain, "MantraService", "Error domain should match expected value.")
            XCTAssertEqual(error.code, 100, "Error code should match expected value.")
        }
    }
    
    func testSaveMantras() async {
        await service.save(testMantras)
        
        guard let savedData = mockUserDefaults.store[MantraDataService.saveDefaultsKey] as? Data else {
            XCTFail("Mantras data not saved")
            return
        }
        let savedMantras = try? JSONDecoder().decode([Mantra].self, from: savedData)
        
        XCTAssertNotNil(savedMantras, "Saved mantras should not be nil.")
        XCTAssertEqual(savedMantras, testMantras, "Saved mantras should match the test mantras.")
    }

    func testLoadMantras() async {
        let data = try! JSONEncoder().encode(testMantras)
        mockUserDefaults.store[MantraDataService.saveDefaultsKey] = data

        let loadedMantras = await service.loadMantras()
        
        XCTAssertNotNil(loadedMantras, "Loaded mantras should not be nil.")
        XCTAssertEqual(loadedMantras?.first?.name, testMantras.first?.name, "The loaded mantra name should match the expected value.")
        XCTAssertEqual(loadedMantras?.first?.duration, testMantras.first?.duration, "The loaded mantra duration should match the expected value.")
    }
}
