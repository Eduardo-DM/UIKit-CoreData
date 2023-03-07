//
//  CRUDGameOpTests.swift
//  UIKitCoreDataTests
//
//  Created by Eduardo Developer on 23/2/23.
//

import XCTest
import CoreData
@testable import UIKitCoreData

final class CRUDGameOpTests: XCTestCase {
    
    var ctx: NSManagedObjectContext!

    override func setUpWithError() throws {
        ctx = StorageProvider(storeType: .inMemory).persistentContainer.viewContext
    }

    override func tearDownWithError() throws {
        ctx = nil
    }

    func testAddGameEntityInCoreData() throws {
        let cRUDGameOp = CRUDGameOp()
        XCTAssertNoThrow(try cRUDGameOp.addGameEntityInCoreData(game: game1, ctx: ctx))
        let query: NSFetchRequest <Games> = Games.fetchRequest()
        query.predicate = NSPredicate(format: "%K == %@",
                                      #keyPath(Games.title),
                                      game1.title)
        let result = try ctx.fetch(query)
        XCTAssertEqual(1, result.count)
        equals(gameCD: result[0], game:game1)
    }
    
    func testCheckTitle() throws{
        let cRUDGameOp = CRUDGameOp()
        XCTAssertNoThrow(try cRUDGameOp.addGameEntityInCoreData(game: game1, ctx: ctx))
        XCTAssertNoThrow(try cRUDGameOp.checkTitle(game2.title, ctx: ctx))
        XCTAssertThrowsError(try cRUDGameOp.checkTitle(game1.title, ctx: ctx), "It must lanch an error, already exists other game with the same title", {inputError in
            let myError = inputError as? ErrorModelLogic.Persistance
            if myError != ErrorModelLogic.Persistance.gameAlreadyExists{
                XCTFail("It must lanch ErrorModelLogic.Persistance.gameAlreadyExists")
            }
        })
    }
    
    func testCreateGameEntity() throws{
        let gameTests = GameTests()
        gameTests.testGameInit()
    }
    
    func testGetGameCoreData() throws{
        
        let cRUDGameOp = CRUDGameOp()
        XCTAssertNoThrow(try cRUDGameOp.addGameEntityInCoreData(game: game1, ctx: ctx))
        XCTAssertNoThrow(try cRUDGameOp.addGameEntityInCoreData(game: game2, ctx: ctx))
        
        let gameCoreData1 = try? cRUDGameOp.getGameCoreData(title: game1.title, ctx: ctx)
        let gameCoreData2 = try? cRUDGameOp.getGameCoreData(title: game2.title, ctx: ctx)
        
        if let gameCoreData1 {
            equals(gameCD: gameCoreData1, game: game1)
        }
        else{
            XCTFail()
        }
        if let gameCoreData2 {
            equals(gameCD: gameCoreData2, game: game2)
        }
        else{
            XCTFail()
        }
        
    }
    
    func testUpdateGameCoreData() throws{
        
        let cRUDGameOp = CRUDGameOp()
        XCTAssertNoThrow(try cRUDGameOp.addGameEntityInCoreData(game: game1, ctx: ctx))
        XCTAssertNoThrow(try cRUDGameOp.addGameEntityInCoreData(game: game2, ctx: ctx))
        let game1CoreData = try cRUDGameOp.getGameCoreData(title: game1.title, ctx: ctx)!
        let updatedGame = try Game(designer: "Uwe", complexity: .hard, targetAge: .babies, title: game1.title, yearReleased: "100")
        
        try cRUDGameOp.updateGameCoreData(gameCD: game1CoreData, newDataGame: updatedGame, ctx: ctx)
        
        let updatedGameCoreData = try XCTUnwrap(cRUDGameOp.getGameCoreData(title: game1.title, ctx: ctx))
        equals(gameCD: updatedGameCoreData, game: updatedGame)
        
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
