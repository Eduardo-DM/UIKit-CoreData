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
    
    var operation: CRUDGameOp
    
    let designer: String?
    let complexity: Game.Complexity?
    let targetAge: Game.TargetAge?
    let title: String
    let yearReleased: String?
    
    init(designer: String?, complexity: Game.Complexity?, targetAge: Game.TargetAge?, title: String, yearReleased: String?, ctx: NSManagedObjectContext) {
        self.operation = CRUDGameOp()
        self.designer = designer
        self.complexity = complexity
        self.targetAge = targetAge
        self.title = title
        self.yearReleased = yearReleased
        self.ctx = ctx
    }
    
    func execute() throws{
        let game = try operation.createGameEntity(designer: self.designer,
                                            complexity: self.complexity,
                                            targetAge: self.targetAge,
                                            title: title,
                                            yearReleased: self.yearReleased)
        try operation.checkTitle(game.title, ctx: ctx)
        try operation.addGameEntityInCoreData(game: game, ctx: ctx)
    }

}
