import Foundation
import UIKit


public protocol AppTerminationObservable: AnyObject {
    func observeForAppTermination(_ notificationCenter: NotificationCenterType)
}

public extension AppTerminationObservable where Self: AppTerminationObserved {

    func observeForAppTermination(_ notificationCenter: NotificationCenterType) {
        notificationCenter.addObserver(self, selector: #selector(self.onAppTermination),
                                       name: UIApplication.willTerminateNotification, object: nil)
    }
}

@objc public protocol AppTerminationObserved: AnyObject {
    @objc func onAppTermination()
}

public typealias AppTerminationObserving = AppTerminationObservable & AppTerminationObserved
