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
		private var _dispatcher:CairngormEventDispatcher;
		private var _type:String;
		private var _handler:Function;
		
		public function DispatcherVo(dispatcher:CairngormEventDispatcher = null, type:String = null, handler:Function = null) 
		{
			this.dispatcher = dispatcher;
			this.type = type;
			this.handler = handler;
		}
		
		public function get dispatcher():CairngormEventDispatcher { return _dispatcher; }
		
		public function set dispatcher(value:CairngormEventDispatcher):void 
		{
			_dispatcher = value;
		}
		
		public function get type():String { return _type; }
		
		public function set type(value:String):void 
		{
			_type = value;
		}
		
		public function get handler():Function { return _handler; }
		
		public function set handler(value:Function):void 
		{
			_handler = value;
		}
		
	}
	
}