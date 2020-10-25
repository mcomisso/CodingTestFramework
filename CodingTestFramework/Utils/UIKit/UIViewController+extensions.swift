import Foundation
import UIKit

extension UIViewController {

    func showAcknowledgemntAlert(title: String, message: String = "", actionTitle: String = "Ok") {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: actionTitle, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
