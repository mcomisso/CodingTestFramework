import Foundation

protocol ViewModel {
    associatedtype State
    associatedtype Intent

    var onStateChanged: ((State) -> Void)? { get set }
    var state: State { get set }

    func perform(intent: Intent)
}
