package com.diy
{
	import adobe.utils.MMExecute;
	import caurina.transitions.Tweener;
	import com.diy.business.LoadBitmap;
	import com.diy.business.LoadXml;
	import com.diy.business.utils.Debug;
	import com.diy.control.Controller;
	import com.diy.events.TestModuleEvent;
	import com.diy.models.Setting;
	import com.diy.views.common.BaseSprite;
	import com.diy.views.common.player.SwfManager;
	import com.diy.vo.common.DispatcherVo;
	import com.diy.vo.common.SysConfigVo;
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

		[Embed(source='../../../bin/images/enter.jpg')]
		private var background:Class;
		private var enter:*;
		
		public function MainView() 
		{
			controller = new Controller;
			
			
		}
		
		private function configUI():void
		{
			enter = new background;
			addChild(enter);
		}
		
		override protected function onAddedToStageHandler(event:Event):void 
		{
			super.onAddedToStageHandler(event);
			
			
			//addDispatcher(new DispatcherVo(dispatcher, 
				//TestModuleEvent.GET_BOBO_MODULE_RESPONSE, testHandler));
			//dispatcher.dispatchEvent(new TestModuleEvent(
				//TestModuleEvent.GET_BOBO_MODULE_REQUEST, Setting.MAIN_XML));
				
			configUI();
			onStageResizeHandler(null);
		}

		private function onErrorHandler(e:Event):void
		{
			Debug.error("Error: LoadingView load xml error." + e);
		}
		
		//private function onLoadBitmapCompHanlder(bit:Bitmap):void
		//{
			//bit.x = 3;
			//bit.y = 2;
			//bit.width = 114;
			//bit.height = 62;
			//var b:Bitmap = new Bitmap(bit.bitmapData.clone());
			//videoStage.leftVideoContainer.addChild(bit);
			//b.x = 3;
			//b.y = 2;
			//b.width = 114;
			//b.height = 62;
			//videoStage.rightVideoContainer.addChild(b);
		//}
		

		override protected function onRemovedFromStageHandler(event:Event):void 
		{
			super.onRemovedFromStageHandler(event);
		}
		
		override protected function onStageResizeHandler(event:Event):void 
		{
			super.onStageResizeHandler(event);
			var w:Number = stage.stageWidth;
			var h:Number = stage.stageHeight;
			enter.x = (w - 1280) / 2;
			enter.y = (h - 1024) / 2;
			if (w > 1280)
			{
				this.graphics.clear();
				this.graphics.beginFill(0x000000);
				this.graphics.drawRect(0, 0, w, h);
				this.graphics.endFill();
			}
			
		}
	}
	
}