package com.derekdonnelly.commandhistory.controller
{
	import com.derekdonnelly.commandhistory.events.CommandHistoryEvent;
	import com.derekdonnelly.commandhistory.model.CommandHistoryModel;
	import org.robotlegs.utilities.modular.mvcs.ModuleCommand;
	
	public class UndoCommand
	extends ModuleCommand
	{
		[Inject]
		public var event:CommandHistoryEvent;
	
		[Inject]
		public var model:CommandHistoryModel;
	
		override public function execute():void
		{
			model.undo();
		}
	}
}