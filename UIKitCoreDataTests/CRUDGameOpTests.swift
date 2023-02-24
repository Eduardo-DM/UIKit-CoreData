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
    
/*
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
*/
}
