//
//  CRUDGameUpdateCommand.swift
//  UIKitCoreData
//
//  Created by Eduardo Developer on 6/3/23.
//

import Foundation
import CoreData

struct CRUDGameUpdateInCoreDataCommand: Command {
    
    let ctx: NSManagedObjectContext
    
    var operation: CRUDGameOp
    
    let originalTitle: String
    let designer: String?
    let complexity: Game.Complexity?
    let targetAge: Game.TargetAge?
    let actualTitle: String
    let yearReleased: String?
    
    init(originalTitle: String, designer: String?, complexity: Game.Complexity?, targetAge: Game.TargetAge?, actualTitle: String, yearReleased: String?, ctx: NSManagedObjectContext) {
        self.operation = CRUDGameOp()
        self.designer = designer
        self.complexity = complexity
        self.targetAge = targetAge
        self.originalTitle = originalTitle
        self.actualTitle = actualTitle
        self.yearReleased = yearReleased
        self.ctx = ctx
    }
    
    func execute() throws{
       let updatedGame = try operation.createGameEntity(designer: self.designer,
                                            complexity: self.complexity,
                                            targetAge: self.targetAge,
                                            title: actualTitle,
                                            yearReleased: self.yearReleased)
        
        if let originalGameCoreData = try operation.getGameCoreData(title: self.originalTitle, ctx: ctx){
            try operation.updateGameCoreData(gameCD: originalGameCoreData, newDataGame: updatedGame, ctx:ctx)
        }
        else{
            throw ErrorModelLogic.notDefined
        }
    }

}
