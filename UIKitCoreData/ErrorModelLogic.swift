//
//  ModelLogicErrors.swift
//  UIKitCoreData
//
//  Created by Eduardo Developer on 15/2/23.
//

import Foundation

enum ErrorModelLogic: Error, Equatable{
    static func == (lhs: ErrorModelLogic, rhs: ErrorModelLogic) -> Bool {
        lhs.localizedDescription == rhs.localizedDescription
    }
    
    case notDefined
    case systemError(Error)
}
