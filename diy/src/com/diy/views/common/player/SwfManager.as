package com.diy.views.common.player 
{
	import com.diy.business.utils.Debug;
	import com.diy.views.common.BaseMovie;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
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
	public class SwfManager extends BaseMovie
	{
		private var swfContainer:Sprite;
		private var swf:MovieClip;
		private var url:String;
		private var loader:Loader;
		
		public function SwfManager(swfContainer:MovieClip) 
		{
			this.swfContainer = swfContainer;
		}
		
		public function play(url:String):void
		{
			this.url = url;
			if (swf != null && swfContainer.contains(swf))
			{
				swfContainer.removeChild(swf);
				removeLoadConnectListen();
			}
			
			addLoadConnectListen();
		}
		
		private function removeLoadConnectListen():void
		{
			if (loader != null)
			{
				loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgressHandler);
				loader.contentLoaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS, onHttpStatusHandler);
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onCompleteHandler);
				loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOErrorHandler);
				loader.unloadAndStop();
				loader = null;
			}
			
		}
		
		private function addLoadConnectListen():void
		{
			loader = new Loader;
			loader.load(new URLRequest(url));
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgressHandler);
			loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHttpStatusHandler);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteHandler);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOErrorHandler); 
			loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityErrorHandler);
		}
		
		private function onSecurityErrorHandler(e:Event):void 
		{
			Debug.error("Security error.");
		}
		
		private function onCompleteHandler(e:Event):void 
		{
			
		}
		
		private function onProgressHandler(e:ProgressEvent):void 
		{
			
		}
		
		private function onIOErrorHandler(e:IOErrorEvent):void 
		{
			
		}
		
		private function onHttpStatusHandler(e:HTTPStatusEvent):void 
		{
			
		}
		
		private function closeAllStreams(e:Event):void 
		{
			
		}
	}
	
}