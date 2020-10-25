import Foundation
import UIKit

public protocol Initializable {
    static var identifier: String { get }
}

extension UIViewController: Initializable {
    public static var identifier: String {
       String(describing: Self.self)
   }
}

public extension UIViewController {

    static func initializeFromMainStoryboard<T: Initializable>() -> T {
        let storyboard: UIStoryboard = .main

        guard let viewController = storyboard.instantiateViewController(withIdentifier: Self.identifier) as? T else {
            fatalError("Could not instantiate \(Self.identifier)")
        }

        return viewController
    }
}
