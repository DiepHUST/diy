package com.diy.business 
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Will Chen
	 */
	public class LoadXml
	{
		private var callBack:Function;
		private var errorFunc:Function;
		
		public function LoadXml(url:String, callBack:Function, errorFunc:Function = null) 
		{
			this.callBack = callBack;
			this.errorFunc = errorFunc;
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onCompleteHandlelr);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onErrorHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onErrorHandler);
			loader.load(new URLRequest(url));
		}
		
		private function onCompleteHandlelr(e:Event):void 
		{
			callBack(e.target.data);
		}
		
		private function onErrorHandler(e:Event):void 
		{
			if (errorFunc != null)
			{
				errorFunc();
			}
		}
		
	}
	
}