package com.derekdonnelly.utils
{
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import com.derekdonnelly.collections.*;
	
	dynamic public class StepTracker
	extends EventDispatcher
	{
		private var _name:String;
		private var _desc:String;
		private var _events:StringCollection;
		private var _total:uint;
		private var _completed:uint;
		private var _compiled:Boolean = false;

		public function get name():String { return _name; }
		public function set name(v:String):void
		{
			_name = v;
		}
		
		public function get desc():String { return _desc; }	
		public function set desc(v:String):void
		{
			_desc = v;
		}
		
		public function get total():uint { return _total; }	
		public function set total(v:uint):void
		{
			_total = v;
		}
		
		public function get completed():uint { return _completed; }	
		
		public function StepTracker(totalSteps:uint = 0)
		{
			_events = new StringCollection();
			_total = totalSteps;
			_completed = 0;
		}

		public function addEvent(source:*, event:String, willFire:uint = 0):void 
		{
			if((source.addEventListener is Function) && (event.length > 0) && (!_events.hasElement(event)))
			{
				_events.addElement(event);
				_total += willFire;
				source.addEventListener(event, onStepComplete);
			}
		}
		
		public function onStepComplete(e:Event, success:Boolean = true):void
		{
			if(success)
			{
				if(_completed == 0)
				{
					var startEvent:StepTrackerEvent = new StepTrackerEvent(StepTrackerEvent.TRACKER_START);
					dispatchEvent(startEvent);
				}
				
				_completed++;
				
				var progressEvent:StepTrackerEvent = new StepTrackerEvent(StepTrackerEvent.TRACKER_PROGRESS);
				progressEvent.customData = {completed:_completed, total:_total};
				dispatchEvent(progressEvent);
				
				if(_completed >= _total) complete(true);
			}
			else complete(false);
		}
		
		private function complete(c:Boolean = false):void
		{
			var completeEvent:StepTrackerEvent = new StepTrackerEvent(StepTrackerEvent.TRACKER_COMPLETE);
			completeEvent.customData = {compiled:c};
			dispatchEvent(completeEvent);
		}
	}
}