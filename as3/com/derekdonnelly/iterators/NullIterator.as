package com.derekdonnelly.iterators
{
	import com.derekdonnelly.iterators.IIterator;

	public class NullIterator 
	implements IIterator
	{
		public function hasNext():Boolean
		{
			return false;
		}
		
		public function next():Object
		{
			return null;
		}
		
		public function current():Object
		{
			return null;
		}
		
		public function reset():void
		{
		}	
	}
}