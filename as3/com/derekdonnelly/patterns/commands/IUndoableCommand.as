package com.derekdonnelly.patterns.commands
{
	public interface IUndoableCommand 
	extends ICommand 
	{
		function undo():void;
	}
}