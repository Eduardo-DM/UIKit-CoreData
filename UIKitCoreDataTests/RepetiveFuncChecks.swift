//
//  RepetiveFuncChecks.swift
//  UIKitCoreDataTests
//
//  Created by Eduardo Developer on 23/2/23.
//

import XCTest
import Foundation
@testable import UIKitCoreData

func equals (gameCD: Games, game: Game){
    XCTAssertEqual(gameCD.title, game.title)
    XCTAssertEqual(gameCD.designer, game.designer)
    let convertedYear: UInt16? = gameCD.yearReleased == nil ? nil : UInt16(truncating: gameCD.yearReleased!)
    XCTAssertEqual( convertedYear, game.yearReleased)
    let convertedComplexity: Int? = gameCD.complexity == nil ? nil : Int(truncating: gameCD.complexity!)
    XCTAssertEqual( convertedComplexity, game.complexity?.rawValue)
    let convertedTargetAge: Int? = gameCD.targetAge == nil ? nil : Int(truncating: gameCD.targetAge!)
    XCTAssertEqual( convertedTargetAge, game.targetAge?.rawValue)
}
