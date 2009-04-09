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
	public class VideoManagerEvent extends CairngormEvent
	{
		public static const EVENT_INFO_CODE:String = "event.info.code";
		public static const EVENT_META_DATA_COMPLETE:String = "event.meta.data.complete";
		public static const EVENT_PLAY_START:String = "event.play.start";
		public static const EVENT_PLAY_STOP:String = "event.play.stop";
		public static const EVENT_BUFFER_EMPTY:String = "event.buffer.empty";
		public static const EVENT_BUFFER_FULL:String = "event.buffer.full";
		public static const EVENT_STREAM_NOT_FOUND:String = "event.stream.not.found";
		
		private var _data:String;
		
		public function VideoManagerEvent(eventName:String, infoCode:String = null) 
		{
			super(eventName);
			this.data = infoCode;
		}
		
		public function get data():String { return _data; }
		
		public function set data(value:String):void 
		{
			_data = value;
		}
		
	}
	
}