import UIKit

final class MainCoordinator: Coordinator {
    
    private(set) var rootViewController: MainViewController
    private let window: UIWindow
     
    init(_ window: UIWindow) {
        self.window = window
        self.rootViewController = MainViewController()
        self.rootViewController.coordinator = self
    }
    
    func start() {
        window.backgroundColor = .mainBackground
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
    @MainActor func openMantraList() {
        let viewModel = MantraListViewModel()
        let viewController = MantraListViewController(viewModel)
        rootViewController.present(viewController, animated: true)
    }
}
