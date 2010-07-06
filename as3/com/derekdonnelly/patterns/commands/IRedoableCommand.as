package com.derekdonnelly.patterns.commands 
{
	public interface IRedoableCommand
	extends ICommand
	{
		function redo():void;
	}
}