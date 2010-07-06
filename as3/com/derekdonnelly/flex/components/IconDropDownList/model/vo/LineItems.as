package com.derekdonnelly.flex.components.IconDropDownList.model.vo
{
	import com.derekdonnelly.flex.components.IconDropDownList.model.vo.LineItem;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class LineItems 
	extends EventDispatcher
	{
		[ArrayElementType("com.derekdonnelly.flex.components.IconDropDownList.model.vo.LineItem")]
		private var _items:ArrayCollection;

		public function get items():ArrayCollection
		{
			if(!_items)
				_items = new ArrayCollection();
			
			return _items;
		}

		public function set items(v:ArrayCollection):void
		{
			_items = v;
			dispatchEvent(new Event("lineItemsUpdated"));
		}
		
		public function addItem(item:LineItem, allowDuplicates:Boolean = false):void
		{
			if(!allowDuplicates)
			{
				for each(var existingItem:LineItem in _items)
				{
					if(item.text == existingItem.text) // TODO: Strong type checking
					{
						dispatchEvent(new Event("lineItemsUpdated"));
						return;
					}
				}
			}
			_items.addItem(item);
			dispatchEvent(new Event("lineItemsUpdated"));
		}
		
		public function removeItem(item:LineItem):void
		{
			var itemIndex:int = _items.getItemIndex(item);
			if(itemIndex > -1)
				_items.removeItemAt(itemIndex);
			dispatchEvent(new Event("lineItemsUpdated"));
		}
	}
}