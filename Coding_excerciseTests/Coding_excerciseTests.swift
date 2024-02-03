//
//  Coding_excerciseTests.swift
//  Coding_excerciseTests
//
//  Created by Neethu on 02/02/2024.
//

import XCTest
@testable import Coding_excercise

final class Coding_excerciseTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDidParseData() throws {
        let wm = WebManager()
        let data = WebModel(title: "swift", htmlText: "Swift is a powerful programming language. SWIFT is a powerful programming language. swift is a powerful programming language.")
        
        let count = wm.findCountOfTitle(parsedData: data)
        
        XCTAssertEqual(count, 3)
        
    }
}
