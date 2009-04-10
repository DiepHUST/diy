package com.diy.business 
{
	import flash.events.Event;
	import flash.display.Loader;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.events.ProgressEvent;
	
	/**
	 * ...
	 * @author Sheldon Song
	 * @homepage http://xinzy10.vicp.net
	 * @email xinzy10@gmail.com
	 * @version Version 1.0
	 * @description the class function
	 */
	public class LoadSwf
	{
		private var openFunction:Function;
		private var completeFunction:Function;
		private var ioErrorFunction:Function;
		private var errorFunction:Function;
		private var progressFunction:Function;
		private var loader:Loader;

		public function LoadSwf(url:String, completeFunc:Function, openFunc:Function = null,  errorFunc:Function = null, progressFunc:Function = null)
		{
			openFunction = openFunc;
			completeFunction = completeFunc;
			errorFunction = errorFunc;
			progressFunction = progressFunc;
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.OPEN, openHandler);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadCompleteHandler);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			loader.load(new URLRequest(url));
		}
		
		private function configUI():void
		{

		}
		
		private function openHandler(e:Event):void 
		{
			if (openFunction != null)
			{
				openFunction();
			}
		}
		
		private function deleteLoader():void
		{
			if (loader == null)
			{
				return;
			}
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadCompleteHandler);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
			loader.unload();
			loader = null;
		}
		
		private function loadCompleteHandler(e:Event):void
		{
			if (e.target != null)
			{
				completeFunction(e.target.content);
			}
			deleteLoader();
		}
		
		private function ioErrorHandler(e:IOErrorEvent):void 
		{
			if (errorFunction != null)
			{
				errorFunction(e);
			}
			deleteLoader();
		}
			
		private function securityErrorHandler(e:SecurityErrorEvent):void 
		{
			if (errorFunction != null)
			{
				errorFunction(e);
			}
			deleteLoader();
		}
		
		private function progressHandler(e:ProgressEvent):void 
		{
			if (progressFunction != null)
			{
				progressFunction(e);
			}
		}
	}
}