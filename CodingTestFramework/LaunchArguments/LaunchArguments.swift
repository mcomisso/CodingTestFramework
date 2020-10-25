import Foundation

public enum LaunchArgument: String {
    case uiTestEnabled = "-UITestEnabled"
}

public extension String {
    static let uiTestEnabled: String = LaunchArgument.uiTestEnabled.rawValue
}
