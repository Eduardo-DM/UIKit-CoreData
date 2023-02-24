//
//  CRUDGameCreateCommand.swift
//  UIKitCoreData
//
//  Created by Eduardo Developer on 23/2/23.
//

import Foundation
import CoreData

struct CRUDGameCreateInCoreDataCommand: Command {
    
    let ctx: NSManagedObjectContext
    
    var cRUDGameCreate: CRUDGameOp
    
    let designer: String?
    let complexity: Game.Complexity?
    let targetAge: Game.TargetAge?
    let title: String
    let yearReleased: String?
    
    init(cRUDGameCreate: CRUDGameOp, designer: String?, complexity: Game.Complexity?, targetAge: Game.TargetAge?, title: String, yearReleased: String?, ctx: NSManagedObjectContext) {
        self.cRUDGameCreate = cRUDGameCreate
        self.designer = designer
        self.complexity = complexity
        self.targetAge = targetAge
        self.title = title
        self.yearReleased = yearReleased
        self.ctx = ctx
    }
    
    func execute() throws{
        let game = try cRUDGameCreate.createGameEntity(designer: self.designer,
                                            complexity: self.complexity,
                                            targetAge: self.targetAge,
                                            title: title,
                                            yearReleased: self.yearReleased)
        try cRUDGameCreate.checkTitle(game.title, ctx: ctx)
        try cRUDGameCreate.addGameEntityInCoreData(game: game, ctx: ctx)
    }

}
