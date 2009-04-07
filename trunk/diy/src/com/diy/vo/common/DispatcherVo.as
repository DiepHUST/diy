package com.diy.vo.common 
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.adobe.cairngorm.vo.ValueObject;
	/**
	 * ...
	 * @author Sheldon Song
	 * @homepage http://xinzy10.vicp.net
	 * @email xinzy10@gmail.com
	 * @version Version 1.0
	 * @description the class function
	 */
	public class DispatcherVo implements ValueObject
	{
		public var dispatcher:CairngormEventDispatcher;
		public var type:String;
		public var handler:Function;
		
		public function DispatcherVo(dispatcher:CairngormEventDispatcher = null, type:String = null, handler:Function = null) 
		{
			this.dispatcher = dispatcher;
			this.type = type;
			this.handler = handler;
		}
		
	}
	
}