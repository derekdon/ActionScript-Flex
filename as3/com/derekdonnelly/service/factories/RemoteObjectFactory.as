package com.derekdonnelly.service.factories
{
	import mx.messaging.ChannelSet;
	import mx.messaging.channels.AMFChannel;
	import mx.rpc.remoting.RemoteObject;

	public class RemoteObjectFactory 
	implements IRemoteObjectFactory
	{
		protected var channelSet:ChannelSet;
		 
		public function RemoteObjectFactory(channelSet:ChannelSet=null)
		{
			this.channelSet = channelSet == null ? new ChannelSet() : channelSet;
		}
		
		public function addChannel(id:String, destination:String):void
		{
			var channel:AMFChannel = new AMFChannel(id, destination);
			channelSet.addChannel(channel);
		}
		
		public function getRemoteObjectForService(destination:String, concurrency:String = "multiple", showBusyCursor:Boolean = true, makeObjectsBindable:Boolean = true):RemoteObject
		{
			var service:RemoteObject = new RemoteObject(destination);
			service.channelSet = this.channelSet;
			service.concurrency = concurrency;
			service.showBusyCursor = showBusyCursor;
			service.makeObjectsBindable = true;	
			return service;
		}
		
		public function destroy():void
		{
			this.channelSet = null;
		}
	}
}