import Foundation

#if canImport(UIKit)

import UIKit

public protocol Coordinator: AnyObject {
    var childCoordinators: [String: Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}

#endif
