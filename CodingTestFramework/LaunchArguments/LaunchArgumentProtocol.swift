import Foundation

public protocol LaunchArgumentProtocol {
    static func wasLaunched(_ argument: LaunchArgument) -> Bool
}

public extension LaunchArgumentProtocol {
    static func wasLaunched(_ argument: LaunchArgument) -> Bool {
        ProcessInfo.processInfo
            .arguments
            .contains(argument.rawValue)
    }
}

public struct LaunchArgumentReader: LaunchArgumentProtocol { }
