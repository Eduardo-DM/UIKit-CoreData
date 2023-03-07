//
//  UIKitCoreDataTests.swift
//  UIKitCoreDataTests
//
//  Created by Eduardo Developer on 15/2/23.
//

import XCTest
import CoreData
@testable import UIKitCoreData

final class UIKitCoreDataTests: XCTestCase {
    
    var ctx: NSManagedObjectContext!
    var opInvoker: CRUDGameOPInvoker!

    override func setUpWithError() throws {
        ctx = StorageProvider(storeType: .inMemory).persistentContainer.viewContext
        opInvoker = CRUDGameOPInvoker()
    }

    override func tearDownWithError() throws {
        ctx = nil
    }

    func testCRUDGameCreateInCoreDataCommand() throws {
        
        let commandToRun = CRUDGameCreateInCoreDataCommand(
            designer: "Uwe Rosenberg",
            complexity: Game.Complexity.medium,
            targetAge: Game.TargetAge.adults,
            title: "Le Havre",
            yearReleased: "2008",
            ctx:ctx)
        
        opInvoker.setCommand(command: commandToRun)
        
        XCTAssertNotNil(try? opInvoker.run())
        let query: NSFetchRequest <Games> = Games.fetchRequest()
        query.predicate = NSPredicate(format: "%K == %@",
                                      #keyPath(Games.title),
                                      "Le Havre")
        let result = try ctx.count(for: query)
        if result != 1 {
            XCTFail()
        }
        
    }
    
    func testCRUDGameUpdateInCoreDataCommand() throws{
        
        let commandToCreateGame1 = CRUDGameCreateInCoreDataCommand(
            designer: "Uwe Rosenberg",
            complexity: Game.Complexity.medium,
            targetAge: Game.TargetAge.adults,
            title: "Le Havre",
            yearReleased: "2008",
            ctx:ctx)
        opInvoker.setCommand(command: commandToCreateGame1)
        try! opInvoker.run()
        let commandToCreateGame2 = CRUDGameCreateInCoreDataCommand(
            designer: game2.designer,
            complexity: game2.complexity,
            targetAge: game2.targetAge,
            title: game2.title,
            yearReleased: game2.yearReleased == nil ? nil : "\(game2.yearReleased!)",
            ctx:ctx)
        opInvoker.setCommand(command: commandToCreateGame2)
        try! opInvoker.run()
        let updatedGame = try Game(designer: "Uwe", complexity: .hard, targetAge: .babies, title: game1.title, yearReleased: "100")
        
        let commandToUpdate = CRUDGameUpdateInCoreDataCommand(
            originalTitle: "Le Havre",
            designer: updatedGame.designer,
            complexity: updatedGame.complexity,
            targetAge: updatedGame.targetAge,
            actualTitle: updatedGame.title,
            yearReleased: updatedGame.yearReleased == nil ? nil : "\(updatedGame.yearReleased!)",
            ctx: ctx)
        opInvoker.setCommand(command: commandToUpdate)
        XCTAssertNoThrow(try opInvoker.run())
        
        let cRUDGameOp = CRUDGameOp()
        let updatedCoreDataGame1 = try XCTUnwrap(cRUDGameOp.getGameCoreData(title: game1.title, ctx: ctx))
        equals(gameCD: updatedCoreDataGame1, game: updatedGame)
        
        let commandToUpdateFails = CRUDGameUpdateInCoreDataCommand(
            originalTitle: "sdfadfasdfvzxs",
            designer: updatedGame.designer,
            complexity: updatedGame.complexity,
            targetAge: updatedGame.targetAge,
            actualTitle: updatedGame.title,
            yearReleased: updatedGame.yearReleased == nil ? nil : "\(updatedGame.yearReleased!)",
            ctx: ctx)
        opInvoker.setCommand(command: commandToUpdateFails)
        XCTAssertThrowsError(try opInvoker.run()) {inputError in
            let myError = inputError as? ErrorModelLogic
            if myError != ErrorModelLogic.notDefined{
                XCTFail("It must lanch ErrorModelLogic.notDefined")
            }
        }

    }
    
    /*
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }*/

}
