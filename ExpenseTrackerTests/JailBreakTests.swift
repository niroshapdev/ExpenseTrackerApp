//
//  JailBreakTests.swift
//  ExpenseTrackerTests
//
//  Created by Nirosha Pabolu on 06/11/23.
//

import XCTest
@testable import ExpenseTracker

class JailBreakCheckTests: XCTestCase {
    
    // These tests will pass only when connected with device
//    func testJailBrokenDeviceWithCydiaApp() {
//        XCTAssertTrue(JailBreakCheck.checkForJailBreakDevice())
//    }
//    
//    func testJailBrokenDeviceWithAptDirectory() {
//        XCTAssertTrue(JailBreakCheck.checkForJailBreakDevice())
//    }
    
    func testNonJailBrokenDevice() {
        XCTAssertFalse(JailBreakCheck.checkForJailBreakDevice())
    }
}
