import UIKit

protocol Coordinator {
    associatedtype VC: UIViewController
    var rootViewController: VC { get }
    func start()
}

protocol Coordinating {
    associatedtype C: Coordinator
    var coordinator: C? { get set }
}
