package com.derekdonnelly.flex.components.IconDropDownList.model
{
	import com.derekdonnelly.flex.components.IconDropDownList.events.LineItemEvent;
	import com.derekdonnelly.flex.components.IconDropDownList.events.LineItemsEvent;
	import com.derekdonnelly.flex.components.IconDropDownList.model.vo.*;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.utilities.modular.mvcs.ModuleActor;
	
	public class IconDropDownListModel 
	extends ModuleActor
	{
		private var _lineItems:LineItems;
		private var _currentItemSelection:LineItem;
		
		public function get lineItems():LineItems
		{
			return _lineItems;
		}
		
		public function get currentItemSelection():LineItem
		{
			return _currentItemSelection;
		}

		public function set currentItemSelection(v:LineItem):void
		{
			_currentItemSelection = v;
		}
		
		public function addItem(item:LineItem):void
		{
			lineItems.addItem(item);
			
			dispatchToModules(new LineItemEvent(LineItemEvent.ITEM_ADDED, item));
			dispatchToModules(new LineItemsEvent(LineItemsEvent.UPDATED, lineItems));
		}
		
		public function removeItem(item:LineItem):void
		{
			lineItems.removeItem(item);
			
			dispatchToModules(new LineItemEvent(LineItemEvent.ITEM_REMOVED, item));
			dispatchToModules(new LineItemsEvent(LineItemsEvent.UPDATED, lineItems));
		}
		
		public function removeAll():void
		{
			_init();
			dispatchToModules(new LineItemsEvent(LineItemsEvent.NONE_SELECTED, lineItems));
			dispatchToModules(new LineItemsEvent(LineItemsEvent.UPDATED, lineItems));
		}
		
		public function IconDropDownListModel()
		{
			_init();
		}
		
		private function _init():void
		{
			_lineItems = new LineItems();
			_currentItemSelection = null;
		}
	}
}