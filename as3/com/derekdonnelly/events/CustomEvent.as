package com.derekdonnelly.events
{
	import flash.events.Event;

	public class CustomEvent 
	extends Event
	{
		protected var _customData:Object;
		
		public function CustomEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
        {
            return new CustomEvent(type, bubbles, cancelable);
        }
		
		public function get customData():Object
		{
			return _customData;
		}
		
		public function set customData(val:Object):void
		{
			_customData = val;
		}
	}
}