package com.diy.views.video
{
	import com.diy.business.utils.Debug;
	import com.diy.models.Setting;
	import com.diy.views.common.BaseSprite;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Sheldon Song
	 * @homepage http://xinzy10.vicp.net
	 * @email xinzy10@gmail.com
	 * @version Version 1.0
	 * @description the class function
	 */
	public class VideoPlayer extends BaseSprite
	{
		private var loader:Loader;
		private var totalTime:Number;
		private var currentTime:Number;
		
		public function VideoPlayer() 
		{
			loader = new Loader;
		}
		
		override protected function onAddedToStageHandler(event:Event):void 
		{
			super.onAddedToStageHandler(event);
			loader.load(new URLRequest(Setting.VIDEO001));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderCompleteHandler);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, IOErrorHandler);
		}
		
		private function IOErrorHandler(e:IOErrorEvent):void 
		{
			Debug.error("IO_ERROR: loader video error.");
		}
		
		private function loaderCompleteHandler(e:Event):void 
		{
			var video:MovieClip = loader.content as MovieClip;
			
			addChild(video);
		}
		
		override protected function onRemovedFromStageHandler(event:Event):void 
		{
			super.onRemovedFromStageHandler(event);
		}
		
		override protected function onStageResizeHandler(event:Event):void 
		{
			super.onStageResizeHandler(event);
		}
	}
	
}