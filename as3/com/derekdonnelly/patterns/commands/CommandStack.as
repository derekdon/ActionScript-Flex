package com.derekdonnelly.patterns.commands
{
	import flash.events.EventDispatcher;

	public class CommandStack
	extends EventDispatcher
	{
		private static var _instance:CommandStack;
		private var _commands:Array;
		private var _index:uint;
		
		public function CommandStack()
		{
			_commands = new Array();
			_index = 0;
		}
		
		public function putCommand(command:ICommand, overridePrevious:Boolean = false):void 
		{
			/*
			_index = (overridePrevious) ? _index : _index++;
			_commands[_index] = command;
			_commands.splice(_index, _commands.length - _index);
			if(!overridePrevious)
			{
				dispatchEvent(new CommandStackEvent(CommandStackEvent.COMMAND_ADDED));
				indexChanged();
			}
			*/
			
			
			_commands[_index++] = command;
			_commands.splice(_index, _commands.length - _index);
			dispatchEvent(new CommandStackEvent(CommandStackEvent.COMMAND_ADDED));
			indexChanged();
		}
		
		public function previous():ICommand 
		{
			var command:ICommand = _commands[--_index];
			indexChanged();
			return command;
		}
		
		public function next():ICommand 
		{
			var command:ICommand = _commands[_index++];
			indexChanged();
			return command;
		}

		public function hasPreviousCommands():Boolean 
		{
			return _index > 0;
		}
		
		public function hasNextCommands():Boolean 
		{
			return _index < _commands.length;
		}
		
		private function indexChanged():void
		{
			dispatchEvent(new CommandStackEvent(CommandStackEvent.INDEX_CHANGE));
		}
	}
}