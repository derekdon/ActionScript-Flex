package com.derekdonnelly.patterns.commands
{
	public interface IFilterCommand 
	extends ICommand 
	{
		function clone(element:*, index:int, arr:Array):*
	}
}