import XCTest
@testable import SwiftCAS

final class CoreTests: XCTestCase {
    func testInt() {
        XCTAssertEqual(3.toString(), "3")
        XCTAssertEqual(3.toLaTeX(), "3")
    }
    
    func testDouble() {
        XCTAssertEqual(3.0.toString(), "3.0")
        XCTAssertEqual(3.0.toLaTeX(), "3.0")
    }
    
    func testAddition() {
        XCTAssertEqual(Addition([32, 2]).toString(), "32+2")
        XCTAssertEqual(Addition([32, 2.0]).toString(), "32+2.0")
        XCTAssertEqual(Addition([32, 2]).toLaTeX(), "32+2")
        XCTAssertEqual(Addition([32, 2.0]).toLaTeX(), "32+2.0")
    }

    static var allTests = [
        ("testInt", testInt),
        ("testDouble", testDouble),
    ]
}
