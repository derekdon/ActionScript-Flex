package com.derekdonnelly.collections
{
	import com.derekdonnelly.iterators.IIterator;
	
	public interface ICollection
	{	
		function iterator(type:String):IIterator;
		function clear():void;
		function count():uint;
		/*
		function addElement(v:*):void;
		function hasElement(v:*):Boolean;
		function removeElement(v:*):*;
		*/
	}
}