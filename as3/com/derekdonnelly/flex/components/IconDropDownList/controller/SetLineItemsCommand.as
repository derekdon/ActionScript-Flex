package com.derekdonnelly.flex.components.IconDropDownList.controller
{
	import com.derekdonnelly.flex.components.IconDropDownList.events.LineItemsEvent;
	import com.derekdonnelly.flex.components.IconDropDownList.model.IconDropDownListModel;
	import com.derekdonnelly.flex.components.IconDropDownList.presenter.IconDropDownListPresenter;
	import org.robotlegs.utilities.modular.mvcs.ModuleCommand;
	
	public class SetLineItemsCommand
	extends ModuleCommand
	{
		[Inject]
		public var event:LineItemsEvent;
	
		[Inject]
		public var model:IconDropDownListModel;
		
		[Inject]
		public var presenter:IconDropDownListPresenter;
	
		override public function execute():void
		{
			//model.lineItems.items = event.lineItems.items;
			presenter.lineItems.items = event.lineItems.items;
		}
	}
}