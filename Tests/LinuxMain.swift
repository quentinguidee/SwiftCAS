import XCTest

import CoreTests

var tests = [XCTestCaseEntry]()
tests += AlgebraTests.allTests()
tests += CoreTests.allTests()
tests += ParserTests.allTests()
XCTMain(tests)
