//
//  AsyncCommand1.swift
//  PureMVC SWIFT Standard Utility – AsyncCommand
//
//  Copyright(c) 2015-2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the Creative Commons Attribution 3.0 License
//

import Foundation
import PureMVC
import AsyncCommand

class AsyncCommand1: AsyncCommand {
    
    var resource: Resource?
    
    override func execute(notification: INotification) {
        resource = notification.body as? Resource
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.2 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
            self.resource?.i += 1;
            self.onComplete?()
        })
    }
    
    deinit {
        resource?.released += 1
    }

}