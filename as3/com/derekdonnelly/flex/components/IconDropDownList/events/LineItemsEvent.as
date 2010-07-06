package com.derekdonnelly.flex.components.IconDropDownList.events
{
	import com.derekdonnelly.flex.components.IconDropDownList.model.vo.LineItems;
    import flash.events.Event;
    
    public class LineItemsEvent 
    extends Event
    {
		public static const SET:String = "LineItemsEvent.SET";	
		public static const UPDATED:String = "LineItemsEvent.UPDATED";
		public static const REMOVE_ALL:String = "LineItemsEvent.REMOVE_ALL";
		public static const SELECTED:String = "LineItemsEvent.SELECTED";
		public static const NONE_SELECTED:String = "LineItemsEvent.NONE_SELECTED";
		
		private var _lineItems:LineItems;
		public function get lineItems():LineItems { return _lineItems; }
		
        public function LineItemsEvent(type:String, lineItems:LineItems = null, bubbles:Boolean=false, cancelable:Boolean=false)
        {
			_lineItems = lineItems;
            super(type, bubbles, cancelable);
        }
        
        override public function clone():Event
        {
            return new LineItemsEvent(type, lineItems, bubbles, cancelable);
        }
    }
}