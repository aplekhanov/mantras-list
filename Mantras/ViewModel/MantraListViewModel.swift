import Foundation
import UIKit
import Combine

@MainActor
final class MantraListViewModel {
    
    @Published var mantras: [Mantra] = []
    
    private let dataService: MantraDataServiceProtocol
    
    init(dataService: MantraDataServiceProtocol = MantraDataService()) {
        self.dataService = dataService
        getMantras()
    }
    
    func getMantras() {
        if let savedMantras = dataService.loadMantras() {
            mantras = savedMantras
        } else {
            Task { await fetchMantras() }
        }
    }
    
    func fetchMantras() async {
        do {
            mantras = try await dataService.fetchMantras()
        } catch {
            assertionFailure("Error fetching mantras: \(error.localizedDescription)")
        }
    }
    
    func shuffleMantras() {
        mantras.shuffle()
        dataService.save(mantras)
    }
}
