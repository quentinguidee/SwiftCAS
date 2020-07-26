//
//  ParserTests.swift
//  
//
//  Created by Quentin Guidée on 04/07/2020.
//

import XCTest
@testable import SwiftCAS

final class ParserTests: XCTestCase {
    func testParser() {
        XCTAssertEqual(Parser.parse("x^2+x+2").differentiated().simplify().toString(), "x*2+1")
        XCTAssertEqual(Parser.parse("((x^2)+3)+30.0").toString(), "x^2+3+30.0")
        XCTAssertEqual(Parser.parse("a^b^c").toLaTeX(), "{a}^{{b}^{c}}")
    }
    
    static var allTests = [
        ("testParser", testParser),
    ]
}
