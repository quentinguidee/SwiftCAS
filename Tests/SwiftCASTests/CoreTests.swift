import XCTest
@testable import SwiftCAS

final class CoreTests: XCTestCase {
    func testInt() {
        XCTAssertEqual(3.toString(), "3")
        XCTAssertEqual(3.toLaTeX(), "3")
        XCTAssertEqual(3.isNatural(), true)
        XCTAssertEqual(0.isNatural(), true)
        XCTAssertEqual((-3).isNatural(), false)
        XCTAssertEqual(3.opposite() as! Int, -3)
        XCTAssertEqual((-3).absoluteValue() as! Int, 3)
        XCTAssertEqual((-3).sign, Sign.Negative)
        XCTAssertEqual(0.sign, Sign.Signless)
        XCTAssertEqual(3.sign, Sign.Positive)
        XCTAssertEqual(0.isEven(), true)
        XCTAssertEqual(1.isEven(), false)
        XCTAssertEqual(2.isEven(), true)
        XCTAssertEqual(3.isEven(), false)
        XCTAssertEqual(0.isOdd(), false)
        XCTAssertEqual(1.isOdd(), true)
        XCTAssertEqual(2.isOdd(), false)
        XCTAssertEqual(3.isOdd(), true)
        XCTAssertEqual(3.isNull(), false)
        XCTAssertEqual(0.isNull(), true)
        XCTAssertEqual(3.differentiate().toString(), "0")
        XCTAssertEqual(3.differentiate(of: Unknown("y")).toString(), "0")
        XCTAssertEqual(3.integrate().toString(), "3*x")
        XCTAssertEqual(3.integrate(of: Unknown("y")).toString(), "3*y")
    }
    
    func testDouble() {
        XCTAssertEqual(3.0.toString(), "3.0")
        XCTAssertEqual(3.0.toLaTeX(), "3.0")
        XCTAssertEqual((-3.2).sign, Sign.Negative)
        XCTAssertEqual(0.0.sign, Sign.Signless)
        XCTAssertEqual(3.2.sign, Sign.Positive)
        XCTAssertEqual((-3.0).absoluteValue() as! Double, 3.0)
        XCTAssertEqual(3.0.opposite() as! Double, -3.0)
        XCTAssertEqual(3.2.isNull(), false)
        XCTAssertEqual(0.0.isNull(), true)
        XCTAssertEqual(3.2.differentiate().toString(), "0")
        XCTAssertEqual(3.2.differentiate(of: Unknown("y")).toString(), "0")
        XCTAssertEqual(3.2.integrate().toString(), "3.2*x")
        XCTAssertEqual(3.2.integrate(of: Unknown("y")).toString(), "3.2*y")
    }
    
    func testInfinity() {
        XCTAssertEqual(Infinity().toString(), "∞")
        XCTAssertEqual(Infinity().toLaTeX(), "\\infty")
        XCTAssertEqual(Infinity().sign, Sign.Positive)
        XCTAssertEqual(Infinity().absoluteValue().toString(), "∞")
        XCTAssertEqual(Infinity().differentiate(of: Unknown("y")).toString(), "0")
        XCTAssertEqual(Infinity().integrate(of: Unknown("y")).toString(), "∞")
    }
    
    func testConstant() {
        XCTAssertEqual(Constant("π").toString(), "π")
        XCTAssertEqual(Constant("π").toLaTeX(), "\\pi")
        XCTAssertEqual(Constant("e").toString(), "e")
        XCTAssertEqual(Constant("e").toLaTeX(), "e")
        XCTAssertEqual(Constant("e").sign, Sign.Positive)
        XCTAssertEqual(Constant("e").absoluteValue().toString(), "e")
        XCTAssertEqual(Constant("e").differentiate(of: Unknown("y")).toString(), "0")
        XCTAssertEqual(Constant("e").integrate(of: Unknown("y")).toString(), "e*y")
    }
    
    func testUnknown() {
        XCTAssertEqual(Unknown().toString(), "x")
        XCTAssertEqual(Unknown("x").toString(), "x")
        XCTAssertEqual(Unknown("y").toString(), "y")
        XCTAssertEqual(Unknown("x").toLaTeX(), "x")
        XCTAssertEqual(Unknown("x").absoluteValue().toString(), "|x|")
        XCTAssertEqual(Unknown("x").differentiate().toString(), "1")
        XCTAssertEqual(Unknown("x").differentiate(of: Unknown("y")).toString(), "0")
        XCTAssertEqual(Unknown("x").integrate().toString(), "x^2/2")
        XCTAssertEqual(Unknown("x").integrate(of: Unknown("y")).toString(), "x*y")
    }
    
    func testMultiNodesOperator() {
        XCTAssertEqual(Addition(1, 2).toString(), "1+2")
        XCTAssertEqual(Addition([1, 2]).toString(), "1+2")
    }
    
    func testAddition() {
        XCTAssertEqual(Addition(32, 2).toString(), "32+2")
        XCTAssertEqual(Addition(32, 2.0).toString(), "32+2.0")
        XCTAssertEqual(Addition(32, 2).toLaTeX(), "32+2")
        XCTAssertEqual(Addition(32, 2.0).toLaTeX(), "32+2.0")
        XCTAssertEqual(Addition(Addition(1, 2), 3).simplify().toString(), "6")
        XCTAssertEqual(Addition(Addition(0, 2), 3).simplify().toString(), "5")
        XCTAssertEqual(Addition(Addition(1, 2), 3).differentiate().toString(), "0+0+0")
        XCTAssertEqual(Addition(1, 2, 3).differentiate().toString(), "0+0+0")
        XCTAssertEqual(Addition(Unknown(), 2, 3).differentiate().toString(), "1+0+0")
        XCTAssertEqual(Addition(Addition(1, 2), 3).integrate().toString(), "1*x+2*x+3*x")
        XCTAssertEqual(Addition(1, 2, 3).integrate().toString(), "1*x+2*x+3*x")
        XCTAssertEqual(Addition(Unknown(), 2, 3).integrate().toString(), "x^2/2+2*x+3*x")
    }
    
    func testMultiplication() {
        XCTAssertEqual(Multiplication(32, 2).toString(), "32*2")
        XCTAssertEqual(Multiplication(32, 2.0).toString(), "32*2.0")
        XCTAssertEqual(Multiplication(32, 2).toLaTeX(), "32*2")
        XCTAssertEqual(Multiplication(32, 2.0).toLaTeX(), "32*2.0")
        XCTAssertEqual(Multiplication(-2, 3, -4, -5.2).sign, Sign.Negative)
        XCTAssertEqual(Multiplication(0, -2, 3, -4).sign, Sign.Signless)
        XCTAssertEqual(Multiplication(1, -2, 3, 4).absoluteValue().toString(), "|1*-2*3*4|")
        XCTAssertEqual(Multiplication(Multiplication(1, 2), 3).simplify().toString(), "3*2")
        XCTAssertEqual(Multiplication(Multiplication(0, 2), 3).simplify().toString(), "0")
        XCTAssertEqual(Multiplication(Multiplication(1, 2), 3).differentiate().toString(), "d/dx(1*2*3)")
        XCTAssertEqual(Multiplication(Multiplication(1, 2), 3).integrate().toString(), "∫1*2*3 dx")
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
        XCTAssertEqual(Division(3, 2).sign, Sign.Positive)
        XCTAssertEqual(Division(0, 2).sign, Sign.Signless)
        XCTAssertEqual(Division(-1, 2).sign, Sign.Negative)
        XCTAssertEqual(Division(-1, -2).sign, Sign.Positive)
        XCTAssertEqual(Division(3, 1).simplify().toString(), "3")
        XCTAssertEqual(Division(3, Multiplication(1, 2)).simplify().toString(), "3/2")
        XCTAssertEqual(Division(3, 1.0).simplify().toString(), "3")
        XCTAssertEqual(Division(1, -2).absoluteValue().toString(), "|1/-2|")
        XCTAssertEqual(Division(1, 2).differentiate().toString(), "d/dx(1/2)")
        XCTAssertEqual(Division(1, 2).integrate().toString(), "∫1/2 dx")
    }
    
    func testPow() {
        XCTAssertEqual(Pow(11, 2).toString(), "11^2")
        XCTAssertEqual(Pow(11, 2.0).toString(), "11^2.0")
        XCTAssertEqual(Pow(11, 2).toLaTeX(), "{11}^{2}")
        XCTAssertEqual(Pow(11, 2.0).toLaTeX(), "{11}^{2.0}")
        XCTAssertEqual(Pow(11, 2).base.toString(), "11")
        XCTAssertEqual(Pow(11, 2).power.toString(), "2")
        XCTAssertEqual(Pow(1, Multiplication(3, 4, 5)).simplify().toString(), "1")
        XCTAssertEqual(Pow(Multiplication(3, 1, 5), 1).simplify().toString(), "3*5")
        XCTAssertEqual(Pow(Pow(1, 2), 3).simplify().toString(), "1")
        XCTAssertEqual(Pow(Pow(4, 2), 3).simplify().toString(), "4^2*3")
        XCTAssertEqual(Pow(Multiplication(4, 2), 3).simplify().toString(), "4^3*2^3")
        XCTAssertEqual(Pow(Multiplication(3, 2, 4), 3).simplify().toString(), "3^3*2^3*4^3")
        XCTAssertEqual(Pow(1, -2).absoluteValue().toString(), "1^-2")
        XCTAssertEqual(Pow(-2, 3).absoluteValue().toString(), "|-2^3|")
        XCTAssertEqual(Pow(-2, 2).absoluteValue().toString(), "-2^2")
        XCTAssertEqual(Pow(3, 2).differentiate().toString(), "0")
        XCTAssertEqual(Pow(Unknown(), 2).differentiate().simplify().toString(), "2*x")
        XCTAssertEqual(Pow(3, 2).integrate().toString(), "∫3^2 dx")
        XCTAssertEqual(Pow(Unknown(), 2).integrate().simplify().toString(), "1/3*x^3")
    }
    
    func testDifferentiate() {
        XCTAssertEqual(Differential(of: Unknown("y"), Pow(3, 2)).toString(), "d/dy(3^2)")
        XCTAssertEqual(Differential(Pow(3, 2)).toString(), "d/dx(3^2)")
        XCTAssertEqual(Differential(3).integrate(of: Unknown("y")).toString(), "∫d/dx(3) dy")
    }
    
    func testIntegral() {
        XCTAssertEqual(Integral(of: Unknown("y"), Pow(3, 2)).toString(), "∫3^2 dy")
        XCTAssertEqual(Integral(Pow(3, 2)).toString(), "∫3^2 dx")
        XCTAssertEqual(Integral(3).integrate(of: Unknown("y")).toString(), "∫∫3 dx dy")
    }
    
    func testAbsoluteValue() {
        XCTAssertEqual(AbsoluteValue(-3).simplify() as! Int, 3)
    }
    
    func testOpposite() {
        XCTAssertEqual(Opposite(-3).simplify() as! Int, 3)
    }

    static var allTests = [
        ("testInt", testInt),
        ("testDouble", testDouble),
        ("testInfinity", testInfinity),
        ("testConstant", testConstant),
        ("testMultiNodesOperator", testMultiNodesOperator),
        ("testAddition", testAddition),
        ("testMultiplication", testMultiplication),
        ("testDivision", testDivision),
        ("testPow", testPow),
        ("testDifferentiate", testDifferentiate),
        ("testIntegral", testIntegral),
        ("testAbsoluteValue", testAbsoluteValue),
        ("testOpposite", testOpposite),
    ]
}
