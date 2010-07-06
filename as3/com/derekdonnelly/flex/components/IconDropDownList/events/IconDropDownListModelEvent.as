package com.derekdonnelly.flex.components.IconDropDownList.events
{
	import com.derekdonnelly.flex.components.IconDropDownList.model.vo.LineItems;
    import flash.events.Event;
    
    public class IconDropDownListModelEvent 
    extends Event
    {
		public static const UPDATED:String = "IconDropDownListModelEvent.UPDATED";
		
		private var _lineItems:LineItems;
		public function get lineItems():LineItems { return _lineItems; }
		
        public function IconDropDownListModelEvent(type:String, lineItems:LineItems = null, bubbles:Boolean=false, cancelable:Boolean=false)
        {
			_lineItems = lineItems;
            super(type, bubbles, cancelable);
        }
        
        override public function clone():Event
        {
            return new IconDropDownListModelEvent(type, lineItems, bubbles, cancelable);
        }
    }
}