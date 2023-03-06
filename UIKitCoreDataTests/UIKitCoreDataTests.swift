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
    var cRUDGameOp: CRUDGameOp!

    override func setUpWithError() throws {
        ctx = StorageProvider(storeType: .inMemory).persistentContainer.viewContext
        opInvoker = CRUDGameOPInvoker()
        cRUDGameOp = CRUDGameOp()
    }

    override func tearDownWithError() throws {
        ctx = nil
    }

    func testCRUDGameCreateInCoreDataCommand() throws {
        
        var commandToRun = CRUDGameCreateInCoreDataCommand(
            cRUDGameCreate: cRUDGameOp,
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

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
