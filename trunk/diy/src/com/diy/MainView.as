package com.diy
{
	import adobe.utils.MMExecute;
	import com.diy.business.utils.Debug;
	import com.diy.control.Controller;
	import com.diy.events.TestModuleEvent;
	import com.diy.models.Setting;
	import com.diy.views.common.BaseSprite;
	import com.diy.views.video.VideoPlayer;
	import com.diy.vo.common.DispatcherVo;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	
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
		private var video:VideoPlayer;
		
		public function MainView() 
		{
			controller = new Controller;
		}
		
		override protected function onAddedToStageHandler(event:Event):void 
		{
			super.onAddedToStageHandler(event);
			video = new VideoPlayer;
			stageManager.addChild(video);
			onStageResizeHandler(null);
			
			addDispatcher(new DispatcherVo(dispatcher, 
				TestModuleEvent.GET_BOBO_MODULE_RESPONSE, testHandler));
			dispatcher.dispatchEvent(new TestModuleEvent(
				TestModuleEvent.GET_BOBO_MODULE_REQUEST, Setting.MAIN_XML));
			
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
			video.x = (w - WIDTH) / 2;
			video.y = (h - HEIGHT) / 2;
		}
	}
	
}