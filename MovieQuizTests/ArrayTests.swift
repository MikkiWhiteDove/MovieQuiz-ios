//
//  ArrayTests.swift
//  MovieQuizTests
//
//  Created by Mishana on 10.08.2023.
//

import XCTest
@testable import MovieQuiz

final class ArrayTests: XCTestCase {
    func testGetValueInRange() throws {
        // Given
        let array = [1, 1, 2, 3, 5]
        // When
        let value = array[safe: 0]
        // Then
        XCTAssertNotNil(value)
        XCTAssertEqual(value, 1)
    }
    
    func testGetValueOutRange() throws {
        // Given
        let array = [0, 1, 2, 3]
        // When
        let value = array[safe: 5]
        // Then
        XCTAssertNil(value)
    }
}
