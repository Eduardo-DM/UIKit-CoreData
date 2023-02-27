//
//  StorageProviderTests.swift
//  UIKitCoreDataTests
//
//  Created by Eduardo Developer on 27/2/23.
//

import XCTest
import CoreData
@testable import UIKitCoreData

final class StorageProviderTests: XCTestCase {
    
    var ctx: NSManagedObjectContext!

    override func setUpWithError() throws {
        ctx = StorageProvider(storeType: .inMemory).persistentContainer.viewContext
    }

    override func tearDownWithError() throws {
        ctx = nil
    }

    func testGetGame() throws {
        let cRUDGameOp = CRUDGameOp()
        try! cRUDGameOp.addGameEntityInCoreData(game: game1, ctx: ctx)
        try! cRUDGameOp.addGameEntityInCoreData(game: game2, ctx: ctx)
        let game1CoreData = try? XCTUnwrap(try? StorageProvider.shared.getGame(title: game1.title, ctx: ctx))
        let game2CoreData = try? XCTUnwrap(try? StorageProvider.shared.getGame(title: game2.title, ctx: ctx))
        
        if let game1CoreData {
            equals(gameCD: game1CoreData, game: game1)
        }
        else{
            XCTFail()
        }
        if let game2CoreData {
            equals(gameCD: game2CoreData, game: game2)
        }
        else{
            XCTFail()
        }
        
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
