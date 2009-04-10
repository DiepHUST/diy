package com.diy
{
	import adobe.utils.MMExecute;
	import com.diy.business.utils.Debug;
	import com.diy.control.Controller;
	import com.diy.events.TestModuleEvent;
	import com.diy.models.Setting;
	import com.diy.views.common.BaseSprite;
	import com.diy.views.common.player.SwfManager;
	import com.diy.views.video.VideoPlayer;
	import com.diy.vo.common.DispatcherVo;
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
		
		private const WIDTH:Number = 492;
		private const HEIGHT:Number = 287;
		
		private var controller:Controller;
		private var swfVideo:Sprite;
		private var swfManager:SwfManager;
		
		public function MainView() 
		{
			controller = new Controller;
		}
		
		override protected function onAddedToStageHandler(event:Event):void 
		{
			super.onAddedToStageHandler(event);
			
			swfVideo = new Sprite;
			swfManager = new SwfManager(swfVideo);
			swfManager.play("videos/video.swf");
			stageManager.addChild(swfVideo);
			
			var t:Timer = new Timer(5000, 1);
			t.addEventListener(TimerEvent.TIMER, tt);
			t.start();
			
			addDispatcher(new DispatcherVo(dispatcher, 
				TestModuleEvent.GET_BOBO_MODULE_RESPONSE, testHandler));
			dispatcher.dispatchEvent(new TestModuleEvent(
				TestModuleEvent.GET_BOBO_MODULE_REQUEST, Setting.MAIN_XML));
				
			onStageResizeHandler(null);
		}
		
		private function tt(e:TimerEvent):void 
		{
			swfManager.stop();
		}
		
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
			swfVideo.x = (w - WIDTH) / 2;
			swfVideo.y = (h - HEIGHT) / 2;
		}
	}
	
}