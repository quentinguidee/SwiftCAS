//
//  AlgebraTests.swift
//  
//
//  Created by Quentin Guidée on 29/07/2020.
//

import XCTest
@testable import SwiftCAS

final class AlgebraTests: XCTestCase {
    func testVector() {
        XCTAssertEqual(Vector(1, 2, 3, 4).toString(), "(1,2,3,4)")
        XCTAssertEqual(Vector(1, 2, Addition(2, 3), 4).simplified().toString(), "(1,2,5,4)")
        XCTAssertEqual(Vector(1, 2, Addition(2, 3), 4).dimension, 4)
        XCTAssertEqual(Vector.zero(dim: 3).toString(), "(0,0,0)")
        XCTAssertTrue(Vector(0, 0, 0).isZero())
        XCTAssertFalse(Vector(1, 0, 0).isZero())
        XCTAssertTrue(Vector(1, 0, 0) == Vector(1, 0, 0))
        XCTAssertFalse(Vector(1, 0, 0) == Vector(0, 1, 0))
    }
    
    func testMatrix() {
        XCTAssertEqual(Matrix([[1, 2], [3, 4]]).toString(), "[[1,2],[3,4]]")
        XCTAssertEqual(Matrix([1, 2], [3, 4]).toString(), "[[1,2],[3,4]]")
        XCTAssertEqual(Matrix([1, 2], [3, 4]).trace().toString(), "5")
        XCTAssertEqual(Matrix([1, 2, 3], [3, 4, 5]).trace().toString(), "nan")
        XCTAssertEqual(Matrix([1, 2, 3], [3, 4, 5]).transpose().toString(), "[[1,3],[2,4],[3,5]]")
        XCTAssertEqual(Matrix([1, 2, 3], [3, 4, 5]).dimension.n, 2)
        XCTAssertEqual(Matrix([1, 2, 3], [3, 4, 5]).dimension.m, 3)
        XCTAssertEqual(Matrix([1, 2, 3], [3, 4, 5]).order.n, 2)
        XCTAssertEqual(Matrix([1, 2, 3], [3, 4, 5]).order.m, 3)
        XCTAssertEqual(Matrix([[1, Unknown()], [Addition(4+5), 4]]).simplified().toString(), "[[1,x],[9,4]]")
        XCTAssertEqual(Matrix([[1, 2], [3, 3]]).determinant().toString(), "-3")
        XCTAssertEqual(Matrix.identity(order: 2).toString(), "[[1,0],[0,1]]")
        XCTAssertEqual(Matrix.identity(order: 4).toString(), "[[1,0,0,0],[0,1,0,0],[0,0,1,0],[0,0,0,1]]")
        XCTAssertTrue(Matrix([1, 2], [3, 4]) == Matrix([1, 2], [3, 4]))
        XCTAssertFalse(Matrix([1, 2], [3, 4]) == Matrix([1, 2], [3, 2]))
    }
    
    func testKroneckerDelta() {
        XCTAssertEqual(KroneckerDelta(3, 2).simplified().toString(), "0")
        XCTAssertEqual(KroneckerDelta(3, 3).simplified().toString(), "1")
        XCTAssertTrue(KroneckerDelta(4, 4) == KroneckerDelta(3, 3))
        XCTAssertFalse(KroneckerDelta(3, 4) == KroneckerDelta(3, 3))
        XCTAssertEqual(KroneckerDelta(4, 4).toString(), "δ_(44)")
        XCTAssertEqual(KroneckerDelta(4, 4).toLaTeX(), "\\delta_{44}")
    }
    
    static var allTests = [
        ("testVector", testVector),
        ("testMatrix", testMatrix),
        ("testKroneckerDelta", testKroneckerDelta),
    ]
}
