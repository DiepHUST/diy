package com.diy
{
	import com.diy.business.LoadSwf;
	import com.diy.business.LoadXml;
	import com.diy.business.utils.Debug;
	import com.diy.models.Setting;
	import com.diy.views.common.BaseMovie;
	import com.diy.views.common.loading.LoadingBar;
	import com.diy.vo.common.SysConfigVo;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.ui.Mouse;
	import flash.utils.getDefinitionByName;
	import com.diy.MainView;
	
	/**
	 * ...
	 * @author Sheldon Song
	 * @homepage http://xinzy10.vicp.net
	 * @email xinzy10@gmail.com
	 * @version Version 1.0
	 * @description the class function
	 */
	public class Preloader extends BaseMovie 
	{
		private var loading:LoadingBar;
		
		public function Preloader() 
		{
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			Mouse.hide();
		}
		
		override protected function onAddedToStageHandler(event:Event):void 
		{
			super.onAddedToStageHandler(event);
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.showDefaultContextMenu = false;
			loading = new LoadingBar;
			stageManager.addChild(loading);
			var w:Number = stage.stageWidth;
			var h:Number = stage.stageHeight;
			loading.x = (w - loading.width) / 2;
			loading.y = (h - loading.height) / 2;
		}
		
		override protected function onRemovedFromStageHandler(event:Event):void 
		{
			super.onRemovedFromStageHandler(event);
			stageManager.removeAllChild();
		}
		
		private function progress(e:ProgressEvent):void 
		{
			loading.msg = Math.floor(e.bytesLoaded / e.bytesTotal * 100) + "%"; 
		}
		
		private function checkFrame(e:Event):void
		{
			loading.x = mouseX - 49;
			loading.y = mouseY - 106;
			if (currentFrame == totalFrames) 
			{
				removeEventListener(Event.ENTER_FRAME, checkFrame);
				startup();
			}
		}
		
		private function startup():void 
		{
			stageManager.removeChild(loading);
			Mouse.show();
			stop();
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			var mainClass:Class = getDefinitionByName(Setting.MAIN_VIEW) as Class;
			stageManager.addChild(new mainClass() as DisplayObject);
		}
		
	}
	
}