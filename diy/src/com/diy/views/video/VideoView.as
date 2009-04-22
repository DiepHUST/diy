package com.diy.views.video 
{
	import caurina.transitions.Tweener;
	import com.diy.business.utils.Debug;
	import com.diy.views.common.BaseSprite;
	import com.diy.views.common.player.SwfManager;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Sheldon Song
	 * @homepage http://xinzy10.vicp.net
	 * @email xinzy10@gmail.com
	 * @version Version 1.0
	 * @description the class function
	 */
	public class VideoView extends BaseSprite
	{
		private var videoStage:VideoStage;
		private var videoPlayer:VideoPlayer;
		
		public function VideoView() 
		{
			
		}
		
		override protected function onAddedToStageHandler(event:Event):void 
		{
			super.onAddedToStageHandler(event);
			createStage();
			createVideo();
		}
		
		override protected function onRemovedFromStageHandler(event:Event):void 
		{
			super.onRemovedFromStageHandler(event);
		}
		
		override protected function onStageResizeHandler(event:Event):void 
		{
			super.onStageResizeHandler(event);
			var w:Number = stage.stageWidth;
			var h:Number = stage.stageHeight;
		}
		
		private function createStage():void
		{
			videoStage = new VideoStage;
			Tweener.addTween(videoStage.leftCurtain, { x:-178, time:5, transition:"linear"} );
			Tweener.addTween(videoStage.rightCurtain, { x:820, time:5, transition:"linear"} );
			videoStage.leftVideoContainer.buttonMode = true;
			videoStage.rightVideoContainer.buttonMode = true;
			videoStage.leftVideoContainer.addEventListener(MouseEvent.CLICK, onLeftVideoClickHandler);
			videoStage.rightVideoContainer.addEventListener(MouseEvent.CLICK, onRightVideoClickHandler);
			addChild(videoStage);
		}
		
		private function onRightVideoClickHandler(e:MouseEvent):void 
		{
			trace("right");
		}
		
		private function onLeftVideoClickHandler(e:MouseEvent):void 
		{
			trace("left");
		}
		
		private function createVideo():void
		{
			videoPlayer = new VideoPlayer; 
			videoPlayer.x = 10;
			videoPlayer.y = 7;
			videoStage.centerVideoContrainer.addChild(videoPlayer);
			videoPlayer.play("videos/1.swf");
		}
		
	}
	
}