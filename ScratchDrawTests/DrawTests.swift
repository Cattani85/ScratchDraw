//
//  DrawTests.swift
//  ScratchDrawTests
//
//  Created by CaTTani on 03/05/2023.
//

import XCTest
@testable import ScratchDraw

final class DrawTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWipe() throws {
        let draw = Draw()
        draw.wipe()
        
        _ = XCTWaiter.wait(for: [expectation(description: "wait")], timeout: 2.1)
        
        XCTAssertEqual(draw.state, DrawState.wiped, "Wipe doesnt work")
    }
    
    func testCancelWipe() throws {
        let draw = Draw()
        draw.wipe()
        draw.stopWipe()
        
        _ = XCTWaiter.wait(for: [expectation(description: "wait")], timeout: 2.1)
        
        XCTAssertEqual(draw.state, DrawState.notWiped, "Stop wipe doesnt work")
    }
    
    func testReset() throws {
        let draw = Draw()
        draw.wipe()
        sleep(3)
        draw.reset()
        
        XCTAssertEqual(draw.state, DrawState.notWiped, "Reset doesnt work")
    }

}
