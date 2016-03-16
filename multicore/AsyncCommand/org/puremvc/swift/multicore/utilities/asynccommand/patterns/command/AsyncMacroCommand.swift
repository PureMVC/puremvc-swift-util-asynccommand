//
//  AsyncMacroCommand.swift
//  PureMVC SWIFT MultiCore Utility – AsyncCommand
//
//  Copyright(c) 2015-2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the Creative Commons Attribution 3.0 License
//

import PureMVC

/**
A base `ICommand` implementation that executes other
`ICommand`s asynchronously.

An `AsyncMacroCommand` maintains a list of
closures returning `ICommand` references called *SubCommands*.

When `execute` is called, the `AsyncMacroCommand`
caches a reference to the `INotification` and calls
`nextCommand`.

If there are still *SubCommands's to be executed,
the `nextCommand` method instantiates and calls `execute`
on each of its *SubCommands* in turn. Each *SubCommand* will be passed
a reference to the original `INotification` that was passed to the
`AsyncMacroCommand`'s `execute` method. If the
*SubCommand* to execute is an `IAsyncCommand`, the
next *SubCommand* will not be executed until the previous
`IAsyncCommand` has called its *commandComplete* method.

Unlike `AsyncCommand` and `SimpleCommand`, your subclass
should not override `execute`, but instead, should
override the `initializeAsyncMacroCommand` method,
calling `addSubCommand` once for each *SubCommand*
to be executed.

`@see org.puremvc.as3.multicore.patterns.command.AsyncCommand AsyncCommand`
*/
public class AsyncMacroCommand: Notifier, IAsyncCommand {
    
    private var subCommands: [() -> ICommand]
    
    private var notification: INotification!
    
    private var _onComplete: (() -> ())?
    
    /**
    Constructor.
    
    You should not need to define a constructor,
    instead, override the `initializeAsyncMacroCommand`
    method.
    
    If your subclass does define a constructor, be
    sure to call `super()`.
    */
    public override init() {
        subCommands = []
        super.init()
        initializeAsyncMacroCommand()
    }
    
    /**
    Initialize the `AsyncMacroCommand`.
    
    In your subclass, override this method to
    initialize the `AsyncMacroCommand`'s *SubCommand*
    list with `ICommand` class references.
    
        // Initialize MyMacroCommand
        override public func initializeAsyncMacroCommand()
        {
            addSubCommand( { FirstCommand() } )
            addSubCommand( { SecondCommand() } )
            addSubCommand { ThirdCommand() } //trailing closure style
        }
    
    Note that *SubCommands* may be any closure returning `ICommand` implementor,
    `AsyncMacroCommand`s, `AsyncCommand`s,
    `MacroCommand`s or `SimpleCommand`s are all acceptable.
    */
    public func initializeAsyncMacroCommand() {}
    
    /**
    Add a *SubCommand*.
    
    The *SubCommands* will be called in First In/First Out (FIFO)
    order.
    
    - parameter closure: reference returning `ICommand`.
    */
    public func addSubCommand(closure: () -> ICommand) {
        subCommands.append(closure)
    }
    
    /**
    Starts execution of this `AsyncMacroCommand`'s *SubCommands*.
    
    The *SubCommands* will be called in First In/First Out (FIFO) order.
    
    - parameter notification: the `INotification` object to be passsed to each *SubCommand*.
    */
    public final func execute(notification: INotification) {
        self.notification = notification
        nextCommand()
    }
    
    /**
    Execute this `AsyncMacroCommand`'s next *SubCommand*.
    
    If the next *SubCommand* is asynchronous, a callback is registered for
    the command completion, else the next command is run.
    */
    private func nextCommand() {
        if !subCommands.isEmpty {
            let closure = subCommands.removeAtIndex(0)
            let commandInstance = closure()
            
            let isAsync = (commandInstance as? AsyncMacroCommand) != nil || (commandInstance as? AsyncCommand) != nil
            
            if isAsync {
                if (commandInstance as? AsyncCommand != nil) {
                    (commandInstance as! AsyncCommand).onComplete = { self.nextCommand() }
                } else if (commandInstance as? AsyncMacroCommand != nil) {
                    (commandInstance as! AsyncMacroCommand).onComplete = { self.nextCommand() }
                }
            }
            
            commandInstance.initializeNotifier(multitonKey!)
            commandInstance.execute(notification)
            
            if !isAsync {
                nextCommand()
            }
        } else {
            onComplete?()
        }
    }
    
    /// Get or set the callback for a parent `AsyncMacroCommand`.
    public var onComplete: (() -> ())? {
        get { return _onComplete }
        set { _onComplete = newValue }
    }
}
