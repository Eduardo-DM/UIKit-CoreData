//
//  CRUDGameOp.swift
//  UIKitCoreData
//
//  Created by Eduardo Developer on 23/2/23.
//

import Foundation
import CoreData

struct CRUDGameOp {
    
    func checkTitle(_ title: String, ctx: NSManagedObjectContext) throws{
        let query: NSFetchRequest <Games> = Games.fetchRequest()
        query.predicate = NSPredicate(format: "%K == %@",
                                      #keyPath(Games.title),
                                      title)
        let result = try ctx.count(for: query)
        if result > 0 {
            throw ErrorModelLogic.Persistance.gameAlreadyExists
        }
    }
    
    func createGameEntity(designer: String?, complexity: Game.Complexity?, targetAge: Game.TargetAge?, title: String, yearReleased: String?) throws -> Game {
        return try Game(designer: designer, complexity: complexity, targetAge: targetAge, title: title, yearReleased: yearReleased)
    }
    
    func addGameEntityInCoreData(game: Game, ctx: NSManagedObjectContext) throws{
        let newGame = Games(context: ctx)
        newGame.title = game.title
        newGame.targetAge = game.targetAge == nil ? nil : NSNumber(value: game.targetAge!.rawValue)
        newGame.complexity = game.complexity == nil ? nil : NSNumber(value: game.complexity!.rawValue)
        newGame.designer = game.designer
        newGame.yearReleased = game.yearReleased == nil ? nil : NSNumber(value: game.yearReleased!)
        do {
            try ctx.save()
        }
        catch (let caughtError){
            ctx.rollback()
            throw ErrorModelLogic.systemError(caughtError)
        }
    }
    
}
