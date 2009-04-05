package com.diy.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	/**
	 * ...
	 * @author Sheldon Song
	 * @homepage http://xinzy10.vicp.net
	 * @email xinzy10@gmail.com
	 * @version Version 1.0
	 * @description the class function
	 */
	public class TestModuleEvent extends CairngormEvent
	{
		public static const GET_BOBO_MODULE_REQUEST:String = "get.bobo.module.request";
		public static const GET_BOBO_MODULE_RESPONSE:String = "get.bobo.module.response";
		
		public var xml:XML;
		public var url:String;
		
		public function TestModuleEvent(type:String, url:String = "", xml:XML = null) 
		{
			super(type);
			this.xml = xml;
			this.url = url;
		}
	}
	
}