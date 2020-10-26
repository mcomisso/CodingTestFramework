#if canImport(UIKit)

import Foundation
import UIKit

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension UITableViewCell: Reusable {
    static var reuseIdentifier: String { String(describing: Self.self) }
}

extension UITableView {
    func registerNib<Cell: Reusable>(_ cell: Cell.Type) {
        let nib = UINib(nibName: cell.reuseIdentifier, bundle: nil)
        register(nib, forCellReuseIdentifier: cell.reuseIdentifier)
    }

    func dequeue<Cell: Reusable>(for indexPath: IndexPath) -> Cell {
        let identifier = String(describing: Cell.self)
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? Cell else {
            fatalError("Could not dequeue \(identifier)")
        }
        return cell
    }

}

#endif
