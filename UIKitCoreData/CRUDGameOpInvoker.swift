//
//  CRUDGameOpInvoker.swift
//  UIKitCoreData
//
//  Created by Eduardo Developer on 23/2/23.
//

import Foundation

final class CRUDGameOPInvoker {
    
    private var command: Command?
    
    func setCommand(command: Command){
        self.command = command
    }
    
    func run() throws{
        try command?.execute()
    }
}
