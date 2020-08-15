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
        XCTAssertEqual(3.isZero(), false)
        XCTAssertEqual(0.isZero(), true)
        XCTAssertEqual(3.differentiated().toString(), "0")
        XCTAssertEqual(3.differentiated(of: Unknown("y")).toString(), "0")
        XCTAssertEqual(3.integrated().toString(), "3*x")
        XCTAssertEqual(3.integrated(of: Unknown("y")).toString(), "3*y")
        XCTAssertEqual(88.factorize().description, "[2, 2, 2, 11]")
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
        XCTAssertEqual(3.2.isZero(), false)
        XCTAssertEqual(0.0.isZero(), true)
        XCTAssertEqual(3.2.differentiated().toString(), "0")
        XCTAssertEqual(3.2.differentiated(of: Unknown("y")).toString(), "0")
        XCTAssertEqual(3.2.integrated().toString(), "3.2*x")
        XCTAssertEqual(3.2.integrated(of: Unknown("y")).toString(), "3.2*y")
    }
    
    func testComplex() {
        XCTAssertEqual(Complex(1, 2).toString(), "1+2𝔦")
        XCTAssertEqual(Complex(1, 0).simplified().toString(), "1")
        XCTAssertEqual(Complex(0, 1).simplified().toString(), "0+1𝔦")
        XCTAssertEqual(Complex(1, 2).toLaTeX(), "1+2i")
        XCTAssertEqual(Complex(1, 3).conjuguate().toString(), "1-3𝔦")
        XCTAssertEqual(Complex(1, 3).real.toString(), "1")
        XCTAssertEqual(Complex(1, 3).imaginary.toString(), "3")
        XCTAssertEqual(Complex(1, 3).re.toString(), "1")
        XCTAssertEqual(Complex(1, 3).im.toString(), "3")
        XCTAssertTrue(Complex(1, 2) == Complex(1, 2))
        XCTAssertFalse(Complex(1, 2) == Complex(1, 3))
    }
    
    func testInfinity() {
        XCTAssertEqual(Infinity().toString(), "∞")
        XCTAssertEqual(Infinity().toLaTeX(), "\\infty")
        XCTAssertEqual(Infinity().sign, Sign.Positive)
        XCTAssertEqual(Infinity().absoluteValue().toString(), "∞")
        XCTAssertEqual(Infinity().differentiated(of: Unknown("y")).toString(), "0")
        XCTAssertEqual(Infinity().integrated(of: Unknown("y")).toString(), "∞")
        XCTAssertTrue(Infinity() == Infinity())
    }
    
    func testConstant() {
        XCTAssertEqual(Constant("π").toString(), "π")
        XCTAssertEqual(Constant("π").toLaTeX(), "\\pi")
        XCTAssertEqual(Constant("e").toString(), "e")
        XCTAssertEqual(Constant("e").toLaTeX(), "e")
        XCTAssertEqual(Constant("e").sign, Sign.Positive)
        XCTAssertEqual(Constant("e").absoluteValue().toString(), "e")
        XCTAssertEqual(Constant("e").differentiated(of: Unknown("y")).toString(), "0")
        XCTAssertEqual(Constant("e").integrated(of: Unknown("y")).toString(), "e*y")
        XCTAssertTrue(Constant("e") == Constant("e"))
        XCTAssertFalse(Constant("e") == Constant("π"))
    }
    
    func testUnknown() {
        XCTAssertEqual(Unknown().toString(), "x")
        XCTAssertEqual(Unknown("x").toString(), "x")
        XCTAssertEqual(Unknown("y").toString(), "y")
        XCTAssertEqual(Unknown("x").toLaTeX(), "x")
        XCTAssertEqual(Unknown("x").absoluteValue().toString(), "|x|")
        XCTAssertEqual(Unknown("x").differentiated().toString(), "1")
        XCTAssertEqual(Unknown("x").differentiated(of: Unknown("y")).toString(), "0")
        XCTAssertEqual(Unknown("x").integrated().toString(), "x^2/2")
        XCTAssertEqual(Unknown("x").integrated(of: Unknown("y")).toString(), "x*y")
        XCTAssertTrue(Unknown("x") == Unknown("x"))
        XCTAssertFalse(Unknown("x") == Unknown("y"))
    }
    
    func testGcd() {
        XCTAssertEqual(Gcd(30, 20).toString(), "gcd(30, 20)")
        XCTAssertEqual(Gcd(30, 20).simplified().toString(), "10")
        XCTAssertTrue(Gcd(30, 20) == Gcd(30, 20))
        XCTAssertFalse(Gcd(30, 20) == Gcd(30, 30))
    }
    
    func testMultiNodesOperator() {
        XCTAssertEqual(Addition(1, 2).toString(), "1+2")
        XCTAssertEqual(Addition([1, 2]).toString(), "1+2")
    }
    
    func testAddition() {
        XCTAssertEqual(Add(32, 2).toString(), "32+2")
        XCTAssertEqual((Division(4, 3)+3).toString(), "4/3+3")
        XCTAssertEqual((Division(4, 3)-3).toString(), "4/3+-3")
        XCTAssertEqual(Add(32, 2).toString(), "32+2")
        XCTAssertEqual(Addition(32, 2).toString(), "32+2")
        XCTAssertEqual(Addition(32, 2.0).toString(), "32+2.0")
        XCTAssertEqual(Addition(32, 2).toLaTeX(), "32+2")
        XCTAssertEqual(Addition(32, 2.0).toLaTeX(), "32+2.0")
        XCTAssertEqual(Addition(Addition(1, 2), 3).simplified().toString(), "6")
        XCTAssertEqual(Addition(Addition(0, 2), 3).simplified().toString(), "5")
        XCTAssertEqual(Addition(Addition(1, 2), 3).differentiated().toString(), "0+0+0")
        XCTAssertEqual(Addition(1, 2, 3).differentiated().toString(), "0+0+0")
        XCTAssertEqual(Addition(Unknown(), 2, 3).differentiated().toString(), "1+0+0")
        XCTAssertEqual(Addition(Addition(1, 2), 3).integrated().toString(), "1*x+2*x+3*x")
        XCTAssertEqual(Addition(1, 2, 3).integrated().toString(), "1*x+2*x+3*x")
        XCTAssertEqual(Addition(Unknown(), 2, 3).integrated().toString(), "x^2/2+2*x+3*x")
        XCTAssertTrue(Addition(1, 2, 3) == Addition(1, 3, 2))
        XCTAssertFalse(Addition(1, 3) == Addition(1, 3, 2))
        XCTAssertFalse(Addition(1, 3, 3) == Addition(1, 3, 2))
        XCTAssertFalse(Addition(1, 3, 2) == Addition(1, 3, 3))
    }
    
    func testMultiplication() {
        XCTAssertEqual((Division(4, 3)*3).toString(), "4/3*3")
        XCTAssertEqual(Mult(32, 2).toString(), "32*2")
        XCTAssertEqual(Multiplication(32, 2).toString(), "32*2")
        XCTAssertEqual(Multiplication(Unknown("x"), Unknown("z"), Unknown("y")).simplified().toString(), "x*y*z")
        XCTAssertEqual(Multiplication(32, 2.0).toString(), "32*2.0")
        XCTAssertEqual(Multiplication(32, 2).toLaTeX(), "32*2")
        XCTAssertEqual(Multiplication(32, 2.0).toLaTeX(), "32*2.0")
        XCTAssertEqual(Multiplication(-2, 3, -4, -5.2).sign, Sign.Negative)
        XCTAssertEqual(Multiplication(0, -2, 3, -4).sign, Sign.Signless)
        XCTAssertEqual(Multiplication(1, -2, 3, 4).absoluteValue().toString(), "|1*-2*3*4|")
        XCTAssertEqual(Multiplication(2, -2, 3, -4).simplified().toString(), "48")
        XCTAssertEqual(Multiplication(Multiplication(1, 2), 3).simplified().toString(), "6")
        XCTAssertEqual(Multiplication(Multiplication(0, 2), 3).simplified().toString(), "0")
        XCTAssertEqual(Multiplication(Unknown("x"), Opposite(Unknown("y"))).simplified().toString(), "-1*x*y")
        XCTAssertEqual(Multiplication(Opposite(Unknown("x")), Opposite(Unknown("y"))).simplified().toString(), "x*y")
        XCTAssertEqual(Multiplication(Multiplication(1, 2), 3).differentiated().toString(), "d/dx(1*2*3)")
        XCTAssertEqual(Multiplication(Multiplication(1, 2), 3).integrated().toString(), "∫1*2*3 dx")
        XCTAssertTrue(Multiplication(1, 2, 3) == Multiplication(1, 3, 2))
        XCTAssertFalse(Multiplication(1, 3) == Multiplication(1, 3, 2))
        XCTAssertFalse(Multiplication(1, 3, 3) == Multiplication(1, 3, 2))
        XCTAssertFalse(Multiplication(1, 3, 2) == Multiplication(1, 3, 3))
    }
    
    func testDivision() {
        XCTAssertEqual((Division(4, 3)/3).toString(), "4/3/3")
        XCTAssertEqual(Division(32, 2).simplified().toString(), "16")
        XCTAssertEqual(Division(32, 0).simplified().toString(), "nan")
        XCTAssertEqual(Division(0, 0).simplified().toString(), "nan")
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
        XCTAssertEqual(Division(3, 1).simplified().toString(), "3")
        XCTAssertEqual(Division(3, Multiplication(1, 2)).simplified().toString(), "3/2")
        XCTAssertEqual(Division(3, 1.0).simplified().toString(), "3")
        XCTAssertEqual(Division(1, -2).absoluteValue().toString(), "|1/-2|")
        XCTAssertEqual(Division(0, 2).simplified().toString(), "0")
        XCTAssertEqual(Division(1, 2).differentiated().simplified().toString(), "0")
        XCTAssertEqual(Division(Unknown(), 2).differentiated().simplified().toString(), "1/2")
        XCTAssertEqual(Division(Unknown(), 2).integrated().toString(), "∫x/2 dx")
        XCTAssertEqual(Division(1, 2).integrated().toString(), "1/2*x")
        XCTAssertTrue(Division(1, 2) == Division(1, 2))
        XCTAssertFalse(Division(1, 2) == Division(2, 1))
    }
    
    func testPow() {
        XCTAssertEqual((Division(4, 3)^3).toString(), "4/3^3")
        XCTAssertEqual((Division(4, 3)**3).toString(), "4/3^3")
        XCTAssertEqual(Power(11, 2).toString(), "11^2")
        XCTAssertEqual(Pow(11, 2).toString(), "11^2")
        XCTAssertEqual(Pow(11, 2.0).toString(), "11^2.0")
        XCTAssertEqual(Pow(11, 2).toLaTeX(), "{11}^{2}")
        XCTAssertEqual(Pow(11, 2.0).toLaTeX(), "{11}^{2.0}")
        XCTAssertEqual(Pow(11, 2).base.toString(), "11")
        XCTAssertEqual(Pow(11, 2).power.toString(), "2")
        XCTAssertEqual(Pow(1, Multiplication(3, 4, 5)).simplified().toString(), "1")
        XCTAssertEqual(Pow(Multiplication(3, 1, 5), 1).simplified().toString(), "15")
        XCTAssertEqual(Pow(Pow(1, 2), 3).simplified().toString(), "1")
        XCTAssertEqual(Pow(Pow(4, 2), 3).simplified().toString(), "4096")
        XCTAssertEqual(Pow(Multiplication(4, Unknown()), 3).simplified().toString(), "64*x^3")
        XCTAssertEqual(Pow(Multiplication(3, Unknown(), Constant("π")), 3).simplified().toString(), "27*x^3*π^3")
        XCTAssertEqual(Pow(1, -2).absoluteValue().toString(), "1^-2")
        XCTAssertEqual(Pow(-2, 3).absoluteValue().toString(), "|-2^3|")
        XCTAssertEqual(Pow(-2, 2).absoluteValue().toString(), "-2^2")
        XCTAssertEqual(Pow(3, 2).differentiated().toString(), "0")
        XCTAssertEqual(Pow(Unknown(), 2).differentiated().simplified().toString(), "2*x")
        XCTAssertEqual(Pow(3, 2).integrated().toString(), "∫3^2 dx")
        XCTAssertEqual(Pow(Unknown(), 2).integrated().simplified().toString(), "1/3*x^3")
        XCTAssertEqual(3.inverse().toString(), "3^-1")
        XCTAssertTrue(Pow(2, 3) == Pow(2, 3))
        XCTAssertFalse(Pow(2, 3) == Pow(3, 2))
    }
    
    func testDifferentiate() {
        XCTAssertEqual(Differential(of: Unknown("y"), Pow(3, 2)).toString(), "d/dy(3^2)")
        XCTAssertEqual(Differential(Pow(3, 2)).toString(), "d/dx(3^2)")
        XCTAssertEqual(Differential(3).integrated(of: Unknown("y")).toString(), "∫d/dx(3) dy")
        XCTAssertTrue(Differential(Pow(Unknown(), 2)) == Differential(Pow(Unknown("x"), 2)))
        XCTAssertFalse(Differential(of: Unknown(), 3) == Differential(of: Unknown("y"), 3))
        XCTAssertFalse(Differential(Pow(Unknown(), 2)) == Differential(Pow(Unknown("y"), 2)))
    }
    
    func testIntegral() {
        XCTAssertEqual((∫Unknown()).toString(), "∫x dx")
        XCTAssertEqual(Integral(of: Unknown("y"), Pow(3, 2)).toString(), "∫3^2 dy")
        XCTAssertEqual(Integral(Pow(3, 2)).toString(), "∫3^2 dx")
        XCTAssertEqual(Integral(3).integrated(of: Unknown("y")).toString(), "∫∫3 dx dy")
        XCTAssertTrue(Integral(Pow(Unknown(), 2)) == Integral(Pow(Unknown("x"), 2)))
        XCTAssertFalse(Integral(of: Unknown(), 3) == Integral(of: Unknown("y"), 3))
        XCTAssertFalse(Integral(Pow(Unknown(), 2)) == Integral(Pow(Unknown("y"), 2)))
    }
    
    func testAbsoluteValue() {
        XCTAssertEqual(AbsoluteValue(-3).simplified() as! Int, 3)
        XCTAssertEqual(AbsoluteValue(-3).absoluteValue().toString(), "|-3|")
        XCTAssertTrue(AbsoluteValue(-3) == AbsoluteValue(-3))
        XCTAssertFalse(AbsoluteValue(-3) == AbsoluteValue(-2))
    }
    
    func testOpposite() {
        XCTAssertEqual(Opposite(Unknown()).simplified().toString(), "-1*x")
        XCTAssertEqual((-(√Unknown())).toString(), "-sqrt(x)")
        XCTAssertEqual(Opposite(-3).simplified() as! Int, 3)
        XCTAssertTrue(Opposite(-3) == Opposite(-3))
        XCTAssertFalse(Opposite(-3) == Opposite(-2))
    }
    
    func testSin() {
        XCTAssertEqual(Sine(3).toString(), "sin(3)")
        XCTAssertEqual(Sin(3).toString(), "sin(3)")
        XCTAssertEqual(Sin(3).toLaTeX(), "\\sin{(3)}")
        XCTAssertEqual(Sin(3).differentiated().toString(), "0*cos(3)")
        XCTAssertTrue(Sin(-3) == Sin(-3))
        XCTAssertFalse(Sin(-3) == Sin(-2))
    }
    
    func testCos() {
        XCTAssertEqual(Cosine(3).toString(), "cos(3)")
        XCTAssertEqual(Cos(3).toString(), "cos(3)")
        XCTAssertEqual(Cos(3).toLaTeX(), "\\cos{(3)}")
        XCTAssertEqual(Cos(3).differentiated().toString(), "0*-sin(3)")
        XCTAssertTrue(Cos(-3) == Cos(-3))
        XCTAssertFalse(Cos(-3) == Cos(-2))
    }
    
    func testTan() {
        XCTAssertEqual(Tangent(3).toString(), "tan(3)")
        XCTAssertEqual(Tan(3).toString(), "tan(3)")
        XCTAssertEqual(Tan(3).toLaTeX(), "\\tan{(3)}")
        XCTAssertEqual(Tan(3).differentiated().toString(), "0*cos(3)*cos(3)+-sin(3)*0*-sin(3)/cos(3)^2")
        XCTAssertTrue(Tan(-3) == Tan(-3))
        XCTAssertFalse(Tan(-3) == Tan(-2))
    }
    
    func testRoot() {
        XCTAssertEqual((√Unknown()).toString(), "sqrt(x)")
        XCTAssertEqual(Root(4).toString(), "sqrt(4)")
        XCTAssertEqual(Root(4, 2).toString(), "sqrt(4)")
        XCTAssertEqual(Root(4, 3).toString(), "cbrt(4)")
        XCTAssertEqual(Root(4, 4).toString(), "root(4, 4)")
        XCTAssertEqual(Root(4).toLaTeX(), "\\sqrt{4}")
        XCTAssertEqual(Root(4, 2).toLaTeX(), "\\sqrt{4}")
        XCTAssertEqual(Root(4, 3).toLaTeX(), "\\sqrt[3]{4}")
        XCTAssertTrue(Root(-3, 3) == Root(-3, 3))
        XCTAssertFalse(Root(-3, 3) == Root(-3, 2))
        XCTAssertFalse(Root(-3, 3) == Root(-2, 3))
    }
    
    func testFactorial() {
        XCTAssertEqual(Fact(5).simplified().toString(), "120")
        XCTAssertEqual(Factorial(5).simplified().toString(), "120")
        XCTAssertEqual(21.factorial().toString(), "∞")
        XCTAssertEqual(20.factorial().toString(), "2432902008176640000")
        XCTAssertEqual(5.factorial().toString(), "120")
        XCTAssertEqual(2.factorial().toString(), "2")
        XCTAssertEqual(1.factorial().toString(), "1")
        XCTAssertEqual(0.factorial().toString(), "1")
        XCTAssertEqual((-1).factorial().toString(), "∞")
        XCTAssertTrue(Factorial(3) == Factorial(3))
        XCTAssertFalse(Factorial(3) == Factorial(2))
    }
    
    func testScalarProduct() {
        XCTAssertEqual(DotProduct(Vector(1, 0), Vector(0, 1)).toString(), "⟨(1,0),(0,1)⟩")
        XCTAssertEqual(ScalarProduct(Vector(1, 0), Vector(0, 1)).toString(), "⟨(1,0),(0,1)⟩")
        XCTAssertEqual(ScalarProduct(Vector(1, 0), Vector(0, 1)).toLaTeX(), "\\langle\\left(1,0\\right),\\left(0,1\\right)\\rangle")
        XCTAssertEqual(ScalarProduct(Vector(0, 0), Vector(0, 0)).simplified().toString(), "0")
        XCTAssertTrue(ScalarProduct(Vector(0, 0), Vector(0, 1)) == ScalarProduct(Vector(0, 0), Vector(0, 1)))
        XCTAssertTrue(ScalarProduct(Vector(0, 0), Vector(0, 1)) == ScalarProduct(Vector(0, 1), Vector(0, 0)))
        XCTAssertFalse(ScalarProduct(Vector(0, 0), Vector(0, 1)) == ScalarProduct(Vector(0, 0), Vector(0, 0)))
    }
    
    func testPercent() {
        XCTAssertEqual(Percent(10).toString(), "10%")
        XCTAssertEqual(Percent(10).simplified().toString(), "0.1")
        XCTAssertTrue(Percent(10) == Percent(10))
        XCTAssertFalse(Percent(10) == Percent(11))
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
        ("testSin", testSin),
        ("testCos", testCos),
        ("testTan", testTan),
        ("testRoot", testRoot),
        ("testFactorial", testFactorial),
        ("testScalarProduct", testScalarProduct),
    ]
}
