package com.diy.views.common.player 
{
	import com.diy.business.LoadSwf;
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
	public class SwfManager
	{
		private var swfContainer:MovieClip;
		private var swf:MovieClip;
		private var url:String;
		
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
			}
			new LoadSwf(url, onCompleteHandler, onOpenHandler, onIOErrorHandler, onProgressHandler);
		}
		
		private function onOpenHandler():void
		{
			
		}
		
		
		private function onSecurityErrorHandler(e:Event):void 
		{
			Debug.error("Security error.");
		}
		
		private function onCompleteHandler(result:MovieClip):void 
		{
			swf = result;
			swfContainer.addChild(swf);
		}
		
		private function onProgressHandler(e:ProgressEvent):void 
		{
			
		}
		
		private function onIOErrorHandler(e:IOErrorEvent):void 
		{
			
		}
		
	}
	
}