/*/////////////////////////////////////////////////////////////////
Utility class
Created by: Derek Donnelly | www.retinalstorm.com | derek@retinalstorm.com
Date: 31/07/2004
*//////////////////////////////////////////////////////////////////

// Import all necessary classes ///////////////////////////////////
import com.derekdonnelly.utils.Tracer;
import com.derekdonnelly.utils.Collection;
///////////////////////////////////////////////////////////////////

// Define class ///////////////////////////////////////////////////
class com.derekdonnelly.utils.Utility
{
	// Define class vars //////////////////////////////////////////
	private var $e:Error;
	public var debug:Function; // Debug function in the Tracer 
	///////////////////////////////////////////////////////////////
	
	// Class initialization ///////////////////////////////////////	
	function Utility()
	{
		Tracer.initialize("Utility", this); // Setup tracer
	}
	///////////////////////////////////////////////////////////////
		
	// Remove spaces //////////////////////////////////////////////
	public static function removeSpaces(string_str:String, spaceChar:String, lowerCase:Boolean):String
	{
		// Define local variables /////////////////////////////////
		spaceChar = (spaceChar != null) ? spaceChar : "_";
		string_str = string_str.toString();
		lowerCase = (lowerCase == null) ? true : lowerCase; 
		///////////////////////////////////////////////////////////
		
		// Convert the passed string to lowercase if required /////
		if(lowerCase) string_str = string_str.toLowerCase();
		///////////////////////////////////////////////////////////
		
		// Optimized return ///////////////////////////////////////
		if(string_str.indexOf(" ") == -1) return string_str;
		//if((string_str.length < 2) && ((string_str != " ") || (string_str != ""))) return string_str;
		///////////////////////////////////////////////////////////
		
		// Trim the string ////////////////////////////////////////
		string_str = trimString(string_str);
		///////////////////////////////////////////////////////////
		
		// Define a new array and split the string everywere we find a space.
		// These split words then get added to the splits_array.
		var splits_array:Array = string_str.split(" ");
		
		// Clear the string_str before recreating it
		string_str = ""; 
	
		// Get the maximum length of the splits_array
		var maxSplits:Number = splits_array.length;
		
		// For each word in the splits array, create the new string
		for(var splitCount:Number = 0; splitCount < maxSplits; splitCount++)
		{
			if(splitCount == 0) // On the first loop so we don't want to add an underscore
			{
				string_str = splits_array[splitCount];	
			}
			else // This isn't the first loop, so add a underscore between the strings
			{
				string_str = string_str + spaceChar + splits_array[splitCount];
			}
		}
		///////////////////////////////////////////////////////////////

		// Return /////////////////////////////////////////////////////
		return string_str;
		///////////////////////////////////////////////////////////////
	}
	///////////////////////////////////////////////////////////////

	// Trim leading and trailing spaces/characters ////////////////
	public static function trimString(source:String, chars):String
	{	
		// Define local variables /////////////////////////////////////
		var index:Number = 0;
		var charsToTrim:Object = new Object();
		///////////////////////////////////////////////////////////////

		// Validate chars /////////////////////////////////////////////
		if(chars == null) charsToTrim[" "] = " ";
		else
		{
			if(chars.constructor == String) charsToTrim[chars] = chars;
			else if(chars.constructor == Array) charsToTrim = createObjectFromArray(chars);
			else if(chars.constructor == Object) charsToTrim = chars;
			
			charsToTrim[" "] = " ";
		}
		///////////////////////////////////////////////////////////////
		
		// Remove leading spaces/characters ///////////////////////////
		var trim:Boolean = true;
		while(trim)
		{
			// Get character //////////////////////////////////////////////
			var char:String = source.charAt(index);
			if((charsToTrim[char] == null) || (index > source.length)) trim = false;			
			else index++;
			///////////////////////////////////////////////////////////////
		}
		///////////////////////////////////////////////////////////////
		
		// Trim source ////////////////////////////////////////////////
		source = source.substr(index);
		///////////////////////////////////////////////////////////////
		
		// Set index //////////////////////////////////////////////////
		index = source.length - 1;
		///////////////////////////////////////////////////////////////
		
		// Remove trailing spaces/characters //////////////////////////
		var trim:Boolean = true;
		while(trim)
		{
			// Get character //////////////////////////////////////////////
			var char:String = source.charAt(index);
			if((charsToTrim[char] == null) || (index < 0)) trim = false;			
			else index--;
			///////////////////////////////////////////////////////////////
		}
		///////////////////////////////////////////////////////////////
		
		// Trim source ////////////////////////////////////////////////
		source = source.substr(0, index + 1);
		///////////////////////////////////////////////////////////////
		
		// Return /////////////////////////////////////////////////////
		return source;
		///////////////////////////////////////////////////////////////
	}
	///////////////////////////////////////////////////////////////
	
	// Format numbers /////////////////////////////////////////////
	public static function formatNumbers(number):String
	{	
		// Define local variables /////////////////////////////////////
		var tempNumber_str:String = number.toString();
		///////////////////////////////////////////////////////////////
		
		// Check number ///////////////////////////////////////////////
		if(((number < 10) && (number >= 0)) && (tempNumber_str.length == 1)) tempNumber_str = "0" + tempNumber_str;
		///////////////////////////////////////////////////////////////

		// Return /////////////////////////////////////////////////////
		return tempNumber_str;
		///////////////////////////////////////////////////////////////
	}
	///////////////////////////////////////////////////////////////
	
	// Check if the mouse is within bounds of a clip //////////////
	public static function mouseWithinBounds(scope:MovieClip, target:MovieClip, bounds:Object):Boolean
	{
		// Define local variables /////////////////////////////////////
		scope = (scope) ? scope : target._parent;
		bounds = (bounds) ? bounds : target.getBounds(scope);
		///////////////////////////////////////////////////////////////
		
		// Check bounds ///////////////////////////////////////////////
		return (((scope._ymouse >= bounds.yMin) && (scope._ymouse <= bounds.yMax)) && ((scope._xmouse >= bounds.xMin) && (scope._xmouse <= bounds.xMax)));
		///////////////////////////////////////////////////////////////
	}
	///////////////////////////////////////////////////////////////
	
	// Populate Class from XML ////////////////////////////////////
	public static function populateClassFromXML(nodes:Object, excludedNodes, includeAtts:Boolean, lowerCaseProps:Boolean, classObject)
	{
		// Return populated Class /////////////////////////////////////
		return createObjectFromXML(nodes, excludedNodes, includeAtts, lowerCaseProps, classObject);
		///////////////////////////////////////////////////////////////
	}
	///////////////////////////////////////////////////////////////
	
	// Create Object from XML /////////////////////////////////////
	public static function createObjectFromXML(nodes:Object, excludedNodes, includeAtts:Boolean, lowerCaseProps:Boolean, classObject)
	{		
		// Try ////////////////////////////////////////////////////////
		try
		{	
			// Define local variables /////////////////////////////////////
			var success:Boolean;
			var init = (classObject == null) ? new Object() : classObject;
			includeAtts = (includeAtts == null) ? true : includeAtts;
			lowerCaseProps = (lowerCaseProps == null) ? true : lowerCaseProps;
			///////////////////////////////////////////////////////////////
			
			// Validate excludedNodes /////////////////////////////////////
			if(excludedNodes != null)
			{
				var excludeNodesType:String = (excludedNodes.length != null) ? "array" : "object";
				if(excludeNodesType == "array") excludedNodes = createObjectFromArray(excludedNodes);
			}
			///////////////////////////////////////////////////////////////
			
			// Check if we need to included attributes ////////////////////
			if(includeAtts)
			{
				// Loop through each attribute ////////////////////////////////
				for(var att in nodes.attributes)
				{
					// Set attribute case /////////////////////////////////////////
					var attKey:String = (lowerCaseProps) ? att.toLowerCase() : att;
					///////////////////////////////////////////////////////////////
					
					// Populate the init Object ///////////////////////////////////
					addObjectProperty(init, attKey, nodes.attributes[att]);
					///////////////////////////////////////////////////////////////
				}
				///////////////////////////////////////////////////////////////
			}
			///////////////////////////////////////////////////////////////
			
			// Redefine nodes to represent its child nodes ////////////////
			nodes = nodes.childNodes;
			///////////////////////////////////////////////////////////////
				
			// Get the maximum amount of nodes ////////////////////////////
			var maxNodes:Number = nodes.length;
			///////////////////////////////////////////////////////////////
			
			// Loop through each node /////////////////////////////////////
			for(var curNodeIndex:Number = 0; curNodeIndex < maxNodes; curNodeIndex++)
			{
				// Get the current node and its value /////////////////////////
				var nodeName:String = (lowerCaseProps) ? nodes[curNodeIndex].nodeName.toLowerCase() : nodes[curNodeIndex].nodeName;
				var nodeValue:String = nodes[curNodeIndex].firstChild.nodeValue;
				///////////////////////////////////////////////////////////////

				// Check nodeName against excludeNode list ////////////////////
				if((excludedNodes[nodeName] == null) && (excludedNodes[nodes[curNodeIndex].nodeName] == null)) // Check both cases
				{
					// Check if the node has children /////////////////////////////
					var hasChildNodes:Boolean = ((nodeValue == null) && (nodes[curNodeIndex].firstChild.childNodes)) ? true : false;
					if(hasChildNodes)
					{
						// Populate the init Object ///////////////////////////////////
						addObjectProperty(init, nodeName, createObjectFromXML(nodes[curNodeIndex], excludedNodes, includeAtts, lowerCaseProps));
						if(!init[nodeName]) throw new Error("Error during node recursion.");
						///////////////////////////////////////////////////////////////
					}
					else
					{
						// Get and verify the maximum amount of attributes ////////////
						var maxAtts:Number = countObjectProps(nodes[curNodeIndex].attributes);
						if(maxAtts == 0)
						{
							// Populate the init Object ///////////////////////////////////
							addObjectProperty(init, nodeName, nodeValue);
							///////////////////////////////////////////////////////////////
						}
						else if((maxAtts > 0) && (includeAtts))
						{							
							// Create transfer Object /////////////////////////////////////
							var obj:Object = new Object();
							if(nodeValue != null) addObjectProperty(obj, nodeName, nodeValue);
							///////////////////////////////////////////////////////////////
							
							// Loop through each attribute ////////////////////////////////
							for(var att in nodes[curNodeIndex].attributes)
							{
								// Set attribute case /////////////////////////////////////////
								var attKey:String = (lowerCaseProps) ? att.toLowerCase() : att;
								///////////////////////////////////////////////////////////////
								
								// Populate the init Object ///////////////////////////////////
								addObjectProperty(obj, attKey, nodes[curNodeIndex].attributes[att]);
								///////////////////////////////////////////////////////////////
							}
							///////////////////////////////////////////////////////////////
							
							// Populate the init Object ///////////////////////////////////
							addObjectProperty(init, nodeName, obj);
							///////////////////////////////////////////////////////////////
						}
						///////////////////////////////////////////////////////////////
					}
					///////////////////////////////////////////////////////////////
				}
				else
				{
					// Save the child xml for the excluded node
					
					// Create a excludedNodes Object //////////////////////////////
					if(init.excludedNodes == null) init["excludedNodes"] = new Object();
					///////////////////////////////////////////////////////////////
					
					// Populate the excludedNodes Object //////////////////////////
					init.excludedNodes[nodeName] = nodes[curNodeIndex];
					//addObjectProperty(init.excludedNodes, nodeName, nodes[curNodeIndex]); // ???
					///////////////////////////////////////////////////////////////
				}
				///////////////////////////////////////////////////////////////
			}
			///////////////////////////////////////////////////////////////

			// Set success status /////////////////////////////////////////
			success = true;
			///////////////////////////////////////////////////////////////
		}
		catch(e)
		{
			// Set success status /////////////////////////////////////////
			success = false;
			///////////////////////////////////////////////////////////////
		}
		finally
		{
			// Check success status ///////////////////////////////////////
			if(success)
			{
				// Return the init Object /////////////////////////////////////
				return init;
				///////////////////////////////////////////////////////////////
			}
			else
			{
				// Return success status //////////////////////////////////////
				return false;
				///////////////////////////////////////////////////////////////
			}
			///////////////////////////////////////////////////////////////
		}
		///////////////////////////////////////////////////////////////
	}
	///////////////////////////////////////////////////////////////
	
	// Add object property ////////////////////////////////////////
	private static function addObjectProperty(obj:Object, prop:Object, val:Object):Void
	{
		// Define local variables /////////////////////////////////////
		val = formatValue(val);
		var isSimpleObject:Boolean = (obj.constructor == Object);
		///////////////////////////////////////////////////////////////
		
		// Note: We don't want to add extra properties such as propCollection to defined AS Classes, only to simple objects.
		
		// Check Object /////////////////////////////////////////////// 
		if(isSimpleObject)
		{
			// Check if the property exists ///////////////////////////////
			if(obj[prop] == null)
			{
				// Define local variables /////////////////////////////////////
				var propCollection:Collection = obj[prop + "Collection"];
				///////////////////////////////////////////////////////////////
				
				// Check if a propCollection exists ///////////////////////////
				if(!propCollection)
				{
					// Add the property to the object /////////////////////////////
					obj[prop] = val;
					///////////////////////////////////////////////////////////////
				}
				else
				{
					// Add new property to the collection /////////////////////////
					var id:String = (val.name) ? val.name : null;
					propCollection.addElement(id, val);
					///////////////////////////////////////////////////////////////
				}
				///////////////////////////////////////////////////////////////
			}
			else
			{
				// Define local variables /////////////////////////////////////
				var clone:Object = (validateStrictObject(obj[prop])) ? cloneObject(obj[prop]) : obj[prop];
				delete obj[prop];
				///////////////////////////////////////////////////////////////
				
				// Create collection //////////////////////////////////////////
				obj[prop + "Collection"] = new Collection();
				///////////////////////////////////////////////////////////////
				
				// Add cloned property to the collection //////////////////////
				var id:String = (clone.name) ? clone.name : null;
				obj[prop + "Collection"].addElement(id, clone);
				///////////////////////////////////////////////////////////////
				
				// Add new property to the collection /////////////////////////
				var id:String = (val.name) ? val.name : null;
				obj[prop + "Collection"].addElement(id, val);
				///////////////////////////////////////////////////////////////
			}
			///////////////////////////////////////////////////////////////
			
			// Add _getCollection functionality ///////////////////////////
			addGetCollection(obj)
			///////////////////////////////////////////////////////////////
		}
		else
		{
			// Set class property /////////////////////////////////////////
			obj[prop] = val;
			///////////////////////////////////////////////////////////////
		}
		///////////////////////////////////////////////////////////////
	}
	///////////////////////////////////////////////////////////////
	
	// Add _getCollection functionality ///////////////////////////
	public static function addGetCollection(obj:Object):Void
	{
		// Add _getCollection functionality ///////////////////////////
		if(!validateFunction(obj._getCollection))
		{
			obj._getCollection = function(propRef:String):Collection
			{
				// Define local variables /////////////////////////////////////
				var prop = this[propRef];
				var propCollection:Collection = this[propRef + "Collection"];
				///////////////////////////////////////////////////////////////
				
				// Check if a propCollection exists ///////////////////////////
				if(!propCollection)
				{
					// Check if a prop exists /////////////////////////////////////
					if(prop == null)
						return;
					else
					{
						// Create collection //////////////////////////////////////////
						var propCollection:Collection = new Collection();
						///////////////////////////////////////////////////////////////
						
						// Add property to the collection /////////////////////////////
						var id:String = (prop.name) ? prop.name : null;
						propCollection.addElement(id, prop);
						///////////////////////////////////////////////////////////////
					}
					///////////////////////////////////////////////////////////////
				}
				///////////////////////////////////////////////////////////////
				
				// Return /////////////////////////////////////////////////////
				return (propCollection) ? propCollection : null;
				///////////////////////////////////////////////////////////////
			}
			///////////////////////////////////////////////////////////////
		}
		///////////////////////////////////////////////////////////////
	}
	///////////////////////////////////////////////////////////////
	
	// Create Object from Array ///////////////////////////////////
	public static function createObjectFromArray(array:Array):Object
	{
		// Define local variables /////////////////////////////////////
		var obj:Object = new Object();
		var maxArray:Number = array.length;
		///////////////////////////////////////////////////////////////
		
		// Loop through each element //////////////////////////////////
		for(var curArrayIndex:Number = 0; curArrayIndex < maxArray; curArrayIndex++)
		{
			var name:String = array[curArrayIndex].toString();
			obj[name] = name;
		}
		///////////////////////////////////////////////////////////////
		
		// Return /////////////////////////////////////////////////////
		return obj;
		///////////////////////////////////////////////////////////////
	}
	///////////////////////////////////////////////////////////////
	
	// Create AS property string from Object //////////////////////
	public static function createASPropStringFromObject(obj:Object, excludedProps, lowerCaseProps:Boolean, objectProp:Boolean):String
	{
		// Try ////////////////////////////////////////////////////////
		try
		{	
			// Define local variables /////////////////////////////////////
			var success:Boolean;
			var ASCode:String = '';
			objectProp = (objectProp == null) ? false : objectProp;
			///////////////////////////////////////////////////////////////
			
			//*
			
			// Validate excludedProps /////////////////////////////////////
			if(excludedProps != null)
			{
				var excludedPropsType:String = (excludedProps.length != null) ? "array" : "object";
				if(excludedPropsType == "array") excludedProps = createObjectFromArray(excludedProps);
			}
			///////////////////////////////////////////////////////////////

			// Loop through each property /////////////////////////////////
			for(var prop in obj)
			{
				// Define local variables /////////////////////////////////////
				var propKey:String = (lowerCaseProps) ? prop.toLowerCase() : prop;
				///////////////////////////////////////////////////////////////

				// Check property key against excludedProps list //////////////
				if((excludedProps[propKey] == null) && (excludedProps[prop] == null)) // Check both cases
				{
					// Define local variables /////////////////////////////////////
					var quotes:String = (validateString(formatValue(obj[prop]))) ? '\\"' : '';
					///////////////////////////////////////////////////////////////

					// Check if converting an Object property /////////////////////
					if((!objectProp))
					{
						// Check property type ////////////////////////////////////////
						if(validateStrictObject(obj[prop]))
						{
							// Append ASCode //////////////////////////////////////////////
							var subASCode = createASPropStringFromObject(obj[prop], excludedProps, lowerCaseProps, true);
							ASCode += '		' + propKey + ' = {' + subASCode + '};\\n';
							///////////////////////////////////////////////////////////////
						}
						else
						{
							// Append ASCode //////////////////////////////////////////////
							ASCode += ' 	' + propKey + ' = ' + quotes + formatValue(obj[prop]) + quotes + ';\\n';
							///////////////////////////////////////////////////////////////
						}
						///////////////////////////////////////////////////////////////
					}
					else
					{
						// Set Object property comma's ////////////////////////////////
						if(ASCode != '') ASCode += ', ';
						///////////////////////////////////////////////////////////////
						
						// Check property type ////////////////////////////////////////
						if(validateStrictObject(obj[prop]))
						{
							// Append ASCode //////////////////////////////////////////////
							var subASCode = createASPropStringFromObject(obj[prop], excludedProps, lowerCaseProps, true);
							ASCode += propKey + ':{' + subASCode + '}';
							///////////////////////////////////////////////////////////////
						}
						else
						{
							// Append ASCode //////////////////////////////////////////////
							ASCode += propKey + ':' + quotes + formatValue(obj[prop]) + quotes;
							///////////////////////////////////////////////////////////////
						}
						///////////////////////////////////////////////////////////////
					}					
					///////////////////////////////////////////////////////////////
				}
				///////////////////////////////////////////////////////////////
			}
			///////////////////////////////////////////////////////////////

			//*/
			
			// Set success status /////////////////////////////////////////
			success = true;
			///////////////////////////////////////////////////////////////
		}
		catch(e)
		{
			// Save error information /////////////////////////////////////
			//error = e;
			///////////////////////////////////////////////////////////////
			
			// Set success status /////////////////////////////////////////
			success = false;
			///////////////////////////////////////////////////////////////
		}
		finally
		{
			// Check success status ///////////////////////////////////////
			if(success)
			{
				// Return the ASCode //////////////////////////////////////////
				return ASCode;
				///////////////////////////////////////////////////////////////
			}
			else
			{
				// Return success status //////////////////////////////////////
				return null;
				///////////////////////////////////////////////////////////////
			}
			///////////////////////////////////////////////////////////////
		}
		///////////////////////////////////////////////////////////////
	}
	///////////////////////////////////////////////////////////////

	// Join listener arrays ///////////////////////////////////////
	public static function joinListeners(group1:Array, group2:Array, unique:Boolean):Array
	{
		// Define local variables /////////////////////////////////////
		unique = (unique == null) ? true : unique;
		var max:Number = group2.length;
		///////////////////////////////////////////////////////////////
		
		// Join arrays ////////////////////////////////////////////////
		for(var index:Number = 0; index < max; index++)
		{
			// Add listener ///////////////////////////////////////////////
			var listener:Object = group2[index];
			if(!unique) group1.push(listener);
			else if(!elementInArray(group1, listener)) group1.push(listener);
			///////////////////////////////////////////////////////////////
		}
		///////////////////////////////////////////////////////////////
		
		// Return /////////////////////////////////////////////////////
		return group1
		///////////////////////////////////////////////////////////////
	}
	///////////////////////////////////////////////////////////////
	
	// Has element ////////////////////////////////////////////////
	public static function elementInArray(array:Array, element):Boolean
	{
		// Look for element ///////////////////////////////////////////
		var foundElement:Boolean = false;
		var max:Number = array.length;
		for(var index:Number = 0; index < max; index++)
		{
			// Check elements /////////////////////////////////////////////
			if(element === array[index])
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
	
	// Get domain /////////////////////////////////////////////////
	public static function getDomain(url:String, removeProtocall:Boolean):String
	{
		// Possible urls: 	http://www.mysite.co.uk/swf_proxy.php?url=http://www.myothersite.com/file.swf
		//					www.myothersite.com/file.swf
		//					myothersite.com/file.swf
		//					sub.admin.myothersite.com/file.swf
		//					https://secure.mysite.ie (notice no closing slash and https)
		//					shttp:// (saw this somewhere)
		//					rtmp://flashcom.mysite.com
		//					rtmp:/localhost
		//					http://localhost
		
		// Define local variables /////////////////////////////////////
		removeProtocall = (removeProtocall != null) ? Boolean(removeProtocall) : true;
		var startIndex:Number = 0;
		var endIndex:Number = 10;
		var sub:String = url.substr(startIndex, endIndex);
		///////////////////////////////////////////////////////////////

		// Check protocol /////////////////////////////////////////////
		if((sub.indexOf("http") != -1) || (sub.indexOf("rtmp") != -1)) // Types: http://, https://, rtmp://, rtmp:/ or maybe even shttp://
		{
			var cSlashs:Number = sub.indexOf(":/");
			if(cSlashs != -1)
			{
				var httpEnd:Number = cSlashs + 2;
				if(sub.charAt(httpEnd) == "/") httpEnd += 1;
				startIndex = httpEnd;
			}
			else
			{
				// Protocol error in url
				trace("Utility, getDomain() - Protocol error in url(" + url + ")");
				return url;
			}
		}
		///////////////////////////////////////////////////////////////
		
		// Find last slash ////////////////////////////////////////////
		var sub:String = url.substr(startIndex, url.length);
		endIndex = sub.indexOf("/");
		endIndex = (endIndex == -1) ? url.length : ((url.length - sub.length) + endIndex);
		///////////////////////////////////////////////////////////////
		
		// Update indexes /////////////////////////////////////////////
		if(removeProtocall)
			endIndex -= startIndex;
		else
			startIndex = 0;
		///////////////////////////////////////////////////////////////
		
		// Return /////////////////////////////////////////////////////
		return url.substr(startIndex, endIndex);
		///////////////////////////////////////////////////////////////
	}
	///////////////////////////////////////////////////////////////
	
	// Count Object properties ////////////////////////////////////
	public static function countObjectProps(obj:Object):Number
	{
		// Define local variables /////////////////////////////////////
		var propAmount:Number = 0;
		///////////////////////////////////////////////////////////////
		
		// Loop through each property /////////////////////////////////
		for(var prop in obj) propAmount++;
		///////////////////////////////////////////////////////////////
		
		// Return /////////////////////////////////////////////////////
		return propAmount;
		///////////////////////////////////////////////////////////////
	}
	///////////////////////////////////////////////////////////////
	
	// Clone Object ///////////////////////////////////////////////
	public static function cloneObject(obj:Object, excludedProps, clone):Object
	{
		// Define local variables /////////////////////////////////////
		clone = (clone) ? clone : new Object();
		///////////////////////////////////////////////////////////////
		
		// Validate excludedProps /////////////////////////////////////
		if(excludedProps)
		{
			var excludeNodesType:String = (excludedProps.length != null) ? "array" : "object";
			if(excludeNodesType == "array") excludedProps = createObjectFromArray(excludedProps);
			excludedProps.excludedNodes = "excludedNodes"; // Always exclude "excludedNodes" Object property to advoid recursion
		}
		///////////////////////////////////////////////////////////////
		
		// Loop through each property /////////////////////////////////
		for(var prop in obj) 
		{
			// Check prop against excludedProps list //////////////////////
			if(excludedProps[prop] == null)
			{
				clone[prop] = obj[prop];
			}
			///////////////////////////////////////////////////////////////
		}
		///////////////////////////////////////////////////////////////

		// Return /////////////////////////////////////////////////////
		return clone;
		///////////////////////////////////////////////////////////////
	}
	///////////////////////////////////////////////////////////////
	
	// Trace Object properties ////////////////////////////////////
	public static function traceObjectProps(obj:Object, traceObjects:Boolean, excludedProps, topLevel:Boolean, tabLevel:String, output_txt:TextField):Void
	{
		// Define local variables /////////////////////////////////////
		traceObjects = (traceObjects == null) ? false : traceObjects;
		topLevel = (topLevel == null) ? true : topLevel;
		tabLevel = (tabLevel == null) ? "\t" : tabLevel;
		///////////////////////////////////////////////////////////////
		
		// Validate excludedProps /////////////////////////////////////
		if(excludedProps != null)
		{
			var excludeNodesType:String = (excludedProps.length != null) ? "array" : "object";
			if(excludeNodesType == "array") excludedProps = createObjectFromArray(excludedProps);
			excludedProps.excludedNodes = "excludedNodes"; // Always exclude "excludedNodes" Object property to advoid recursion
		}
		///////////////////////////////////////////////////////////////

		// Start trace ////////////////////////////////////////////////
		if(topLevel)
		{
			var statement:String = "\n" + tabLevel + " traceObjectProps ---------------------------------- \n";
			trace(statement);
			if(output_txt) output_txt.text += statement;
		}
		
		// Loop through each property /////////////////////////////////
		for(var prop in obj)
		{
			// Check prop against excludedProps list //////////////////////
			if(excludedProps[prop] == null)
			{
				var statement:String = tabLevel + " Prop: " + prop + " | Type: " + typeof(obj[prop]) + " | Value: " + obj[prop] + "\n";
				trace(statement);
				if(output_txt) output_txt.text += statement;
				
				if((typeof(obj[prop]) == "object") && (traceObjects)) 
					traceObjectProps(obj[prop], true, excludedProps, false, (tabLevel + "\t"), output_txt);
			}
			///////////////////////////////////////////////////////////////
		}
		///////////////////////////////////////////////////////////////

		if(topLevel)
		{
			var statement:String = tabLevel + " -------------------------------------------------- \n";
			 trace(statement);
			if(output_txt) output_txt.text += statement;
		}
		///////////////////////////////////////////////////////////////
	}
	///////////////////////////////////////////////////////////////
	
	// Format value ///////////////////////////////////////////////
	public static function formatValue(value, allowNumberBools:Boolean)
	{
		// Define local variables /////////////////////////////////////
		if((value == null) || (value == "")) return value;
		allowNumberBools = (allowNumberBools == null) ? false : allowNumberBools;
		///////////////////////////////////////////////////////////////
		
		// Convert value //////////////////////////////////////////////
		if(validateBoolean(convertToBoolean(value, allowNumberBools))) return convertToBoolean(value);
		else if((value != "") && ((value + 1) / (value + 1) == 1)) return Number(value);
		else if(validateString(value))
		{
			// Check if its a colour value ////////////////////////////////
			if((value.charAt(0) == "#") && (value.length == 7))
				return ("0x" + value.substr(1, value.length));
			else
			{
				//return unescape(value.toString());
				return value.toString(); // Incase we are using values like url variables/parameters etc. We might not want to unescape them.
			}
			///////////////////////////////////////////////////////////////
		}
		else return value;
		///////////////////////////////////////////////////////////////
	}
	///////////////////////////////////////////////////////////////
	
	// Convert to Boolean /////////////////////////////////////////
	public static function convertToBoolean(currentValue, allowNumbers:Boolean):Boolean
	{	
		// Define local variables /////////////////////////////////////
		allowNumbers = (allowNumbers == null) ? true : allowNumbers;
		///////////////////////////////////////////////////////////////
		
		if(allowNumbers)
		{
			if((currentValue == true) ||(currentValue == "true") || (currentValue == "1")) return true;
			else if((currentValue == false) || (currentValue == "false") || (currentValue == "0")) return false;
		}
		else
		{
			if((currentValue === true) || (currentValue === "true")) return true;
			else if((currentValue === false) || (currentValue === "false")) return false;
		}
		return null;
	}
	///////////////////////////////////////////////////////////////
	
	// Validate Boolean ///////////////////////////////////////////
	public static function validateBoolean(currentValue):Boolean
	{	
		return (typeof(currentValue) == "boolean") ? true : false;
	}
	///////////////////////////////////////////////////////////////
	
	// Validate Number ////////////////////////////////////////////
	public static function validateNumber(num):Boolean
	{	
		return ((num != null) && (num != "") && (typeof(num) == "number") && (num.toString() != "NaN"));
	}
	///////////////////////////////////////////////////////////////
	
	// Validate String ////////////////////////////////////////////
	public static function validateString(str):Boolean
	{	
		return ((str != null) && (str != "") && (str != " ") && (typeof(str) == "string"));
	}
	///////////////////////////////////////////////////////////////
	
	// Validate MovieClip /////////////////////////////////////////
	public static function validateMovieClip(object):Boolean
	{	
		return ((typeof(object) == "movieclip")) ? true : false;
	}
	///////////////////////////////////////////////////////////////
	
	// Validate Object ////////////////////////////////////////////
	public static function validateStrictObject(object):Boolean
	{	
		return (typeof(object) == "object") ? true : false;
	}
	///////////////////////////////////////////////////////////////
	
	// Validate Object ////////////////////////////////////////////
	public static function validateObject(object):Boolean
	{	
		if(typeof(object) == "object")
		{ 
			return true;
		}
		else if(typeof(object) == "movieclip")
		{
			return validateMovieClip(object);
		}
		else if(typeof(object) == "string")
		{
			return validateString(object);
		}
		else if(typeof(object) == "number")
		{
			return validateNumber(object);
		}
		else if(typeof(object) == "boolean")
		{
			return true; // Has to be already valid
		}
	}
	///////////////////////////////////////////////////////////////
	
	// Validate Function //////////////////////////////////////////
	public static function validateFunction(newFunction):Boolean
	{
		return ((typeof(newFunction) == "function")) ? true : false;
	}
	///////////////////////////////////////////////////////////////	

	// Validate email address /////////////////////////////////////
	public static function validateEmail(emailAddress:String):Boolean
	{
		// Create the reference vars
		var atIndex:Number = emailAddress.indexOf("@");
		var dotIndex:Number = emailAddress.lastIndexOf(".");
		
		// Error check the supplied email address
		if(atIndex == -1) // Check if the "@" character is in the string
		{
			trace("No @ symbol in the email address " + emailAddress);
			return false;
		} 
		else if(dotIndex == -1) // Check if the "." character is in the string 
		{
			trace("No . symbol in the email address " + emailAddress);
			return false;
		} 
		else 
		{
			if(atIndex == 0) // Check if there is at least one character before the "@"
			{
				trace("No chars before the @ symbol in the email address " + emailAddress);
				return false;
			}
			else if(atIndex+3 > dotIndex) // Check if there is at least two character's between the "@" and the ".", and that the "@" comes before the "."
			{
				trace("There are not enough characters after between the @ and the .")
				return false;
			} 
			else if(dotIndex >= emailAddress.length-2) // Check if there is at least two characters after the "."
			{
				trace("There are not enough characters after the .")
				return false;
			} 
			else // All the requirements have been met, so return true.
			{
				trace("email ok")
				return true;			
			}
		}	
	}
	///////////////////////////////////////////////////////////////
	
	/*
	validateWebsite = function(){
		// Create the reference vars
		var wwwSym = webFieldPath.input_txt.text.indexOf("WWW");
		var dotSym = webFieldPath.input_txt.text.indexOf(".");
		var dotSym2 = webFieldPath.input_txt.text.lastIndexOf(".");
		
		// Begin Error Checking
		if(wwwSym == -1) // Check if the "WWW" character is in the string 	
		{
			return false;
		} 
		else if(dotSym == -1) // Check if the "." character is in the string 
		{
			return false;
		} 
		else if(dotSym2 == -1 || dotSym2 == dotSym) // Check if the second "." character is in the string 
		{
			return false
		} 
		else
		{
			if(wwwSym != 0) // Check if there are no character's before the "WWW"
			{
				return false;
			} 
			else if(dotSym != 3) // Check if the "." is at position 3, directly after the "WWW"
			{
				return false;
			}
			else if(dotSym2 >= webFieldPath.input_txt.text.length-2 || dotSym2 < dotSym+3) // Check if there is at least two character's after the second "." and there's at least two character's between the two "."'s
			{
				return false;
			} 
			else // All the requirements have been met, so return true.
			{
				return true;			
			}
		}	
	}
	*/
	///////////////////////////////////////////////////////////////

	// Get/Set - Error ////////////////////////////////////////////
	public function get error():Error
	{
		return $e;
	}
	
	public function set error(err:Error)
	{
		$e = err;
	}
	///////////////////////////////////////////////////////////////
}
///////////////////////////////////////////////////////////////////