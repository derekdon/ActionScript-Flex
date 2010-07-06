package com.derekdonnelly.flex.components.IconDropDownList.presenter
{
	import com.derekdonnelly.flex.components.IconDropDownList.view.IconDropDownList;
	import com.derekdonnelly.flex.components.IconDropDownList.events.LineItemEvent;
	import com.derekdonnelly.flex.components.IconDropDownList.events.LineItemsEvent;
	import com.derekdonnelly.flex.components.IconDropDownList.model.vo.*;
	
	import mx.events.FlexEvent;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.utilities.modular.mvcs.ModuleActor;
	
	public class IconDropDownListPresenter 
	extends ModuleActor
	{
		private var _view:IconDropDownList;
		public function get view():IconDropDownList { return _view; }
		public function set view(v:IconDropDownList):void { _view = v; }
		
		private var _lineItems:LineItems;
		public function get lineItems():LineItems { return _lineItems; }
		
		private var _currentItemSelection:LineItem;
		public function get currentItemSelection():LineItem { return _currentItemSelection; }
		public function set currentItemSelection(v:LineItem):void { _currentItemSelection = v; }
		
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
		
		public function IconDropDownListPresenter()
		{
			_init();
		}
		
		private function _init():void
		{
			_view = new IconDropDownList(); 
			_view.width = 40;  
			_view.height = 30;
			
			_lineItems = new LineItems();
			_currentItemSelection = null;
			
			_view.addEventListener(FlexEvent.PREINITIALIZE, _preinitializeHandler);
			_view.addEventListener(FlexEvent.INITIALIZE, _initializeHandler);  
			_view.addEventListener(FlexEvent.CREATION_COMPLETE, _completeHandler);   
		}
		
		private function _preinitializeHandler(e:FlexEvent):void
		{
			// implememt
			trace("_preinitializeHandler");
		}
		
		private function _initializeHandler(e:FlexEvent):void
		{
			// implememt
			trace("_initializeHandler");
		}
		
		private function _completeHandler(e:FlexEvent):void
		{
			trace("_completeHandler");
		}
	}
}