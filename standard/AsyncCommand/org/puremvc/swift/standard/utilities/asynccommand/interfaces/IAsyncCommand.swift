//
//  IAsyncCommand.swift
//  PureMVC SWIFT Standard Utility – AsyncCommand
//
//  Copyright(c) 2015-2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the Creative Commons Attribution 3.0 License
//

import PureMVC

/**
Interface for an Asynchronous Command.
*/
public protocol IAsyncCommand: ICommand {
    
    /**
    Registers the callback for a parent `AsyncMacroCommand`.
    *
    :param: value	The `AsyncMacroCommand` method to call on completion
    */
    var onComplete: (() -> ())? { get set }
}