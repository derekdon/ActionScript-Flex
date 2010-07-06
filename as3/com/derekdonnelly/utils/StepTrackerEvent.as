package com.derekdonnelly.utils
{
	import com.derekdonnelly.events.CustomEvent;
	import flash.events.Event;
	
	public class StepTrackerEvent
	extends CustomEvent
	{
		public static const TRACKER_START:String 	= 'StepTrackerEvent.TRACKER_START';
		public static const TRACKER_PROGRESS:String = 'StepTrackerEvent.TRACKER_PROGRESS';
		public static const TRACKER_COMPLETE:String = 'StepTrackerEvent.TRACKER_COMPLETE';
		public static const STEP_COMPLETE:String 	= 'StepTrackerEvent.STEP_COMPLETE'; // Broadcasted by external classes only
		
		public function StepTrackerEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
        {
            super(type, bubbles, cancelable);
        }
		
		override public function clone():Event
        {
            return new StepTrackerEvent(type, bubbles, cancelable);
        }
	}
}