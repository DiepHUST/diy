package com.diy.business 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
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
		private var httpStatusFunction:Function;
		private var progressFunction:Function;
		private var loader:Loader;
		
		public function LoadBitmap(url:String, completeFunc:Function, errorFunc:Function = null, progressFunction:Function = null, httpStatusFunction:Function = null) 
		{
			this.completeFunc = completeFunc;
			this.errorFunc = errorFunc;
			this.httpStatusFunction == httpStatusFunction;
			this.progressFunction = progressFunction;
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteHandlelr);
			loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onErrorHandler);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onErrorHandler);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			loader.load(new URLRequest(url));
		}
		
		private function deleteLoader():void
		{
			if (loader == null)
			{
				return;
			}
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onCompleteHandlelr);
			loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onErrorHandler);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onErrorHandler);
			loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
			loader.unload();
			loader = null;
		}
		
		private function progressHandler(e:ProgressEvent):void 
		{
			if (progressFunction != null)
			{
				progressFunction(e);
			}
		}
		
		private function onCompleteHandlelr(e:Event):void 
		{
			if (completeFunc != null) 
			{
				completeFunc(Bitmap(e.target.content));
			}
			deleteLoader();
		}
		
		private function onErrorHandler(e:Event):void 
		{
			if (errorFunc != null)
			{
				errorFunc();
			}
			deleteLoader();
		}
	}
	
}