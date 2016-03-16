//
//  AsyncMacroCommandTest.swift
//  AsyncCommand
//  PureMVC SWIFT Standard Utility – AsyncCommand
//
//  Copyright(c) 2015-2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the Creative Commons Attribution 3.0 License
//

import XCTest
import PureMVC
import AsyncCommand

class AsyncMacroCommandTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testConstructor() {
        let asyncMacroCommand = AsyncMacroCommand()
        XCTAssertNotNil(asyncMacroCommand, "Expecting instance not nil")
    }
    
    func testAddSubCommand() {
        let asyncMacroCommand = AsyncMacroCommand()
        asyncMacroCommand.initializeNotifier("test1")
        let resource = Resource()
        let notification = Notification(name: "note", body: resource)
        asyncMacroCommand.addSubCommand() {AsyncCommand1()}
        asyncMacroCommand.addSubCommand() {AsyncCommand2()}
        
        let readyExpectation = expectationWithDescription("ready")
        
        asyncMacroCommand.onComplete = {
            readyExpectation.fulfill()
        }
        
        asyncMacroCommand.execute(notification)
        
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")
            XCTAssertTrue(resource.i == 2, "Resource.i should 2")
        })
    }
    
    func testDeinit() {
        let asyncMacroCommand = AsyncMacroCommand()
        asyncMacroCommand.initializeNotifier("test2")
        let resource = Resource()
        let notification = Notification(name: "note", body: resource)
        asyncMacroCommand.addSubCommand() {AsyncCommand1()}
        asyncMacroCommand.addSubCommand() {AsyncCommand2()}
        
        let readyExpectation = expectationWithDescription("ready")
        
        asyncMacroCommand.onComplete = {
            readyExpectation.fulfill()
        }
        
        asyncMacroCommand.execute(notification)
        
        waitForExpectationsWithTimeout(1, handler: { error in
            XCTAssertNil(error, "Error")
            XCTAssertTrue(resource.released == 2, "Resource.released should be 2")
        })
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
