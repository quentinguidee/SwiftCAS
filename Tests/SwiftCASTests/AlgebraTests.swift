//
//  AlgebraTests.swift
//  
//
//  Created by Quentin Guidée on 19/08/2020.
//

import XCTest
@testable import SwiftCAS

final class AlgebraTests: XCTestCase {
    func testSet() {
        XCTAssertTrue(NaturalSet.contains(3))
        XCTAssertFalse(NaturalSet.contains(-3))
        XCTAssertFalse(NaturalSet.contains(3.2))
        XCTAssertTrue(IntegerSet.contains(3))
        XCTAssertTrue(IntegerSet.contains(-3))
        XCTAssertFalse(IntegerSet.contains(3.2))
        XCTAssertTrue(RealSet.contains(3))
        XCTAssertTrue(RealSet.contains(-3))
        XCTAssertTrue(RealSet.contains(3.2))
        XCTAssertTrue(ComplexSet.contains(3))
        XCTAssertTrue(ComplexSet.contains(-3))
        XCTAssertTrue(ComplexSet.contains(3.2))
    }
    static var allTests = [
        ("testSet", testSet),
    ]
}
