package com.derekdonnelly.flex.components.IconDropDownList.controller
{
	import com.derekdonnelly.flex.components.IconDropDownList.events.LineItemEvent;
	import com.derekdonnelly.flex.components.IconDropDownList.model.IconDropDownListModel;
	import com.derekdonnelly.flex.components.IconDropDownList.presenter.IconDropDownListPresenter;
	import org.robotlegs.utilities.modular.mvcs.ModuleCommand;
	
	public class RemoveAllCommand
	extends ModuleCommand
	{
		[Inject]
		public var model:IconDropDownListModel;
		
		[Inject]
		public var presenter:IconDropDownListPresenter;
		
		override public function execute():void
		{
			//model.removeAll();
			presenter.removeAll();
		}
	}
}