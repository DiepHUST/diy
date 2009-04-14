package com.diy.events.navigation 
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
	public class NavigationEvent extends CairngormEvent 
	{
		public static const BUTTON__CLICK:String = "button.click";
		public var obj:*;
		public function NavigationEvent(type:String, obj:*) 
		{ 
			super(type);
			this.obj = obj;
		} 
		
	}
	
}

