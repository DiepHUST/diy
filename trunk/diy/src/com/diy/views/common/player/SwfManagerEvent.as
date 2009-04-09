package com.diy.views.common.player 
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Sheldon Song
	 * @homepage http://xinzy10.vicp.net
	 * @email xinzy10@gmail.com
	 * @version Version 1.0
	 * @description the class function
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