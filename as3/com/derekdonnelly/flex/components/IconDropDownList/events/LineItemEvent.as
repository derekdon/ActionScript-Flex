package com.derekdonnelly.flex.components.IconDropDownList.events
{
	import com.derekdonnelly.flex.components.IconDropDownList.model.vo.LineItem;
    import flash.events.Event;
    
    public class LineItemEvent 
    extends Event
    {
		public static const ADD:String = "LineItemEvent.ADD";
		public static const ITEM_ADDED:String = "LineItemEvent.ITEM_ADDED";
		public static const REMOVE:String = "LineItemEvent.REMOVE";
		public static const ITEM_REMOVED:String = "LineItemEvent.ITEM_REMOVED";
		
		private var _lineItem:LineItem;
		public function get lineItem():LineItem { return _lineItem; }
		
        public function LineItemEvent(type:String, lineItem:LineItem = null, bubbles:Boolean=false, cancelable:Boolean=false)
        {
			_lineItem = lineItem;
            super(type, bubbles, cancelable);
        }
        
        override public function clone():Event
        {
            return new LineItemEvent(type, lineItem, bubbles, cancelable);
        }
    }
}