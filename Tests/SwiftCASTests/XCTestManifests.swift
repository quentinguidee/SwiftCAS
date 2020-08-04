import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(AlgebraTests.allTests),
        testCase(CoreTests.allTests),
        testCase(ParserTests.allTests),
    ]
}
#endif
