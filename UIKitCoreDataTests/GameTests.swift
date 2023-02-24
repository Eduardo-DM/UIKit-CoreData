//
//  GameTests.swift
//  UIKitCoreDataTests
//
//  Created by Eduardo Developer on 15/2/23.
//

import XCTest
@testable import UIKitCoreData

final class GameTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGameInit() {
        let noTitle = ""
        let title1 = "Le Havre"
        let designer1 = "Uwe Rosenberg"
        let complexity1 = Game.Complexity.medium
        let targetAge1 = Game.TargetAge.adults
        let yearPublishing1 = "2008"

        XCTAssertThrowsError(try Game(designer: designer1, complexity: complexity1, targetAge: targetAge1, title: noTitle, yearReleased: yearPublishing1), "It must lanch an error, title is empty", {inputError in
            let myError = inputError as? ErrorModelLogic.Game
            if myError != ErrorModelLogic.Game.noTitle{
                XCTFail("It must lanch ErrorModelLogic.Game.noTitle")
            }
        })
        
        let game1 = try? Game(designer: designer1, complexity: complexity1, targetAge: targetAge1, title: title1, yearReleased: yearPublishing1)
        XCTAssertNotNil(game1)
        
        XCTAssertEqual(title1, game1?.title)
        XCTAssertEqual(designer1, game1?.designer)
        XCTAssertEqual(complexity1, game1?.complexity)
        XCTAssertEqual(targetAge1, game1?.targetAge)
        XCTAssertEqual(UInt16(yearPublishing1), game1?.yearReleased)
        
        let game2 = try? Game(designer: nil, complexity: nil, targetAge: nil, title: title1, yearReleased: nil)
        XCTAssertNotNil(game2)
        
        XCTAssertEqual(title1, game2?.title)
        XCTAssertEqual(nil, game2?.designer)
        XCTAssertEqual(nil, game2?.complexity)
        XCTAssertEqual(nil, game2?.targetAge)
        XCTAssertEqual(nil, game2?.yearReleased)
        
        XCTAssertThrowsError(try Game(designer: designer1, complexity: complexity1, targetAge: targetAge1, title: title1, yearReleased: "-1"), "It must lanch an error, release year must be converted in UInt16", {inputError in
            let myError = inputError as? ErrorModelLogic.Game
            if myError != ErrorModelLogic.Game.yearFieldIsNotANumber{
                XCTFail("It must lanch ErrorModelLogic.Game.yearFieldIsNotANumber")
            }
        })
        
        XCTAssertThrowsError(try Game(designer: designer1, complexity: complexity1, targetAge: targetAge1, title: title1, yearReleased: "I'm a text"), "It must lanch an error, release year must be converted in UInt16", {inputError in
            let myError = inputError as? ErrorModelLogic.Game
            if myError != ErrorModelLogic.Game.yearFieldIsNotANumber{
                XCTFail("It must lanch ErrorModelLogic.Game.yearFieldIsNotANumber")
            }
        })
        
        XCTAssertThrowsError(try Game(designer: designer1, complexity: complexity1, targetAge: targetAge1, title: title1, yearReleased: "1.8"), "It must lanch an error, release year must be converted in UInt16", {inputError in
            let myError = inputError as? ErrorModelLogic.Game
            if myError != ErrorModelLogic.Game.yearFieldIsNotANumber{
                XCTFail("It must lanch ErrorModelLogic.Game.yearFieldIsNotANumber")
            }
        })
        
    }
    
/*
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
*/
}
