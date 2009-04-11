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
	 * @author Sheldon Song
	 * @homepage http://xinzy10.vicp.net
	 * @email xinzy10@gmail.com
	 * @version Version 1.0
	 * @description the class function
	 */
	public class LoadBitmap 
	{
		private var completeFunc:Function;
		private var errorFunc:Function;
		
		public function LoadBitmap(url:String, completeFunc:Function, errorFunc:Function = null) 
		{
			this.completeFunc = completeFunc;
			this.errorFunc = errorFunc;
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteHandlelr);
			loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onErrorHandler);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onErrorHandler);
			loader.load(new URLRequest(url));
		}
		
		private function onCompleteHandlelr(e:Event):void 
		{
			completeFunc(Bitmap(e.target.content));
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