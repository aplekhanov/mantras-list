import Foundation

// Using protocols for mocking in the tests

protocol MantraDataServiceProtocol {
    func fetchMantras() async throws -> [Mantra]
    func save(_ mantras: [Mantra])
    func loadMantras() -> [Mantra]?
}

protocol BundleProtocol {
    func url(forResource name: String?, withExtension ext: String?) -> URL?
}

extension Bundle: BundleProtocol {}

protocol UserDefaultsProtocol {
    func set(_ value: Any?, forKey defaultName: String)
    func data(forKey defaultName: String) -> Data?
}

extension UserDefaults: UserDefaultsProtocol {}


final class MantraDataService: MantraDataServiceProtocol {
    
    static let saveDefaultsKey = "mantraListSaveDefaultsKey"
    
    private let bundle: BundleProtocol
    private let userDefaults: UserDefaultsProtocol
    
    init(bundle: BundleProtocol = Bundle.main, userDefaults: UserDefaultsProtocol = UserDefaults.standard) {
        self.bundle = bundle
        self.userDefaults = userDefaults
    }

    func fetchMantras() async throws -> [Mantra] {
        guard let url = bundle.url(forResource: "Mantras", withExtension: "plist"),
              let data = try? Data(contentsOf: url)
        else {
            throw NSError(domain: "MantraService", code: 100,
                          userInfo: [NSLocalizedDescriptionKey: "Unable to load Mantras.plist"])
        }
        let decoder = PropertyListDecoder()
        let fetchedMantras = try decoder.decode([MantraDTO].self, from: data)
        let mantras = fetchedMantras.map { Mantra(name: $0.name, duration: $0.duration) }
        return mantras
    }
    
    func save(_ mantras: [Mantra]) {
        let data = try? JSONEncoder().encode(mantras)
        userDefaults.set(data, forKey: MantraDataService.saveDefaultsKey)
    }
    
    func loadMantras() -> [Mantra]? {
        guard let data = userDefaults.data(forKey: MantraDataService.saveDefaultsKey) else { return nil }
        return try? JSONDecoder().decode([Mantra].self, from: data)
    }
}
