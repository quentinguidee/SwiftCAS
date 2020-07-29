//
//  AlgebraTests.swift
//  
//
//  Created by Quentin Guidée on 29/07/2020.
//

import XCTest
@testable import SwiftCAS

final class AlgebraTests: XCTestCase {
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
        XCTAssertEqual(Matrix([[1, Unknown()], [Addition(4+5), 4]]).simplify().toString(), "[[1,x],[9,4]]")
        XCTAssertEqual(Matrix([[1, 2], [3, 3]]).determinant().toString(), "-3")
    }
    
    static var allTests = [
        ("testMatrix", testMatrix),
    ]
}
