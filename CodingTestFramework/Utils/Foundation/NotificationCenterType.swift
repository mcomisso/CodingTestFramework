import Foundation

public protocol NotificationCenterType {
    //MARK: - Add Observers
    func addObserver(forName: NSNotification.Name?, object: Any?, queue: OperationQueue?, using: @escaping (Notification) -> Void) -> NSObjectProtocol

    func addObserver(_ observer: Any, selector aSelector: Selector, name aName: NSNotification.Name?, object anObject: Any?)

    //MARK: - Remove Observers
    func removeObserver(_ observer: Any)
    func removeObserver(_ observer: Any, name: NSNotification.Name?, object: Any?)
}

extension NotificationCenter: NotificationCenterType {}
