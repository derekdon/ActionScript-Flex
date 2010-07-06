﻿/*/////////////////////////////////////////////////////////////////
Tracer class
Created by: Derek Donnelly
Date: 05/11/2003
Purpose: Class used to add tracing abilities to class which can be
		 easily identified and switched on and off
*//////////////////////////////////////////////////////////////////

// Define class ///////////////////////////////////////////////////
class com.derekdonnelly.utils.Tracer
{
	// Define class variables/properties //////////////////////////
	public  var classname:String;
	private var $traceable:Boolean;
	///////////////////////////////////////////////////////////////
	
	// Class constructor //////////////////////////////////////////	
	public function Tracer()
	{
		// Do nothing
	}
	///////////////////////////////////////////////////////////////

	// Initialize classes /////////////////////////////////////////
	public static function initialize(classname:String, classObj):Void
	{
		// Configure the classObj /////////////////////////////////
		if((classname != null) && (classObj.classname == null)) classObj[classname] = classname;
		classObj.$traceable = false;
		classObj.debug = Tracer.prototype.debug;
		classObj.debugOn = Tracer.prototype.debugOn;
		classObj.debugOff = Tracer.prototype.debugOff;
		///////////////////////////////////////////////////////////
	}
	///////////////////////////////////////////////////////////////	
	
	// Debug //////////////////////////////////////////////////////	
	private function debug(id:String, msg:String):Void
	{
		// Check if debugging is permitted
		if($traceable)
		{
			trace(classname.toUpperCase() + " : " + id + " : " + msg);
		}
	}
	///////////////////////////////////////////////////////////////	
	
	// Switch debugging ON ////////////////////////////////////////
	private function debugOn(Void):Void
	{
		$traceable = true;
	}
	///////////////////////////////////////////////////////////////	
	
	// Switch debugging OFF ///////////////////////////////////////
	private function debugOff(Void):Void
	{
		$traceable = false;
	}
	///////////////////////////////////////////////////////////////	
}
///////////////////////////////////////////////////////////////////