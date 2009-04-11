﻿package com.diy
{
	import adobe.utils.MMExecute;
	import caurina.transitions.Tweener;
	import com.diy.business.LoadBitmap;
	import com.diy.business.utils.Debug;
	import com.diy.control.Controller;
	import com.diy.events.TestModuleEvent;
	import com.diy.models.Setting;
	import com.diy.views.common.BaseSprite;
	import com.diy.views.common.player.SwfManager;
	import com.diy.views.video.VideoPlayer;
	import com.diy.vo.common.DispatcherVo;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Sheldon Song
	 * @homepage http://xinzy10.vicp.net
	 * @email xinzy10@gmail.com
	 * @version Version 1.0
	 * @description the class function
	 */
	public class MainView extends BaseSprite
	{
		private var controller:Controller;
		private var swfVideo:Sprite;
		private var swfManager:SwfManager;
		private var videoStage:VideoStage;
		public function MainView() 
		{
			controller = new Controller;
		}
		
		override protected function onAddedToStageHandler(event:Event):void 
		{
			super.onAddedToStageHandler(event);
			
			videoStage = new VideoStage;
			videoStage.leftCurtain.visible = false;
			videoStage.rightCurtain.visible = false;
			new LoadBitmap("images/pic001.jpg", compHanlder);
			stageManager.addChild(videoStage);
			
			swfVideo = new Sprite;
			swfManager = new SwfManager(swfVideo, 370, 204);
			//swfManager.play("http://www.memyself.cn/video.swf");
			swfManager.play("videos/video.swf");

			swfVideo.x = 10;
			swfVideo.y = 7;
			videoStage.centerVideoContrainer.addChild(swfVideo);
			
			//var t:Timer = new Timer(5000, 1);
			//t.addEventListener(TimerEvent.TIMER, tt);
			//t.start();
			
			//addDispatcher(new DispatcherVo(dispatcher, 
				//TestModuleEvent.GET_BOBO_MODULE_RESPONSE, testHandler));
			//dispatcher.dispatchEvent(new TestModuleEvent(
				//TestModuleEvent.GET_BOBO_MODULE_REQUEST, Setting.MAIN_XML));
				
			onStageResizeHandler(null);
		}
		
		private function compHanlder(bit:Bitmap):void
		{
			bit.x = 3;
			bit.y = 2;
			bit.width = 114;
			bit.height = 62;
			var b:Bitmap = new Bitmap(bit.bitmapData.clone());
			videoStage.leftVideoContainer.addChild(bit);
			b.x = 3;
			b.y = 2;
			b.width = 114;
			b.height = 62;
			videoStage.rightVideoContainer.addChild(b);
		}
		
		//private function tt(e:TimerEvent):void 
		//{
			//swfManager.stop();
		//}
		
		private function testHandler(e:TestModuleEvent):void 
		{
			Debug.log(e.xml);
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
			//swfVideo.x = (w - swfManager.movieWidth) / 2;
			//swfVideo.y = (h - swfManager.movieHeight) / 2;
		}
	}
	
}