package com.derekdonnelly.flex.components.IconDropDownList.events
{
    import flash.events.Event;
    
    public class IconDropDownListEvent 
    extends Event
    {
		// Opening
		public static const OPEN:String = "IconDropDownListEvent.OPEN";
		public static const OPENING:String = "IconDropDownListEvent.OPENING";
		public static const OPEN_SUCCESS:String = "IconDropDownListEvent.OPEN_SUCCESS";
		public static const OPEN_ERROR:String = "IconDropDownListEvent.OPEN_ERROR";
		
		// Closing
		public static const CLOSE:String = "IconDropDownListEvent.CLOSE";
		public static const CLOSING:String = "IconDropDownListEvent.CLOSING";
		public static const CLOSE_SUCCESS:String = "IconDropDownListEvent.CLOSE_SUCCESS";
		public static const CLOSE_ERROR:String = "IconDropDownListEvent.CLOSE_ERROR";
		
        public function IconDropDownListEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(type, bubbles, cancelable);
        }
        
        override public function clone():Event
        {
            return new IconDropDownListEvent(type, bubbles, cancelable);
        }
    }
}