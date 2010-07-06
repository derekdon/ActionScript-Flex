package com.derekdonnelly.commandhistory.events
{
	import com.derekdonnelly.patterns.commands.CommandStack;
	import com.derekdonnelly.patterns.commands.ICommand;
	
	import flash.events.Event;
    
    public class CommandHistoryEvent 
    extends Event
    {
		// Undo/Redo
		public static const UNDO:String = "CommandHistoryEvent.UNDO";
		public static const REDO:String = "CommandHistoryEvent.REDO";
	
		// Adding Commands
		public static const ADD_COMMAND:String = "CommandHistoryEvent.ADD_COMMAND";
		public static const ADDING_COMMAND:String = "CommandHistoryEvent.ADDING_COMMAND";
		public static const ADD_COMMAND_SUCCESS:String = "CommandHistoryEvent.ADD_COMMAND_SUCCESS";
		public static const ADD_COMMAND_ERROR:String = "CommandHistoryEvent.ADD_COMMAND_ERROR";
		
		// Adding Command Stacks
		public static const ADD_STACK:String = "CommandHistoryEvent.ADD_STACK";
		public static const ADDING_STACK:String = "CommandHistoryEvent.ADDING_STACK";
		public static const ADD_STACK_SUCCESS:String = "CommandHistoryEvent.ADD_STACK_SUCCESS";
		public static const ADD_STACK_ERROR:String = "CommandHistoryEvent.ADD_STACK_ERROR";
		
		// Removing Command Stacks
		public static const REMOVE_STACK:String = "CommandHistoryEvent.REMOVE_STACK";
		public static const REMOVING_STACK:String = "CommandHistoryEvent.REMOVING_STACK";
		public static const REMOVE_STACK_SUCCESS:String = "CommandHistoryEvent.REMOVE_STACK_SUCCESS";
		public static const REMOVE_STACK_ERROR:String = "CommandHistoryEvent.REMOVE_STACK_ERROR";
		
		// Removing
		/*
		public static const REMOVE:String = "CommandHistoryEvent.REMOVE";
		public static const REMOVING:String = "CommandHistoryEvent.REMOVING";
		public static const REMOVE_SUCCESS:String = "CommandHistoryEvent.REMOVE_SUCCESS";
		public static const REMOVE_ERROR:String = "CommandHistoryEvent.REMOVE_ERROR";
		*/
		
		// Index changed
		public static const INDEX_CHANGED:String = "CommandHistoryEvent.INDEX_CHANGED";
		
		/*
		// Clearing
		public static const CLEAR:String = "CommandHistoryEvent.CLEAR";
		public static const CLEARING:String = "CommandHistoryEvent.CLEARING";
		public static const CLEAR_SUCCESS:String = "CommandHistoryEvent.CLEAR_SUCCESS";
		public static const CLEAR_ERROR:String = "CommandHistoryEvent.CLEAR_ERROR";
		
		// Saving
		public static const SAVE:String = "CommandHistoryEvent.SAVE";
		public static const SAVING:String = "CommandHistoryEvent.SAVING";
		public static const SAVE_SUCCESS:String = "CommandHistoryEvent.SAVE_SUCCESS";
		public static const SAVE_ERROR:String = "CommandHistoryEvent.SAVE_ERROR";
		
		// Retriving
		public static const RETRIVE:String = "CommandHistoryEvent.RETRIVE";
		public static const RETRIVING:String = "CommandHistoryEvent.RETRIVING";
		public static const RETRIVE_SUCCESS:String = "CommandHistoryEvent.RETRIVE_SUCCESS";
		public static const RETRIVE_ERROR:String = "CommandHistoryEvent.RETRIVE_ERROR";
		*/

		private var _message:String;
		public function get message():String { return _message; }
		
		private var _command:ICommand;
		public function get command():ICommand { return _command; }
				
		private var _replaceNeighbours:Boolean;
		public function get replaceNeighbours():Boolean { return _replaceNeighbours; }
		
		private var _stack:CommandStack;
		public function get stack():CommandStack { return _stack; }
		
        public function CommandHistoryEvent(type:String, message:String = null, command:ICommand = null, replaceNeighbours:Boolean = false, stack:CommandStack = null, bubbles:Boolean=false, cancelable:Boolean=false)
        {
			_message = message;
			_command = command;
			_stack = stack;
			_replaceNeighbours = replaceNeighbours;
            super(type, bubbles, cancelable);
        }
        
        override public function clone():Event
        {
            return new CommandHistoryEvent(type, message, command, replaceNeighbours, stack, bubbles, cancelable);
        }
    }
}