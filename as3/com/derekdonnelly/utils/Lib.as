package com.derekdonnelly.utils
{
	import flash.media.Sound;
	import flash.display.MovieClip;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.utils.getDefinitionByName;
	
	public class Lib
	{
		public static function createAsset(mc:MovieClip, classname:String):DisplayObject
		{
			var c:Class = Class(mc.loaderInfo.applicationDomain.getDefinition(classname));
			return new c();
		}
		public static function createSound(mc:MovieClip, classname:String):Sound
		{
			var c:Class = Class(mc.loaderInfo.applicationDomain.getDefinition(classname));
			return new c();
		}
		public static function createBitmapData(mc:MovieClip, bitmap:String):BitmapData
		{
			var c:Class = Class(mc.loaderInfo.applicationDomain.getDefinition(bitmap));
			return new c(0,0);
		}
		public static function createClassObject(classname:String):* 
		{
			var c:Class = Class(getDefinitionByName(classname));
			return new c();
		}
	}
}