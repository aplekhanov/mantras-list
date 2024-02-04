import Foundation
@testable import Mantras

final class MockBundle: BundleProtocol {
    func url(forResource name: String?, withExtension ext: String?) -> URL? {
        return Bundle(for: type(of: self)).url(forResource: name, withExtension: ext)
    }
}

final class MockBundleFailing: BundleProtocol {
    func url(forResource name: String?, withExtension ext: String?) -> URL? {
        return nil // Simulate plist file not found
    }
}

final class MockUserDefaults: UserDefaultsProtocol {
    var store = [String: Any]()
    
    func data(forKey defaultName: String) -> Data? {
        return store[defaultName] as? Data
    }
    
    func set(_ value: Any?, forKey defaultName: String) {
        store[defaultName] = value
    }
}

final class MockMantraDataService: MantraDataServiceProtocol {
    var mantrasToReturn: [Mantra]?

    func fetchMantras() async throws -> [Mantra] {
        return mantrasToReturn ?? []
    }
    
    func save(_ mantras: [Mantra]) {
        // Implement save logic if needed for tests
    }

    func loadMantras() -> [Mantra]? {
        return mantrasToReturn
    }
}
