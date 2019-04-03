//
//  AsyncCommand.swift
//  PureMVC SWIFT Standard Utility – AsyncCommand
//
//  Copyright(c) 2015-2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the Creative Commons Attribution 3.0 License
//

import PureMVC

/**
A base `IAsyncCommand` implementation.
*

Your subclass should override the `execute`
method where your business logic will handle the `INotification`. 
*
@see org.puremvc.swift.multicore.utilities.asynccommand.patterns.command.AsyncMacroCommand AsyncMacroCommand
*/
open class AsyncCommand: SimpleCommand, IAsyncCommand {
    
    private var _onComplete: (() -> ())?
    
    /// Constructor.
    public override init() {}
    
    /**
    Registers the callback for a parent `AsyncMacroCommand`.
    *
    - parameter value: The `AsyncMacroCommand` method to call on completion
    */
    public var onComplete: (() -> ())? {
        get { return _onComplete }
        set { _onComplete = newValue }
    }
    
    /**
    Notify the parent `AsyncMacroCommand` that this command is complete.
    
    Call this method from your subclass to signify that your asynchronous command
    has finished.
    */
    public func commandComplete() {
        onComplete?()
    }
    
}
