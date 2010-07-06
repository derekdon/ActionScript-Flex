﻿/*/////////////////////////////////////////////////////////////////
PriorityQueue class
Created by: Branden Hall
Upgraded to AS2 and extened by: Derek Donnelly
Date: 22/10/2004 
*//////////////////////////////////////////////////////////////////

// Import all necessary classes ///////////////////////////////////
//import com.derekdonnelly.loaders.AdvancedAssetLoader;
import com.derekdonnelly.utils.Utility;
import com.derekdonnelly.utils.Tracer;
///////////////////////////////////////////////////////////////////

// Define class ///////////////////////////////////////////////////
class com.derekdonnelly.utils.PriorityQueue
{    
	// Define class variable/properties ///////////////////////////
	public static var CLASSNAME:String = "PriorityQueue";
	public  var className:String = CLASSNAME;
	//
	private var $name:String;
	//
	private var $heap:Array;
	private var $map:Object;
	//
	private var $savedState:Object;
	private var $stateSaved:Boolean = false;
	//
	private var $idInc:Number;
	private var $returnDataOnly:Boolean = true;
	//
	private var $elementCount:Number;
	//
	private var $owner:Object;
	private var $compiled:Boolean;
	private var $error:Error;
	///////////////////////////////////////////////////////////////
	
	// Define events //////////////////////////////////////////////
	public static var SAVED:String = "onPriorityQueueSaved";
	public static var REVERTED:String = "onPriorityQueueReverted";
	public static var REMOVED_TOP:String = "onRemoveTop";
	///////////////////////////////////////////////////////////////
	
	// Include AsBroadcaster methods (stops compile errors) ///////
	var broadcastMessage:Function;
	var addListener:Function;
	var removeListener:Function;
	///////////////////////////////////////////////////////////////
	
	// Include Tracer class methods (stops compile errors) ////////
	var debug:Function;
	var debugOn:Function;
	var debugOff:Function;
	///////////////////////////////////////////////////////////////
	
	// Class constructor //////////////////////////////////////////	
	public function PriorityQueue(name:String)
	{
		// Call the constructor of the super class  ///////////////////
		///////////////////////////////////////////////////////////////
		
		// Setup AsBroadcaster ////////////////////////////////////////
		AsBroadcaster.initialize(this); 
		///////////////////////////////////////////////////////////////
		
		// Initialize Tracer Class ////////////////////////////////////
		Tracer.initialize(className, this);
		///////////////////////////////////////////////////////////////
		
		// Capture arguments //////////////////////////////////////////
		this.name = name;
		///////////////////////////////////////////////////////////////

		// Add required listeners /////////////////////////////////////
		///////////////////////////////////////////////////////////////

		// Initialise class ///////////////////////////////////////////
		init();
		///////////////////////////////////////////////////////////////
	}
	///////////////////////////////////////////////////////////////

	// Initialise Class ///////////////////////////////////////////
	public function init(Void):Void
	{
		// Initialise super class /////////////////////////////////////
		//super.init();
		///////////////////////////////////////////////////////////////
		
		// Set class variables/properties /////////////////////////////
		$heap = new Array();
		$map = new Object();
		$elementCount = $idInc = 0;
		$compiled = false;
		//
		$savedState = new Object();
		$stateSaved = false;
		///////////////////////////////////////////////////////////////
		
		// Add required listeners /////////////////////////////////////
		///////////////////////////////////////////////////////////////
	}
	///////////////////////////////////////////////////////////////
	
	// Save state /////////////////////////////////////////////////
	public function saveState(forceSave:Boolean):Void
	{
		// Check state ////////////////////////////////////////////////
		if((forceSave) || (!$stateSaved))
		{		
			// Save queue /////////////////////////////////////////////////
			$savedState = {heap:$heap.slice(), map:Utility.cloneObject($map), idInc:$idInc, elementCount:$elementCount};
			$stateSaved = true;
			///////////////////////////////////////////////////////////////
			
			// Broadcast message //////////////////////////////////////////
			broadcastMessage(SAVED, this);
			///////////////////////////////////////////////////////////////
		}
		///////////////////////////////////////////////////////////////
	}
	///////////////////////////////////////////////////////////////
	
	// Revert /////////////////////////////////////////////////////
	public function revert(Void):Void
	{
		// Check state ////////////////////////////////////////////////
		if(($stateSaved) && ($savedState))
		{
			// Revert to the last saved queue /////////////////////////////
			$heap = $savedState.heap.slice();
			$map = Utility.cloneObject($savedState.map);
			$idInc = $savedState.idInc;
			$elementCount = $savedState.elementCount;
			delete $savedState;
			$stateSaved = false;
			///////////////////////////////////////////////////////////////
			
			// Broadcast message //////////////////////////////////////////
			broadcastMessage(REVERTED, this);
			///////////////////////////////////////////////////////////////
		}
		///////////////////////////////////////////////////////////////
	}
	///////////////////////////////////////////////////////////////
	
	// Re-form the queue after object /////////////////////////////
	public function reFormQueueAfterObject(obj:Object):Boolean
	{
		// Check for object ///////////////////////////////////////////
		if(!hasElement(obj)) return;
		///////////////////////////////////////////////////////////////
		
		// Define local variables /////////////////////////////////////
		var success:Boolean;
		var max:Number = count;
		var topObj:Object;
		///////////////////////////////////////////////////////////////
		
		// Remove the higher priority objects /////////////////////////
		for(var index:Number = 0; index < max; index++)
		{
			// Get the top priority object ////////////////////////////////
			topObj = removeTop();
			///////////////////////////////////////////////////////////////
			
			// Check object ///////////////////////////////////////////////
			if((obj === topObj) || (!topObj))
			{
				success = true;
				break;
			}
			///////////////////////////////////////////////////////////////
		}
		///////////////////////////////////////////////////////////////		
		
		// Return /////////////////////////////////////////////////////
		return success;
		///////////////////////////////////////////////////////////////		
	}
	///////////////////////////////////////////////////////////////
	
	// Insert items into the queue ////////////////////////////////
	public function insert(obj:Object, priority):Number
	{
		// Capture arguments //////////////////////////////////////////
		priority = ((priority == null) || (priority.toString() == "NaN")) ? Number.MAX_VALUE : Number(priority);
		///////////////////////////////////////////////////////////////

		// Validate the Object and its priority ///////////////////////
		if(Utility.validateObject(obj) && Utility.validateNumber(priority))
		{			
			// Define local variables /////////////////////////////////////
			var pos:Number = $heap.length;
			var id:Number = $idInc++;
			///////////////////////////////////////////////////////////////

			// Create an temp object //////////////////////////////////////
			if(Utility.validateObject(obj.data))
			{
				var temp:Object = obj;
				temp.id = id;
				temp.priority = priority;
				temp.pos = pos;
			}
			else
			{
				var temp:Object = {id:id, priority:priority, pos:pos, data:obj};
			}
			///////////////////////////////////////////////////////////////
			
			// Add the element to the queue ///////////////////////////////
			$map[id] = temp;
			$heap[pos] = temp;
			filterUp(pos);
			///////////////////////////////////////////////////////////////
			
			// Update the element amount //////////////////////////////////
			$elementCount++;
			///////////////////////////////////////////////////////////////

			// Return id value ////////////////////////////////////////////
			return id;
			///////////////////////////////////////////////////////////////
		}
		///////////////////////////////////////////////////////////////
	}
	///////////////////////////////////////////////////////////////
	
	// Remove, and return, the top element in the heap ////////////
	public function removeTop(Void)
	{
		// Try ////////////////////////////////////////////////////////
		try
		{
			// Check the queue contains elements //////////////////////////
			if($heap.length <= 0) throw new Error("No elements contained in the PriorityQueue.");
			///////////////////////////////////////////////////////////////

			// Save queue state ///////////////////////////////////////////
			if(!$stateSaved) saveState();
			///////////////////////////////////////////////////////////////
			
			// Define local variables /////////////////////////////////////
			var topElement:Object = ($returnDataOnly) ? $heap[0].data : $heap[0];
			///////////////////////////////////////////////////////////////
			
			// Remove top element from the queue //////////////////////////
			delete $map[$heap[0].id];
			delete $heap[0];
			///////////////////////////////////////////////////////////////
			
			// Assign new top element and clean up heap ///////////////////
			$heap[0] = $heap[$heap.length - 1];
			$heap[0].pos = 0;
			$heap.splice($heap.length - 1, 1);
			///////////////////////////////////////////////////////////////
			
			// Filter queue ///////////////////////////////////////////////
			filterDown(0);
			///////////////////////////////////////////////////////////////
			
			// Update the element amount //////////////////////////////////
			$elementCount--;
			///////////////////////////////////////////////////////////////
			
			// Broadcast message //////////////////////////////////////////
			broadcastMessage(REMOVED_TOP, this, topElement);
			///////////////////////////////////////////////////////////////
			
			// Return top element /////////////////////////////////////////
			return topElement;
			///////////////////////////////////////////////////////////////
		}
		catch(e)
		{
			// Save error information /////////////////////////////////////
			error = e;
			///////////////////////////////////////////////////////////////
			
			// Return /////////////////////////////////////////////////////
			return false;
			///////////////////////////////////////////////////////////////
		}
		///////////////////////////////////////////////////////////////
	}
	///////////////////////////////////////////////////////////////
	
	// Reprioritize an element ////////////////////////////////////
	public function changePriority(id:Number, newPriority:Number, absolute:Boolean):Void
	{
		// Capture arguments //////////////////////////////////////////
		newPriority = Number(newPriority);
		///////////////////////////////////////////////////////////////
		
		// Validate newPriority ///////////////////////////////////////
		if(Utility.validateNumber(newPriority))
		{
			// Define local variables /////////////////////////////////////
			var element:Object = $map[id];
			var pos:Number = element.pos;
			var oldPriority:Number = element.priority;
			///////////////////////////////////////////////////////////////
			
			// Set priority ///////////////////////////////////////////////
			if(absolute) element.priority = newPriority;
			else element.priority += newPriority;
			///////////////////////////////////////////////////////////////
			
			// Filter queue ///////////////////////////////////////////////
			(oldPriority > element.priority) ? filterUp(pos) : filterDown(pos);
			///////////////////////////////////////////////////////////////
		}
		///////////////////////////////////////////////////////////////
	}
	///////////////////////////////////////////////////////////////
	
	// Get element by index (Smart Loading) ///////////////////////
	public function getElementByIndex(index:Number)
	{
		return ($returnDataOnly) ? $heap[index].data : $heap[index];
	}
	///////////////////////////////////////////////////////////////
	
	// Determine if the queue is empty ////////////////////////////
	public function isEmpty(Void):Boolean
	{
		return ($heap.length == 0);
	}
	///////////////////////////////////////////////////////////////
	
	// Get priority of an element /////////////////////////////////
	public function getPriority(id:Number):Number
	{
		return $map[id].priority;
	}
	///////////////////////////////////////////////////////////////
	
	// Get priority of top element ////////////////////////////////
	public function getTopPriority(Void):Number
	{
		return $heap[0].priority;
	}
	///////////////////////////////////////////////////////////////
	
	// Check to see if an ID is in the queue //////////////////////
	public function isQueued(id:Number):Boolean
	{
		return ($map[id] != null);
	}
	///////////////////////////////////////////////////////////////
	
	// Remove an object from the queue ////////////////////////////
	public function remove(id:Number):Boolean
	{
		// Check if an element with the id exists /////////////////////
		if(isQueued(id))
		{
			var index:Number = $map[id].pos;
			delete $map[id];
			delete $heap[index];
			$heap[index] = $heap[$heap.length - 1];
			$heap[0].pos = 0;
			$heap.splice($heap.length - 1, 1);
			
			// Update the element amount //////////////////////////////////
			$elementCount--;
			///////////////////////////////////////////////////////////////

			return true;
		}
		else return false;
		///////////////////////////////////////////////////////////////	
	}
	///////////////////////////////////////////////////////////////
	
	// Helper methods /////////////////////////////////////////////
	private function hasLeft(index:Number):Boolean
	{
		return (2 * index + 1 < ($heap.length));
	}

	private function hasRight(index:Number):Boolean
	{
		return (2 * index + 2 < ($heap.length));
	}

	private function getLeft(index:Number):Number
	{
		return (2 * index + 1);
	}

	private function getRight(index:Number):Number
	{
		return (2 * index + 2);
	}
	///////////////////////////////////////////////////////////////	

	// Filter up the queue ////////////////////////////////////////
	private function filterUp(index:Number):Void
	{
		// Define local variables /////////////////////////////////////
		var i:Number = index;
		///////////////////////////////////////////////////////////////
		
		// Loop throught queue ////////////////////////////////////////
		while((i > 0) && ($heap[int((i - 1) / 2)].priority > $heap[i].priority))
		{
			// Define local variables /////////////////////////////////////
			var parent:Number = Math.floor((i - 1) / 2);
			var temp:Object = $heap[i];
			///////////////////////////////////////////////////////////////
			
			// Move elements //////////////////////////////////////////////
			$heap[i] = $heap[parent];
			$heap[parent] = temp;
			$heap[i].pos = i;
			$heap[parent].pos = parent;
			///////////////////////////////////////////////////////////////
			
			// Set i equal to parent //////////////////////////////////////
			i = parent;
			///////////////////////////////////////////////////////////////
		}
		///////////////////////////////////////////////////////////////
	}
	///////////////////////////////////////////////////////////////
	
	// Filter down the queue //////////////////////////////////////
	private function filterDown(index:Number):Void
	{
		// Define local variables /////////////////////////////////////
		var i:Number = index;
		var left:Number, right:Number, k:Number;
		///////////////////////////////////////////////////////////////
		
		if(i < ($heap.length - 1) / 2)
		{
			left = 2 * i + 1;
			right = 2 * i + 2;
			
			if(right >= $heap.length)
			{
				k = left;
				right = left;
			}
			else 
			{
				if($heap[left].priority < $heap[right].priority)
				{
					k = left;
				}
				else
				{
					if($heap[left].priority == $heap[right].priority)
					{
						if ($heap[left].id < $heap[right].id)
						{
							k = left;
						}
						else
						{
							k = right;
						}
					}
					else
					{
						k = right;
					}
				}
			}
			
			
			if($heap[i].priority > $heap[k].priority)
			{
				var temp = $heap[i];
				$heap[i] = $heap[k];
				$heap[k] = temp;
				$heap[i].pos = i;
				$heap[k].pos = k;
				
				filterDown(k);
			}
			else
			{
				if($heap[i].priority == $heap[k].priority)
				{
					if($heap[i].id > $heap[k].id)
					{
						var temp = $heap[i];
						$heap[i] = $heap[k];
						$heap[k] = temp;
						$heap[i].pos = i;
						$heap[k].pos = k;
						filterDown(k);
					}
				}
			}
		}
	}
	///////////////////////////////////////////////////////////////	

	// Has element ////////////////////////////////////////////////
	public function hasElement(element:Object):Boolean
	{
		// Look for element ///////////////////////////////////////////
		var originalState:Boolean = $returnDataOnly;
		$returnDataOnly = ((element.data != null) && (element.pos != null) && (element.id != null)) ? false : true;
		var foundElement:Boolean = false;
		var max:Number = count;
		for(var index:Number = 0; index < max; index++)
		{
			// Check elements /////////////////////////////////////////////
			var curElement = getElementByIndex(index);
			if((element.name == curElement.name) || (element === curElement))
			{
				foundElement = true;
				break;
			}
			///////////////////////////////////////////////////////////////
		}
		///////////////////////////////////////////////////////////////
		
		// Reset returnDataOnly state /////////////////////////////////
		$returnDataOnly = originalState;
		///////////////////////////////////////////////////////////////
		
		// Return /////////////////////////////////////////////////////
		return foundElement;
		///////////////////////////////////////////////////////////////
	}
	///////////////////////////////////////////////////////////////
	
	// EVENT HANDLERS /////////////////////////////////////////////
	
	//  ///////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////
	
	// END OF - EVENT HANDLERS ////////////////////////////////////

	// GET/SET METHODS ////////////////////////////////////////////

	// Get/Set - Name /////////////////////////////////////////////
	public function get name():String
	{
		return $name;
	}	
	public function set name(newString:String):Void
	{
		if(Utility.validateString(newString))
		{
			$name = newString;
		}
	}
	///////////////////////////////////////////////////////////////

	// Get - stateSaved ///////////////////////////////////////////
	public function get stateSaved():Boolean
	{
		return $stateSaved;
	}	
	///////////////////////////////////////////////////////////////
	
	// Get/Set - returnDataOnly ///////////////////////////////////
	public function get returnDataOnly():Boolean
	{
		return $returnDataOnly;
	}	
	public function set returnDataOnly(bool):Void
	{
		$returnDataOnly = Utility.convertToBoolean(bool);
	}
	///////////////////////////////////////////////////////////////
	
	// Get - elementCount /////////////////////////////////////////
	public function get count():Number
	{
		if($elementCount < 0) $elementCount = 0;		
		return $elementCount;
	}
	///////////////////////////////////////////////////////////////
	
	// Get/Set - Owner ////////////////////////////////////////////
	public function get owner():Object
	{
		return $owner;
	}	
	public function set owner(obj:Object):Void
	{
		if(Utility.validateObject(obj)) $owner = obj;
		else error = new Error("Set - owner");
	}
	///////////////////////////////////////////////////////////////

	// Get/Set - Compiled status //////////////////////////////////
	public function get compiled():Boolean
	{
  		return $compiled;
	}
	public function set compiled(bool):Void
	{
		if(Utility.validateBoolean(Utility.convertToBoolean(bool)))
			$compiled = Utility.convertToBoolean(bool);
		else error = new Error("Set - compiled");
	}
	///////////////////////////////////////////////////////////////
	
	// Get/Set - Error ////////////////////////////////////////////
	public function get error():Error
	{
		return $error;
	}
	public function set error(newError:Error):Void
	{
		$error = newError;
	}
	///////////////////////////////////////////////////////////////
	
	// END OF - GET/SET METHODS ///////////////////////////////////
}
///////////////////////////////////////////////////////////////////