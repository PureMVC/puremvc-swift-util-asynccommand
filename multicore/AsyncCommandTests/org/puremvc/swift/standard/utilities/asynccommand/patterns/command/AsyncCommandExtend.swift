//
//  AsyncCommandExtend.swift
//  PureMVC SWIFT Standard Utility – AsyncCommand
//
//  Copyright(c) 2015-2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the Creative Commons Attribution 3.0 License
//

import AsyncCommand

class AsyncCommandExtend: AsyncCommand {
    
    var resource: Resource?
    
    deinit {
        resource?.i = 1
    }
    
}