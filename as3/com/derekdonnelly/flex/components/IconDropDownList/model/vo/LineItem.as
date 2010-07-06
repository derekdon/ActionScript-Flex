package com.derekdonnelly.flex.components.IconDropDownList.model.vo
{
	import com.derekdonnelly.flex.components.IconDropDownList.interfaces.ILineItem;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;

	[Bindable(event="propertyChange", type="mx.events.PropertyChangeEvent")]
	public class LineItem 
	extends EventDispatcher
	implements ILineItem
	{
		private var _icon:Class;
		
		[Bindable(event="lineItemUpdated")]
		public function get icon():Class
		{
			return _icon;
		}
		
		private var _text:String;
		
		[Bindable(event="lineItemUpdated")]
		public function get text():String
		{
			return _text;
		}
		
		public function LineItem(icon:Class, text:String)
		{
			_icon = icon;
			_text = text;
			dispatchEvent(new Event("lineItemUpdated"));
		}
		
		override public function toString():String
		{
			return _text;
		}
	}
}