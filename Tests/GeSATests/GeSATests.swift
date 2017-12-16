import XCTest
@testable import GeSA

class GeSATests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(GeSA().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
