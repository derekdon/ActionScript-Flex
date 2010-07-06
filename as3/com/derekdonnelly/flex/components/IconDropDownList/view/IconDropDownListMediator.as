package com.derekdonnelly.flex.components.IconDropDownList.view
{
    import com.derekdonnelly.flex.components.IconDropDownList.events.*;
    //import com.derekdonnelly.flex.components.IconDropDownList.model.IconDropDownListModel;
    import com.derekdonnelly.flex.components.IconDropDownList.model.enums.IconDropDownListState;
	import com.derekdonnelly.events.LoggingEvent;
    
    import mx.managers.FocusManager;
	
    import org.robotlegs.utilities.modular.mvcs.ModuleMediator;
    
    public class IconDropDownListMediator 
    extends ModuleMediator
    {
        [Inject]
        public var view:IconDropDownList;
		
		//[Inject]
		//public var model:IconDropDownListModel;
		
		override public function onRegister():void
		{
			// Log message
			dispatchToModules(new LoggingEvent(LoggingEvent.MESSAGE, IconDropDownListState.ADDED, LoggingEvent.TRACE));
			
			// View event listeners
			
			// Module event listeners
			addModuleListener(LineItemsEvent.UPDATED, _modelUpdateHandler, LineItemsEvent);
			addModuleListener(IconDropDownListEvent.CLOSE, _closeHandler, IconDropDownListEvent);

			// Context event listeners
			
			// Log message
			dispatchToModules(new LoggingEvent(LoggingEvent.MESSAGE, IconDropDownListState.OPENING, LoggingEvent.TRACE));
			
			// Tell anyone listening we're opening
			dispatchToModules(new IconDropDownListEvent(IconDropDownListEvent.OPENING));
			
			// View open
			if(view.open())
			{
				// Update display values
				_refreshUI();
				
				// Log message
				dispatchToModules(new LoggingEvent(LoggingEvent.MESSAGE, IconDropDownListState.OPEN_SUCCESS, LoggingEvent.TRACE));
				
				// Tell anyone listening we opened successfully
				dispatchToModules(new IconDropDownListEvent(IconDropDownListEvent.OPEN_SUCCESS));
			}
			else
			{
				// Log message
				dispatchToModules(new LoggingEvent(LoggingEvent.MESSAGE, IconDropDownListState.OPEN_ERROR, LoggingEvent.TRACE));
				
				// Tell anyone listening we failed to open
				dispatchToModules(new IconDropDownListEvent(IconDropDownListEvent.OPEN_ERROR));
			}
		}
		
		private function _refreshUI():void
		{
		}
		
		private function _modelUpdateHandler(e:LineItemsEvent):void
		{
			view.dataProvider = e.lineItems.items;
		}
		
		private function _closeHandler(e:IconDropDownListEvent):void 
		{
			// Log message
			dispatchToModules(new LoggingEvent(LoggingEvent.MESSAGE, IconDropDownListState.CLOSING, LoggingEvent.TRACE));
			
			// Tell anyone listening we're closing
			dispatchToModules(new IconDropDownListEvent(IconDropDownListEvent.CLOSING));
			
			// Memory dump, assume success
			view.dispose();
			
			// Log message
			dispatchToModules(new LoggingEvent(LoggingEvent.MESSAGE, IconDropDownListState.CLOSE_SUCCESS, LoggingEvent.TRACE));
			
			// Tell anyone listening we closed successfully
			dispatchToModules(new IconDropDownListEvent(IconDropDownListEvent.CLOSE_SUCCESS));
		}
    }
}