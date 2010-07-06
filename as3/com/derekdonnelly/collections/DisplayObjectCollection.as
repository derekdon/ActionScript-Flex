package com.derekdonnelly.collections
{
	import com.derekdonnelly.iterators.IIterator;
	import com.derekdonnelly.iterators.ArrayIterator;
	import com.derekdonnelly.iterators.ArrayReverseIterator;
	import flash.display.DisplayObject;
	
	public class DisplayObjectCollection
	implements ICollection
	{
		private var _data:Array;
		
		public function DisplayObjectCollection()
		{
			_data = new Array();
		}
		
		public function addElement(v:DisplayObject):void
		{
			_data.push(v);
		}
		
		public function hasElement(v:DisplayObject):Boolean
		{
			return _data.indexOf(v) > -1;
		}
		
		public function removeElement(v:DisplayObject):DisplayObject
		{
			var vIndex:Number = _data.indexOf(v);
			var remove:Boolean = vIndex > -1;
			if(remove) _data.splice(vIndex, 1);
			return remove ? v : undefined;
		}
		
		public function iterator(type:String):IIterator
		{
			switch(type)
            {
                case "ArrayReverseIterator":
                	return new ArrayReverseIterator(_data);
                    break;
                default:
                	return new ArrayIterator(_data);
                    break;
            }
		}
	}
}