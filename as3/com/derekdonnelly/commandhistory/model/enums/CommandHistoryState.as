package com.derekdonnelly.commandhistory.model.enums
{
	public class CommandHistoryState
	{
		// Default
		public static const NONE:String = "";
		
		// Adding Commands
		public static const ADDING_COMMAND:String = "adding command to command history";
		public static const ADD_COMMAND_SUCCESS:String = "command added to command history";
		public static const ADD_COMMAND_ERROR:String = "error adding command to command history";
		
		// Adding Command Stacks
		public static const ADDING_STACK:String = "adding command stack to command history";
		public static const ADD_STACK_SUCCESS:String = "command stack added to command history";
		public static const ADD_STACK_ERROR:String = "error adding command stack to command history";
		
		// Removing Command Stacks
		public static const REMOVING_STACK:String = "removing command stack from command history";
		public static const REMOVE_STACK_SUCCESS:String = "command stack removed from command history";
		public static const REMOVE_STACK_ERROR:String = "error removing command stack from command history";
		
		// Index changed
		public static const INDEX_CHANGED:String = "command history index changed";
		
		/*
		// Clearing
		public static const CLEARING:String = "clearing command history";
		public static const CLEAR_SUCCESS:String = "command history cleared";
		public static const CLEAR_ERROR:String = "error clearing command history";
		
		// Saving
		public static const SAVING:String = "saving command history";
		public static const SAVE_SUCCESS:String = "command history saved";
		public static const SAVE_ERROR:String = "error saving command history";
		
		// Retriving
		public static const RETRIVING:String = "retriving command history";
		public static const RETRIVE_SUCCESS:String = "command history retrived";
		public static const RETRIVE_ERROR:String = "error retriving command history";
		
		// Updating
		public static const UPDATING:String = "updating command history";
		public static const UPDATE_SUCCESS:String = "command history updated";
		public static const UPDATE_ERROR:String = "error updating command history";

		// Errors
		public static const NOT_FOUND:String = "the command history was not found";
		*/
		
		// Errors
		public static const NOT_STACK:String = "not a command stack";
	}
}