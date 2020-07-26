//
//  ParserTests.swift
//  
//
//  Created by Quentin Guidée on 04/07/2020.
//

import XCTest
@testable import SwiftCAS

final class ParserTests: XCTestCase {
    func testParseExpressionToArray() {
        let expression = Parser.array(of: "x^2.0+x+2")
        XCTAssertEqual(expression.description, ["x", "^", "2", ".", "0", "+", "x", "+", "2"].description)
    }
    
    func testReplaceDotsByDoubles() {
        var expression: [Any] = ["x", "^", "2", ".", "0", "+", "x", "+", "2"]
        Parser.replaceDotsByDoubles(&expression)
        XCTAssertEqual(expression.description, ["x", "^", 2.0, "+", "x", "+", "2"].description)
    }
    
    func testReplaceStringsByNodes() {
        var expression: [Any] = ["x", "^", 2.0, "+", "x", "+", "2"]
        Parser.replaceStringsByNodes(&expression)
        XCTAssertEqual(expression.description, [Unknown("x"), "^", 2.0, "+", Unknown("x"), "+", 2].description)
    }
    
    func testReplaceOperatorsByNodes() {
        var expression: [Any] = [Unknown("x"), "^", 2.0, "+", Unknown("x"), "+", 2]
        Parser.replaceOperatorsByNodes(&expression)
        XCTAssertEqual(expression.description, [Addition(Addition(Pow(Unknown("x"), 2.0), Unknown("x")), 2)].description)
        XCTAssertEqual((expression[0] as! Node).toString(), "x^2.0+x+2")
    }
    
    func testParser() {
        XCTAssertEqual(Parser.parse("x^2+x+2").differentiated().simplify().toString(), "x*2+1")
    }
    
    static var allTests = [
        ("testParseExpressionToArray", testParseExpressionToArray),
        ("testReplaceDotsByDoubles", testReplaceDotsByDoubles),
        ("testReplaceStringsByNodes", testReplaceStringsByNodes),
        ("testReplaceOperatorsByNodes", testReplaceOperatorsByNodes),
        ("testParser", testParser),
    ]
}
