import XCTest

import CoreTests

var tests = [XCTestCaseEntry]()
tests += AlgebraTests.allTests()
tests += CoreTests.allTests()
tests += GeometryTests.allTests()
tests += ParserTests.allTests()
XCTMain(tests)
