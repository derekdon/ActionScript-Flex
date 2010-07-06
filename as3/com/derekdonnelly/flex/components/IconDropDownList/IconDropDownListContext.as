package com.derekdonnelly.flex.components.IconDropDownList
{
	import flash.display.DisplayObjectContainer;
	import org.robotlegs.core.IInjector;
	import org.robotlegs.utilities.modular.mvcs.ModuleContext;
	
	import com.derekdonnelly.flex.components.IconDropDownList.events.*;
	import com.derekdonnelly.flex.components.IconDropDownList.controller.*;
	import com.derekdonnelly.flex.components.IconDropDownList.view.IconDropDownList;
	import com.derekdonnelly.flex.components.IconDropDownList.view.IconDropDownListMediator;
	import com.derekdonnelly.flex.components.IconDropDownList.model.IconDropDownListModel;
	
	public class IconDropDownListContext 
	extends ModuleContext
	{
		/**
		 * Because this modular style component <b>requires</b> an injector we need to use its constructor to initialize
		 * the context properly.
		 *  
		 * @param contextView
		 * @param injector
		 * 
		 */ 
		public function IconDropDownListContext(contextView:DisplayObjectContainer, injector:IInjector)
		{
			super(contextView, true, injector);
		}
		
		override public function startup():void
		{
			// Map Model classes for injection
			injector.mapSingleton(IconDropDownListModel); // might not be needed if we go the presenter design route?
			
			// Map the mediator
			mediatorMap.mapView(IconDropDownList, IconDropDownListMediator);
			
			// Map commands on the module event bus to also allow external modules to call these commands
			moduleCommandMap.mapEvent(LineItemEvent.ADD, AddLineItemCommand, LineItemEvent);
			moduleCommandMap.mapEvent(LineItemEvent.REMOVE, RemoveLineItemCommand, LineItemEvent);
			moduleCommandMap.mapEvent(LineItemsEvent.SET, SetLineItemsCommand, LineItemsEvent);
			moduleCommandMap.mapEvent(LineItemsEvent.REMOVE_ALL, RemoveAllCommand, LineItemsEvent);
		}
		
		override public function dispose():void
		{
			mediatorMap.removeMediatorByView(contextView);
			super.dispose();
		}
	}
}