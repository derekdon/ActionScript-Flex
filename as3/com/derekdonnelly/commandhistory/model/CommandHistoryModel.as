package com.derekdonnelly.commandhistory.model
{
	import com.derekdonnelly.collections.CommandStackCollection;
	import com.derekdonnelly.commandhistory.events.CommandHistoryEvent;
	import com.derekdonnelly.commandhistory.model.enums.CommandHistoryState;
	import com.derekdonnelly.patterns.commands.*;
	
	import org.robotlegs.utilities.modular.mvcs.ModuleActor;
	
	[Event(name="CommandHistoryEvent.ADD_STACK_SUCCESS", type="com.derekdonnelly.commandhistory.events.CommandHistoryEvent")]
	[Event(name="CommandHistoryEvent.ADD_STACK_ERROR", type="com.derekdonnelly.commandhistory.events.CommandHistoryEvent")]
	[Event(name="CommandHistoryEvent.REMOVE_STACK_SUCCESS", type="com.derekdonnelly.commandhistory.events.CommandHistoryEvent")]
	[Event(name="CommandHistoryEvent.REMOVE_STACK_ERROR", type="com.derekdonnelly.commandhistory.events.CommandHistoryEvent")]
	[Event(name="CommandHistoryEvent.ADD_COMMAND_SUCCESS", type="com.derekdonnelly.commandhistory.events.CommandHistoryEvent")]
	[Event(name="CommandHistoryEvent.INDEX_CHANGED", type="com.derekdonnelly.commandhistory.events.CommandHistoryEvent")]
	
	public class CommandHistoryModel 
	extends ModuleActor
	{
		private var _commandStacks:CommandStackCollection;
		private var _currentStack:CommandStack;
		
		public function get currentStack():CommandStack
		{
			return _currentStack;
		}

		public function addCommand(command:ICommand, replaceNeighbours:Boolean = false):void
		{
			if(_currentStack == null)
				addCommandStack(new CommandStack(), true);
			
			_currentStack.putCommand(command);
			
			/*
			
			// Get previous command for inspection
			if(_currentStack.hasPreviousCommands())
			{
				var previousCommand:ICommand = _currentStack.previous();
			}
			
			// Check if the last command type was the same as the pending command
			if(previousCommand)
			{
				trace("previousCommand is command = " + (previousCommand.name == command.name));
				
				var matchingNeighbours:Boolean = (previousCommand.name == command.name);
				_currentStack.putCommand(command, (replaceNeighbours && matchingNeighbours));
			}
			else
			{
				_currentStack.putCommand(command);
			}
			*/
		}
		
		public function addCommandStack(stack:CommandStack, asCurrent:Boolean = false):CommandStack
		{
			if(!_addCommandStack(stack))
			{
				dispatchToModules(new CommandHistoryEvent(CommandHistoryEvent.ADD_STACK_ERROR, CommandHistoryState.NOT_STACK));
				return null;
			}
			stack.addEventListener(CommandStackEvent.COMMAND_ADDED, _commandAddedHandler);
			stack.addEventListener(CommandStackEvent.INDEX_CHANGE, _commandStackIndexChangedHandler);
			if(asCurrent) _currentStack = stack;			
			dispatchToModules(new CommandHistoryEvent(CommandHistoryEvent.ADD_STACK_SUCCESS, CommandHistoryState.ADD_STACK_SUCCESS));
			return stack;
		}
		
		public function removeCommandStack(stack:CommandStack):CommandStack
		{
			if(!_removeCommandStack(stack))
			{
				dispatchToModules(new CommandHistoryEvent(CommandHistoryEvent.REMOVE_STACK_ERROR, CommandHistoryState.NOT_STACK));
				return null;
			}
			stack.removeEventListener(CommandStackEvent.COMMAND_ADDED, _commandAddedHandler);
			stack.removeEventListener(CommandStackEvent.INDEX_CHANGE, _commandStackIndexChangedHandler);
			if(_currentStack === stack) _currentStack = null;
			dispatchToModules(new CommandHistoryEvent(CommandHistoryEvent.REMOVE_STACK_SUCCESS, CommandHistoryState.REMOVE_STACK_SUCCESS));
			return stack;
		}
		
		public function undo():void
		{
			if(_currentStack == null) return;
			if(_currentStack.hasPreviousCommands())
			{
				var command:ICommand = _currentStack.previous();
				if(command is IUndoableCommand)
					IUndoableCommand(command).undo();
			}
		}
		
		public function redo():void
		{
			if(_currentStack == null) return;
			if(_currentStack.hasNextCommands())
			{
				var command:ICommand = _currentStack.next();
				if(command is IRedoableCommand)
					IRedoableCommand(command).redo();
			}
		}
		
		public function CommandHistoryModel()
		{
			_init();
		}
		
		private function _init():void
		{
			_commandStacks = new CommandStackCollection();
		}
		
		private function _addCommandStack(stack:CommandStack):Boolean
		{
			if(stack is CommandStack)
			{
				_commandStacks.addElement(stack);
				return true;
			}
			return false;
		}
		
		private function _removeCommandStack(stack:CommandStack):Boolean
		{
			if(stack is CommandStack)
			{
				_commandStacks.removeElement(stack);
				return true;
			}
			return false;
		}
		
		private function _commandAddedHandler(e:CommandStackEvent):void
		{
			dispatchToModules(new CommandHistoryEvent(CommandHistoryEvent.ADD_COMMAND_SUCCESS, CommandHistoryState.ADD_COMMAND_SUCCESS));
		}
		
		private function _commandStackIndexChangedHandler(e:CommandStackEvent):void
		{
			dispatchToModules(new CommandHistoryEvent(CommandHistoryEvent.INDEX_CHANGED, CommandHistoryState.INDEX_CHANGED));
		}
	}
}