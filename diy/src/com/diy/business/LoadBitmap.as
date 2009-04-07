package com.diy.business 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Will Chen
	 */
	public class LoadBitmap 
	{
		private var callBack:Function;
		private var errorFunc:Function;
		
		public function LoadBitmap(url:String, callBack:Function, errorFunc:Function = null) 
		{
			this.callBack = callBack;
			this.errorFunc = errorFunc;
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteHandlelr);
			loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onErrorHandler);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onErrorHandler);
			loader.load(new URLRequest(url));
		}
		
		private function onCompleteHandlelr(e:Event):void 
		{
			callBack(Bitmap(e.target.content));
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