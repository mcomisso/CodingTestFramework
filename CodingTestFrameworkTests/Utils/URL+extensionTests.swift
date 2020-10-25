import Foundation
import XCTest

class URLExtensionsTests: XCTestCase {

    func testURLfromString() throws {
        let url: URL = "https://google.com"
        XCTAssertEqual(url.absoluteString, "https://google.com")
    }

}
