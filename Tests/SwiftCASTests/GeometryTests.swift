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
        XCTAssertEqual(Vector(1, 2, Addition(2, 3), 4).simplify().toString(), "(1,2,5,4)")
    }
    
    static var allTests = [
        ("testVector", testVector),
    ]
}
