/*/////////////////////////////////////////////////////////////////
Timer class
Version: 1
Created by: Derek Donnelly
Date: 09/12/2003 
*//////////////////////////////////////////////////////////////////

// Define class ///////////////////////////////////////////////////
class com.derekdonnelly.utils.Timer
{
	// Define class vars //////////////////////////////////////////
	private var $interval:Number;
	private var $time_start:Number;
	private var $time_end:Number;
	private var $running:Boolean;
	private var $session; // Interval Name
	
	// event processing functions
	var broadcastMessage:Function;
	var addListener:Function;
	var removeListener:Function;
	
	// our events 
	public static var TIMECHANGED:String = "onTimeChanged";
	public static var STOPPED:String = "onStopped";
	///////////////////////////////////////////////////////////////	
	
	// NavLoader class initialization /////////////////////////////	
	public function Timer(interval:Number) 
	{
		$interval = interval;
		$running = false;
		AsBroadcaster.initialize(this);
	}
	///////////////////////////////////////////////////////////////	
	
	// Start the timer ////////////////////////////////////////////
	public function startTimer(mesure:Boolean, endTime:Number) 
	{
		$time_start = getTime();
		$time_end = $time_start + (endTime * 60);
		if (mesure)
		{
			$running = true;
			$session = setInterval(triggered, $interval, this);
		}
	}
	///////////////////////////////////////////////////////////////	
	
	// Default Triggered (Interval call) //////////////////////////
	private function triggered(path)
	{
		path.broadcast();
	}
	private function broadcast()
	{
		broadcastMessage(TIMECHANGED, this, timeLeftString(), timeLeftSeconds);
	}
	///////////////////////////////////////////////////////////////
	
	// Stop the timer /////////////////////////////////////////////
	public function stopTimer()
	{
		$time_end = getTime();
		if ($running)
		{
			$running = false;
			clearInterval($session);
		}
	}
	///////////////////////////////////////////////////////////////
	
	// Get the time ///////////////////////////////////////////////
	private function getTime():Number
	{
		var timeObj = new Date();

		var hours = timeObj.getHours();
		var minutes = timeObj.getMinutes();
		var seconds = timeObj.getSeconds();
		
		hours = hours * 60 * 60;
		minutes = minutes * 60;
		
		return (hours + minutes + seconds);
	}
	///////////////////////////////////////////////////////////////
	
	// Get the time left ////////////////////////////////////////////	
	public function get timeLeftSeconds():Number 
	{
		var lat:Number = $time_end - getTime();
		
		if(lat < 0 )
		{
			lat = 0;
		}
		
		return lat;
	}
	///////////////////////////////////////////////////////////////
	
	// Get time left string /////////////////////////////////////////
	public function timeLeftString(secs:Number):String
	{
		return latencyString(timeLeftSeconds);
	}
	///////////////////////////////////////////////////////////////
	
	// Get the latency ////////////////////////////////////////////	
	public function get latencySeconds():Number 
	{
		var lat:Number = $time_end - $time_start;
		
		if(lat < 0 )
		{
			lat = 0;
		}
		
		return lat;
	}
	///////////////////////////////////////////////////////////////
	
	// Get latency string /////////////////////////////////////////
	public function latencyString(secs:Number):String
	{
		var hours:Number = 0;
		var minutes:Number = 0;
		var seconds:Number = 0;

		if ((secs == null) || (secs <= 0))
		{
			seconds = latencySeconds;
		}
		else
		{
			seconds = secs;
		}

		hours = Math.floor(((seconds/60)/60));
		seconds = (seconds -(hours*60*60));
		
		minutes = Math.floor(seconds/60);
		seconds = (seconds -(minutes*60));

		return (formatNum(hours) + ":" +  formatNum(minutes) + ":" + formatNum(seconds));
	}
	///////////////////////////////////////////////////////////////
	
	// Format Time Numbers ////////////////////////////////////////
	private function formatNum(num:Number):String
	{
		var tempNumber_str:String = num.toString();
		
		if (num <= 9)
		{
			//num = "0"+num;
			
			tempNumber_str = "0" + tempNumber_str;
		}		
		return tempNumber_str;
	}
	///////////////////////////////////////////////////////////////
}