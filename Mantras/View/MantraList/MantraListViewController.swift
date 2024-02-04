import UIKit
import Combine

final class MantraListViewController: UIViewController {
    
    private let customView = MantraListView()
    private let viewModel: MantraListViewModel
    private var dataSource: UITableViewDiffableDataSource<Section, Mantra>!
    private var cancellables = Set<AnyCancellable>()
    
    enum Section {
        case main
    }
    
    init(_ viewModel: MantraListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        bindViewModel()
        addButtonActions()
    }

    private func configureTableView() {
        customView.tableView.delegate = self
        
        dataSource = UITableViewDiffableDataSource<Section, Mantra>(tableView: customView.tableView) { (tableView, indexPath, mantra) -> UITableViewCell? in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MantraTableViewCell.identifier, for: indexPath) as? MantraTableViewCell 
            else {
                return nil
            }
            cell.configure(with: mantra)
            return cell
        }
    }
    
    private func bindViewModel() {
        viewModel.$mantras
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.applySnapshot()
            }.store(in: &cancellables)
    }
    
    private func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Mantra>()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.mantras, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    private func addButtonActions() {
        let shuffleMantrasAction = UIAction() { [weak self] _ in
            self?.viewModel.shuffleMantras()
        }
        customView.shuffleButton.addAction(shuffleMantrasAction, for: .touchUpInside)
    }
}

extension MantraListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        62.0 + 8.0 // main height + spacing
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        debugPrint("Selected row at \(indexPath)")
    }
}
