package com.diy.views.common.player 
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Sheldon Song
	 */
	public class SwfManagerEvent extends CairngormEvent 
	{
		public static const EVENT_INFO_CODE:String = "event.info.code";
		private var _data:String;
		public function SwfManagerEvent(eventName:String, infoCode:String = null) 
		{ 
			super(eventName);
			this.data = infoCode;
		} 
		
		public function get data():String 
		{
			return _data; 
		}
		
		public function set data(value:String):void 
		{
			_data = value;
		}
	}
	
}