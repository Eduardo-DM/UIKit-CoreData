//
//  Game.swift
//  UIKitCoreData
//
//  Created by Eduardo Developer on 15/2/23.
//

import Foundation

struct Game: Equatable{
    
    enum Complexity: Int, CaseIterable{
        case casual = 0, easy, medium, hard
    }
    
    enum TargetAge: Int, CaseIterable{
        case babies = 0, children, teenagers, adults
    }
    
    let designer: String?
    let complexity: Complexity?
    let targetAge: TargetAge?
    let title: String
    let yearReleased: UInt16?

    init(designer: String?, complexity: Complexity?, targetAge: TargetAge?, title: String, yearReleased: String?) throws{
        guard title != "" else {
            throw ErrorModelLogic.Game.noTitle
        }
        self.title = title
        self.designer = designer == "" ? nil : designer
        self.complexity = complexity
        self.targetAge = targetAge
        if yearReleased == "" || yearReleased == nil {
            self.yearReleased = nil
        }
        else {
            guard let yearReleased, let yearScalar = UInt16(yearReleased) else {
                throw ErrorModelLogic.Game.yearFieldIsNotANumber
            }
            self.yearReleased = yearScalar
        }
    }
}


extension ErrorModelLogic{
    enum Game: Error{
        case noTitle, yearFieldIsNotANumber
    }
}
