import UIKit

final class MainViewController: UIViewController, Coordinating {
    
    var coordinator: MainCoordinator?
    
    private let customView = MainView()

    override func loadView() {
        super.loadView()
        
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButtonActions()
    }
    
    private func addButtonActions() {
        // For more complex structure, use view model
        let openMantraAction = UIAction() { [weak self] _ in
            self?.coordinator?.openMantraList()
        }
        customView.openButton.addAction(openMantraAction, for: .touchUpInside)
    }
}
