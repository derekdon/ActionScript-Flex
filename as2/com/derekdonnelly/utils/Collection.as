/*/////////////////////////////////////////////////////////////////
Collection class
Created by: Derek Donnelly
Date: 01/10/2003
*//////////////////////////////////////////////////////////////////

// Import all necessary classes ///////////////////////////////////
import com.derekdonnelly.utils.Utility;
///////////////////////////////////////////////////////////////////

// Define class ///////////////////////////////////////////////////
class com.derekdonnelly.utils.Collection
{ 
	// Define class variable/properties ///////////////////////////
	public static var CLASSNAME:String = "Collection";
	public  var className:String = CLASSNAME;
	//
	private var $name:String;
	private var $elements:Array;
	private var $keys:Array;
	private var $elementCount:Number;
	///////////////////////////////////////////////////////////////
	
	// Class constructor //////////////////////////////////////////	
	public function Collection(newName:String)
	{
		// Capture arguments //////////////////////////////////////
		if(newName != null)
		{
			name = newName;
		}
		///////////////////////////////////////////////////////////
		
		// Set class variables/properties /////////////////////////
		$elements = new Array();
		$keys = new Array();
		$elementCount = 0;
		///////////////////////////////////////////////////////////
	}
	///////////////////////////////////////////////////////////////
	
	// Get the index of a key /////////////////////////////////////
	private function indexOf(key):Number
	{
		// Format key
		key = Utility.removeSpaces(key);
		
		for(var i:Number = 0; i < $elementCount; i++)
		{
			if(key == $keys[i]) return i;
		}
		return -1;
	}
	///////////////////////////////////////////////////////////////
	
	// Add element by key /////////////////////////////////////////
	public function addElement(key, element):Number
	{
		var index:Number = $elements.push(element);
		
		key = (Utility.validateObject(key)) ? Utility.removeSpaces(key) : index.toString();
		
		if(index < 1)
		{
			return -1;
		}
		else
		{
			index = $keys.push(key);
			
			if(index < 1)
			{
				$elements.pop();
				return -1;
			}
			else
			{
				$elementCount++;
				return (index - 1);
			}
		}
	}
	///////////////////////////////////////////////////////////////
	
	// Add element and overwrite any existing match ///////////////
	public function addElementOverwrite(key, element):Number
	{
		var index:Number;
		
		if(Utility.validateObject(key))
		{
			key = Utility.removeSpaces(key);
			index = indexOf(key);
			if(index >= 0) removeElement(key);
			index = $elements.push(element);
		}
		else
		{
			index = $elements.push(element);
			key = index.toString();
		}
		
		if(index < 1) return -1;
		else
		{
			index = $keys.push(key);
			if(index < 1)
			{
				$elements.pop();
				return -1;
			}
			else
			{
				$elementCount++;
				return (index - 1);
			}
		}
	}
	///////////////////////////////////////////////////////////////
	
	// Find item by key ///////////////////////////////////////////
	public function getElement(key):Object
	{
		// Format key
		key = Utility.removeSpaces(key.toString());
		
		var index:Number;
		
		if((index = indexOf(key)) < 0)
		{
			return null;
		}
		else
		{
			return $elements[index];
		}
	}
	///////////////////////////////////////////////////////////////
	
	// Remove item by key /////////////////////////////////////////
	public function removeElement(key):Object
	{
		// Format key
		key = Utility.removeSpaces(key);
		
		var index:Number;
		var retVal:Object = null;
		
		if((index = indexOf(key)) < 0)
		{
			return null;
		}
		else
		{
			retVal = $elements[index];
			$elements.splice(index, 1);
			$keys.splice(index, 1);
			$elementCount--;
			return retVal;
		}
	}
	///////////////////////////////////////////////////////////////
	
	// Get element by index /////////////////////////////////////// 
	public function elementAt(index:Number):Object
	{
		if(index > ($elementCount - 1)) index = ($elementCount - 1);
		return $elements[index];
	}
	///////////////////////////////////////////////////////////////
	
	// Has element ////////////////////////////////////////////////
	public function hasElement(element:Object):Boolean
	{
		// Look for element ///////////////////////////////////////////
		var foundElement:Boolean = false;
		var max:Number = count;
		for(var index:Number = 0; index < max; index++)
		{
			// Check elements /////////////////////////////////////////////
			if(element === $elements[index])
			{
				foundElement = true;
				break;
			}
			///////////////////////////////////////////////////////////////
		}
		///////////////////////////////////////////////////////////////
		
		// Return /////////////////////////////////////////////////////
		return foundElement;
		///////////////////////////////////////////////////////////////
	}
	///////////////////////////////////////////////////////////////
	
	// List value pairs ///////////////////////////////////////////
	public function listValuePairs(objectProp:String):String
	{
		// Define local variables /////////////////////////////////////
		var list:String = "";
		var max:Number = count;
		///////////////////////////////////////////////////////////////
		
		// Get pairs //////////////////////////////////////////////////
		for(var index:Number = 0; index < max; index++)
		{
			var value:String = (objectProp) ? $elements[index][objectProp] : $elements[index];
			list += "KEY:" + $keys[index] + " - VALUE:" + value + "\n";
		}
		///////////////////////////////////////////////////////////////
		
		// Return /////////////////////////////////////////////////////
		return list;
		///////////////////////////////////////////////////////////////
	}
	///////////////////////////////////////////////////////////////

	// GET/SET METHODS ////////////////////////////////////////////
	
	// Get/Set - Name /////////////////////////////////////////////
	public function get name():String
	{
		return $name;
	}	
	public function set name(newString:String):Void
	{
		if(Utility.validateString(newString)) $name = newString;
	}
	///////////////////////////////////////////////////////////////
	
	// Get - elementCount /////////////////////////////////////////
	public function get count():Number
	{
		if($elementCount < 0) $elementCount = 0;		
		return $elementCount;
	}
	///////////////////////////////////////////////////////////////
	
	// Get - Elements /////////////////////////////////////////////
	public function get elements():Array
	{
  		return $elements;
	}
	///////////////////////////////////////////////////////////////
	
	// Get - Keys /////////////////////////////////////////////////
	public function get keys():Array
	{
  		return $keys;
	}
	///////////////////////////////////////////////////////////////
	
	// END OF - GET/SET METHODS ///////////////////////////////////
}
///////////////////////////////////////////////////////////////////