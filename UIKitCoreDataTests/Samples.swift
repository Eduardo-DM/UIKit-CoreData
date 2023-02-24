//
//  SampleTests.swift
//  UIKitCoreDataTests
//
//  Created by Eduardo Developer on 23/2/23.
//

import Foundation
@testable import UIKitCoreData

// MARK: - game1
let title1 = "Le Havre"
let designer1 = "Uwe Rosenberg"
let complexity1 = Game.Complexity.medium
let targetAge1 = Game.TargetAge.adults
let yearPublishing1 = "2008"
let game1 = try! Game(designer: designer1, complexity: complexity1, targetAge: targetAge1, title: title1, yearReleased: yearPublishing1)

// MARK: - game2
let title2 = "Sagrada"
let game2 = try! Game(designer: nil, complexity: nil, targetAge: nil, title: title2, yearReleased: nil)
