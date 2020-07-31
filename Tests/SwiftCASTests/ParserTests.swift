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
        XCTAssertEqual(Parser.parse("x^2+x+2").differentiated().simplified().toString(), "2*x+1")
        XCTAssertEqual(Parser.parse("((x^2)+3)+30.0").toString(), "x^2+3+30.0")
        XCTAssertEqual(Parser.parse("a^b^c").toLaTeX(), "{a}^{{b}^{c}}")
        XCTAssertEqual(Parser.parse("sin(x^2)").toLaTeX(), "\\sin{({x}^{2})}")
        XCTAssertEqual(Parser.parse("factorial(4)").simplified().toString(), "24")
        XCTAssertEqual(Parser.parse("fact(4)").simplified().toString(), "24")
        XCTAssertEqual(Parser.parse("4!").simplified().toLaTeX(), "24")
        XCTAssertEqual(Parser.parse("√x").simplified().toLaTeX(), "{x}^{\\frac{1}{2}}")
        XCTAssertEqual(Parser.parse("∞").toString(), "∞")
        XCTAssertEqual(Parser.parse("inf").toString(), "∞")
        XCTAssertEqual(Parser.parse("infty").toString(), "∞")
        XCTAssertEqual(Parser.parse("infinity").toString(), "∞")
    }
    
    static var allTests = [
        ("testParser", testParser),
    ]
}
