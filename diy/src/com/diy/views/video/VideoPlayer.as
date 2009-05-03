package com.diy.views.video 
{
	import com.diy.views.common.BaseSprite;
	import com.diy.views.common.player.SwfManager;
	import flash.display.Sprite;
	import flash.events.Event;
	
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
		private var swfContainer:Sprite;
		private var swfManager:SwfManager;
		
		public function VideoPlayer() 
		{
			
		}
		
		override protected function onAddedToStageHandler(event:Event):void 
		{
			super.onAddedToStageHandler(event);
			swfContainer = new Sprite;
			swfManager = new SwfManager(swfContainer, 370, 204);
			addChild(swfContainer);
		}
		
		override protected function onRemovedFromStageHandler(event:Event):void 
		{
			super.onRemovedFromStageHandler(event);
		}
		
		public function play(url:String):void
		{
			swfManager.play(url);
		}
		
	}
	
}