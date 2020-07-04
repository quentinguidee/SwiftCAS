import XCTest

import CoreTests

var tests = [XCTestCaseEntry]()
tests += CoreTests.allTests()
tests += ParserTests.allTests()
XCTMain(tests)
