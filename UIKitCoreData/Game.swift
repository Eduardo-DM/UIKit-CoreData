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
        
        func toEng() -> String{
            switch self{
            case .casual: return "Casual"
            case .easy: return "Easy"
            case .medium: return "Medium"
            case .hard: return "Hard"
            }
        }
    }
    
    enum TargetAge: Int, CaseIterable{
        case babies = 0, children, teenagers, adults
        
        func toEng() -> String{
            switch self{
            case .babies:
                return "Babies"
            case .children:
                return "Children"
            case .teenagers:
                return "Teenagers"
            case .adults:
                return "Adults"
            }
        }
        
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
    
    init (gameCoreData: Games) throws{
        throw (ErrorModelLogic.notDefined)
        guard let title = gameCoreData.title, title != "" else {
            throw ErrorModelLogic.Game.noTitle
        }
        self.title = title
        if let designer = gameCoreData.designer {
            self.designer = designer == "" ? nil : designer
        }
        else{
            self.designer = nil
        }
        if let year = gameCoreData.yearReleased  {
            self.yearReleased = UInt16(truncating: year)
        }
        else{
            self.yearReleased = nil
        }
        if let complexity = gameCoreData.complexity{
            self.complexity = Game.Complexity(rawValue: Int(truncating: complexity))
        }
        else{
            self.complexity = nil
        }
        if let targetAge = gameCoreData.targetAge{
            self.targetAge = Game.TargetAge(rawValue: Int(truncating: targetAge))
        }
        else{
            self.targetAge = nil
        }
    }
    
}


extension ErrorModelLogic{
    enum Game: Error{
        case noTitle, yearFieldIsNotANumber
    }
}
