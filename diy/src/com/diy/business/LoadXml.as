package com.diy.business 
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Sheldon Song
	 * @homepage http://xinzy10.vicp.net
	 * @email xinzy10@gmail.com
	 * @version Version 1.0
	 * @description the class function
	 */
	public class LoadXml
	{
		private var completeFunc:Function;
		private var errorFunc:Function;
		
		public function LoadXml(url:String, completeFunc:Function, errorFunc:Function = null) 
		{
			this.completeFunc = completeFunc;
			this.errorFunc = errorFunc;
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onCompleteHandlelr);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onErrorHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onErrorHandler);
			loader.load(new URLRequest(url));
		}
		
		private function onCompleteHandlelr(e:Event):void 
		{
			completeFunc(e.target.data);
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