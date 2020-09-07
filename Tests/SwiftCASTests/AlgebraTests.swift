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
        XCTAssertTrue(Sets.natural.contains(3))
        XCTAssertFalse(Sets.natural.contains(-3))
        XCTAssertFalse(Sets.natural.contains(3.2))
        XCTAssertTrue(Sets.integer.contains(3))
        XCTAssertTrue(Sets.integer.contains(-3))
        XCTAssertFalse(Sets.integer.contains(3.2))
        XCTAssertTrue(Sets.real.contains(3))
        XCTAssertTrue(Sets.real.contains(-3))
        XCTAssertTrue(Sets.real.contains(3.2))
        XCTAssertTrue(Sets.complex.contains(3))
        XCTAssertTrue(Sets.complex.contains(-3))
        XCTAssertTrue(Sets.complex.contains(3.2))
        XCTAssertTrue(FiniteSet(Vector(1, 2), Vector(3, 0)).contains(Vector(1, 2)))
        XCTAssertFalse(FiniteSet(Vector(1, 2)).contains(Vector(2, 2)))
        XCTAssertEqual(FiniteSet(Vector(1, 2)).dimension, 1)
        XCTAssertEqual(FiniteSet(Vector(1, 2), Vector(2, 3)).dimension, 2)
        XCTAssertEqual(FiniteSet(Vector(1, 2), Vector(1, 2)).dimension, 1)
        XCTAssertEqual(Sets.complex.dimension, 2)
    }
    
    func testUnion() {
        XCTAssertEqual(Union(FiniteSet(Vector(1, 2), Vector(3, 2)), FiniteSet(Vector(2, 3))).simplified().toString(), "{(2,3),(1,2),(3,2)}")
        XCTAssertEqual(Union(FiniteSet(Vector(1, 2), Vector(3, 2)), FiniteSet(Vector(1, 2))).simplified().toString(), "{(1,2),(3,2)}")
        XCTAssertEqual(Union(FiniteSet(1, 2, 3), FiniteSet(2, 3, 4)).simplified().toString(), "{2,3,4,1}")
        XCTAssertEqual(Union(IntegerSet(), IntegerSet()).simplified().toString(), "ℤ")
        XCTAssertEqual(Union(FiniteSet(1, 2), IntegerSet()).simplified().toString(), "ℤ")
        XCTAssertEqual(Union(IntegerSet(), FiniteSet(1, 2)).simplified().toString(), "ℤ")
    }
    
    func testIntersection() {
        XCTAssertEqual(Intersection(FiniteSet(1, 2, 3), FiniteSet(2, 3, 4)).simplified().toString(), "{2,3}")
        XCTAssertEqual(Intersection(Sets.integer, FiniteSet(3, 4)).simplified().toString(), "{3,4}")
        XCTAssertEqual(Intersection(Sets.natural, FiniteSet(-2, 4)).simplified().toString(), "{4}")
    }

    static var allTests = [
        ("testSet", testSet),
        ("testUnion", testUnion),
        ("testIntersection", testIntersection),
    ]
}
