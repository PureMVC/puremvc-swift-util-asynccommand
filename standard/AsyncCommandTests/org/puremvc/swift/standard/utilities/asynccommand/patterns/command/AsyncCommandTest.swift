//
//  AsyncCommandTest.swift
//  PureMVC SWIFT Standard Utility – AsyncCommand
//
//  Copyright(c) 2015-2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the Creative Commons Attribution 3.0 License
//

import XCTest
import AsyncCommand

class AsyncCommandTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testConstructor() {
        let asyncCommand = AsyncCommand()
        XCTAssertNotNil(asyncCommand, "Expecting instance not nil")
    }
    
    func testOnComplete() {
        let asyncCommand = AsyncCommand()
        let resource = Resource()
        
        asyncCommand.commandComplete() //the program should not crash
        
        asyncCommand.onComplete = {resource.i += 1}
        asyncCommand.commandComplete()
        XCTAssertTrue(resource.i == 1, "resource.i should be 1")
    }
    
    func testDeinit() {
        var asyncCommandExtend: AsyncCommandExtend! = AsyncCommandExtend()
        let resource = Resource()
        asyncCommandExtend.resource = resource
        asyncCommandExtend = nil
        XCTAssertTrue(resource.i == 1, "resource.i should be equal to 1")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
