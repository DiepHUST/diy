package com.diy.views.common.loading 
{
	import com.diy.views.common.BaseMovie;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Sheldon Song
	 * @homepage http://xinzy10.vicp.net
	 * @email xinzy10@gmail.com
	 * @version Version 1.0
	 * @description the class function
	 */
	public class PreloadView extends BaseMovie
	{
		private var loading:Preload;
		private var _msg:String = "";
		
		public function PreloadView() 
		{
			
		}
		
		override protected function onAddedToStageHandler(event:Event):void 
		{
			super.onAddedToStageHandler(event);
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.showDefaultContextMenu = false;
			addEventListener(Event.ENTER_FRAME, textHandler);
			configUI();
		}
		
		private function textHandler(e:Event):void 
		{
			if (loading.currentFrame > 30)
			{
				loading.message.text = _msg;
			}
			else
			{
				loading.message.text = "";
			}
		}
		
		private function configUI():void
		{
			loading = new Preload;
			addChild(loading);
			loading.message = new TextField;
			loading.message.defaultTextFormat = new TextFormat("Verdana", 14, "0x49941D", true, null, null, null, "right");
			loading.message.x = 755;
			loading.message.y = 396;
			loading.message.selectable = false;
			addChild(loading.message);
		}
		
		public function get msg():String 
		{ 
			return _msg; 
		}
		
		public function set msg(value:String):void 
		{
			_msg = value;
		}
		
	}
	
}
		
		
		
		
		
		