package com.derekdonnelly.collections
{
	import com.derekdonnelly.iterators.IIterator;
	import com.derekdonnelly.iterators.ArrayIterator;
	import com.derekdonnelly.iterators.ArrayReverseIterator;
	
	//TODO: Sort out this error!
	public class UIntCollection
	implements ICollection
	{
		private var _data:Array;
		
		public function UIntCollection()
		{
			init();
		}
		
		private function init():void
		{
			_data = new Array();
		}
		
		public function clear():void
		{
			init();
		}
		
		public function count():uint
		{
			return _data.length;
		}
		
		public function addElement(v:uint):void
		{
			_data.push(v);
		}
		
		public function hasElement(v:uint):Boolean
		{
			return _data.indexOf(v) > -1;
		}
		
		public function removeElement(v:uint):uint
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