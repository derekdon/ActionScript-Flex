package com.derekdonnelly.patterns.commands
{
	import flash.events.EventDispatcher;

	public class CommandStackOriginal
	extends EventDispatcher
	{
		private static var _instance:CommandStack;
		private var _commands:Array;
		private var _index:uint;
		
		public function CommandStackOriginal(parameter:SingletonEnforcer)
		{
			_commands = new Array();
			_index = 0;
		}
		
		public static function getInstance():CommandStack
		{
			if(_instance == null) 
				_instance = new CommandStack(new SingletonEnforcer());
			return _instance;
		}
		
		public function putCommand(command:ICommand):void 
		{
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
class SingletonEnforcer {}