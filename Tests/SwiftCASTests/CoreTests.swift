import XCTest
@testable import SwiftCAS

final class CoreTests: XCTestCase {
    func testInt() {
        XCTAssertEqual(3.toString(), "3")
        XCTAssertEqual(3.toLaTeX(), "3")
        XCTAssertEqual(3.isNatural(), true)
        XCTAssertEqual(0.isNatural(), true)
        XCTAssertEqual((-3).isNatural(), false)
    }
    
    func testDouble() {
        XCTAssertEqual(3.0.toString(), "3.0")
        XCTAssertEqual(3.0.toLaTeX(), "3.0")
    }
    
    func testInfinity() {
        XCTAssertEqual(Infinity().toString(), "∞")
        XCTAssertEqual(Infinity().toLaTeX(), "\\infty")
    }
    
    func testConstant() {
        XCTAssertEqual(Constant("π").toString(), "π")
        XCTAssertEqual(Constant("π").toLaTeX(), "\\pi")
        XCTAssertEqual(Constant("e").toString(), "e")
        XCTAssertEqual(Constant("e").toLaTeX(), "e")
    }
    
    func testNode() {
        XCTAssertEqual(Addition(1, 2).toString(), "1+2")
        XCTAssertEqual(Addition([1, 2]).toString(), "1+2")
    }
    
    func testAddition() {
        XCTAssertEqual(Addition(32, 2).toString(), "32+2")
        XCTAssertEqual(Addition(32, 2.0).toString(), "32+2.0")
        XCTAssertEqual(Addition(32, 2).toLaTeX(), "32+2")
        XCTAssertEqual(Addition(32, 2.0).toLaTeX(), "32+2.0")
        XCTAssertEqual(Addition(Addition(1, 2), 3).simplify().toString(), "3+1+2")
        XCTAssertEqual(Addition(Addition(0, 2), 3).simplify().toString(), "3+2")
    }
    
    func testMultiplication() {
        XCTAssertEqual(Multiplication(32, 2).toString(), "32*2")
        XCTAssertEqual(Multiplication(32, 2.0).toString(), "32*2.0")
        XCTAssertEqual(Multiplication(32, 2).toLaTeX(), "32*2")
        XCTAssertEqual(Multiplication(32, 2.0).toLaTeX(), "32*2.0")
        XCTAssertEqual(Multiplication(Multiplication(1, 2), 3).simplify().toString(), "3*2")
        XCTAssertEqual(Multiplication(Multiplication(0, 2), 3).simplify().toString(), "0")
    }
    
    func testDivision() {
        XCTAssertEqual(Division(32, 2).toString(), "32/2")
        XCTAssertEqual(Division(32, 2.0).toString(), "32/2.0")
        XCTAssertEqual(Division(32, 2).toLaTeX(), "\\frac{32}{2}")
        XCTAssertEqual(Division(32, 2.0).toLaTeX(), "\\frac{32}{2.0}")
        XCTAssertEqual(Division(3, 2).numerator.toString(), "3")
        XCTAssertEqual(Division(3, 2).denominator.toString(), "2")
        XCTAssertEqual(Division(3, 2).dividend.toString(), "3")
        XCTAssertEqual(Division(3, 2).divisor.toString(), "2")
        XCTAssertEqual(Division(3, 1).simplify().toString(), "3")
        XCTAssertEqual(Division(3, 1.0).simplify().toString(), "3")
    }
    
    func testPow() {
        XCTAssertEqual(Pow(11, 2).toString(), "11^2")
        XCTAssertEqual(Pow(11, 2.0).toString(), "11^2.0")
        XCTAssertEqual(Pow(11, 2).toLaTeX(), "{11}^{2}")
        XCTAssertEqual(Pow(11, 2.0).toLaTeX(), "{11}^{2.0}")
        XCTAssertEqual(Pow(11, 2).base.toString(), "11")
        XCTAssertEqual(Pow(11, 2).power.toString(), "2")
        XCTAssertEqual(Pow(1, Multiplication(3, 4, 5)).simplify().toString(), "1")
        XCTAssertEqual(Pow(Multiplication(3, 1, 5), 1).simplify().toString(), "3*1*5")
        XCTAssertEqual(Pow(Pow(1, 2), 3).simplify().toString(), "1^2*3")
        XCTAssertEqual(Pow(Multiplication(1, 2), 3).simplify().toString(), "1^3*2^3")
        XCTAssertEqual(Pow(Multiplication(1, 2, 4), 3).simplify().toString(), "1^3*2^3*4^3")
    }

    static var allTests = [
        ("testInt", testInt),
        ("testDouble", testDouble),
        ("testInfinity", testInfinity),
        ("testConstant", testConstant),
        ("testNode", testNode),
        ("testAddition", testAddition),
        ("testMultiplication", testMultiplication),
        ("testDivision", testDivision),
        ("testPow", testPow),
    ]
}
