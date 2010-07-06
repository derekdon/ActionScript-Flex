package com.derekdonnelly.service
{
	import org.robotlegs.utilities.modular.mvcs.ModuleActor;
	import org.robotlegs.mvcs.Actor;
	import com.derekdonnelly.service.interfaces.IAMFService;
	import org.robotlegs.utilities.loadup.interfaces.IResource;
	import org.robotlegs.utilities.loadup.model.ResourceEventTypes;
	import org.robotlegs.utilities.loadup.events.ResourceEvent;	
	import flash.net.NetConnection;
	import flash.net.Responder;
	import flash.net.ObjectEncoding;
	import flash.events.*;
	
	public class AbstractAMFService
	extends ModuleActor
	implements IAMFService, IResource
	{
		public static var LOADED:String 		= "AbstractAMFService.LOADED";
		public static var LOADING:String 		= "AbstractAMFService.LOADING";
		public static var LOAD_FAILED:String 	= "AbstractAMFService.LOAD_FAILED";
		public static var LOAD_TIMED_OUT:String = "AbstractAMFService.LOAD_TIMED_OUT";
		
		protected var _gatewayUrl:String;
		protected var _nc:NetConnection;
		protected var _res:Responder;
		protected var _refreshRes:Responder;
		protected var _remoteClass:String;
		private   var _loadupEventSent:Boolean;
		
		public function AbstractAMFService()
		{
			NetConnection.defaultObjectEncoding = ObjectEncoding.AMF3;
			init();
		}
		
		protected function init():void
		{
			_nc = new NetConnection();
			_nc.client = this;
			_nc.objectEncoding = ObjectEncoding.AMF3;
			_nc.addEventListener(NetStatusEvent.NET_STATUS, _onNetStatus);
            _nc.addEventListener(SecurityErrorEvent.SECURITY_ERROR, _onSecurityError);
		}
		
		public function get prefix():String
		{
			return (_remoteClass) ? _remoteClass + "." : "";
		}
		
		public function load():void
		{
			if(_gatewayUrl) connect(_gatewayUrl);
			else _sendLoadupEvent(ResourceEvent.RESOURCE_LOAD_FAILED);
		}
		
		public function getResourceEventTypes(value:ResourceEventTypes):ResourceEventTypes
		{
			value.loading = LOADING;
			value.loaded = LOADED;
			value.loadingFailed = LOAD_FAILED;
			value.loadingTimedOut = LOAD_TIMED_OUT;
			return value;
		}
		
		public function connect(gateway:String):void
		{
			_gatewayUrl = gateway;
			_nc.connect(_gatewayUrl);
			_ping();
		}
		
		public function isConnected():Boolean
		{
			return _nc.connected;
		}
		
		public function disconnect():void
		{
			if(isConnected()) _nc.close();
		}
		
		public function destroy():void
		{
			if(isConnected()) _nc.close();
			_nc = null;
			_gatewayUrl = null;
		}
		
		public function reConnect():void
		{
			_nc.connect(_gatewayUrl);
		}
		
		public function set gatewayUrl(val:String):void
		{
			disconnect();
			_gatewayUrl = val;
		}
		
		/* // Not sure where the remote class should be set yet
		public function set remoteClass(val:String):void
		{
			_remoteClass = val;
		}
		*/
		
		// TODO: Change the name of this function
		protected function showMessage(msg:String, mouseEnabled:Boolean = false):void
		{
			trace(msg);
			// TODO: dispatch message
			
			//TODO: Enable mouse after asynchronous operation...
			//this.mouseEnabled = this.mouseChildren = mouseEnabled;
		}
		
		public function setCredentials(username:String, password:String):void
		{
			_nc.addHeader("Credentials", false, {userid:username, password:password});
		}
		
		public function ping():void
		{
			if(_nc && _gatewayUrl) _ping();
		}
		
		protected function _ping():void
		{
			var res:Responder = new Responder(_onPing, _onPingFault);
			_nc.call(prefix + "ping", res);
		}
		
		protected function _onPing(obj:*):void
		{
			_sendLoadupEvent(ResourceEvent.RESOURCE_LOADED);
		}
		
		protected function _onPingFault(obj:*):void
		{
			_sendLoadupEvent(ResourceEvent.RESOURCE_LOAD_FAILED);
		}
		
		protected function _sendLoadupEvent(e:String):void
		{
			if(!_loadupEventSent)
			{
				//dispatchToModules(new ResourceEvent(e, this)); //LoadMonitor needs to be listening to the same event bus
				dispatch(new ResourceEvent(e, this));
			}
			_loadupEventSent = true;
		}
		
		protected function _onResult(obj:*):void
		{
			throw new Error("AbstractGateway.onResult(obj:Object) is an Abstract method and must be overridden.");
		}

		protected function _onFault(obj:*):void
		{
			throw new Error("AbstractGateway.onFault(obj:Object) is an Abstract method and must be overridden.");
		}
		
		protected function _onNetStatus(e:NetStatusEvent):void
		{
			throw new Error("AbstractGateway.onNetStatus(e:NetStatusEvent) is an Abstract method and must be overridden.");
        }

        protected function _onSecurityError(e:SecurityErrorEvent):void
        {
        	throw new Error("AbstractGateway.onSecurityError(e:SecurityErrorEvent) is an Abstract method and must be overridden.");
        }
	}
}