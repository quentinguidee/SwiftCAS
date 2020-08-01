//
//  GeometryTests.swift
//  
//
//  Created by Quentin Guidée on 27/07/2020.
//

import XCTest
@testable import SwiftCAS

final class GeometryTests: XCTestCase {
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
    
    static var allTests = [
        ("testVector", testVector),
    ]
}
