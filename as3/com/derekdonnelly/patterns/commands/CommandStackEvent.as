package com.derekdonnelly.patterns.commands
{
	import com.derekdonnelly.events.CustomEvent;
	import flash.events.Event;
	
	public class CommandStackEvent
	extends CustomEvent
	{
		public static const COMMAND_ADDED:String 	= 'CommandStackEvent.COMMAND_ADDED';
		public static const COMMAND_REMOVED:String 	= 'CommandStackEvent.COMMAND_REMOVED';
		public static const INDEX_CHANGE:String 	= 'CommandStackEvent.INDEX_CHANGE';
		
		// What about adding an undoAvailable, redo etc to keep encapulsation?
		
		public function CommandStackEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
        {
            super(type, bubbles, cancelable);
        }
		
		override public function clone():Event
        {
            return new CommandStackEvent(type, bubbles, cancelable);
        }
	}
}