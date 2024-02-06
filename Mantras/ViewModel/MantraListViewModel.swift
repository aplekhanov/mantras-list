import Foundation
import UIKit
import Combine

@MainActor
final class MantraListViewModel {
    
    @Published var mantras: [Mantra] = []
    
    private let dataService: MantraDataServiceProtocol
    
    init(dataService: MantraDataServiceProtocol = MantraDataService()) {
        self.dataService = dataService
        Task {
            await getMantras()
        }
    }
    
    func getMantras() async {
        if let savedMantras = await dataService.loadMantras() {
            mantras = savedMantras
        } else {
            await fetchMantras()
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
        Task {
            await dataService.save(mantras)
        }
    }
}
