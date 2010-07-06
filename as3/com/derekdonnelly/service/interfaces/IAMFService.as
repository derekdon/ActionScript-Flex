package com.derekdonnelly.service.interfaces
{
	public interface IAMFService
	{
		function connect(gateway:String):void;
		function isConnected():Boolean;
		function ping():void;
		function disconnect():void;
		function destroy():void;
		function reConnect():void;
		function setCredentials(username:String, password:String):void;
		function set gatewayUrl(val:String):void
	}
}