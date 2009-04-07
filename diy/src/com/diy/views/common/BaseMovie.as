package com.diy.views.common 
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.diy.models.ConstModel;
	import com.diy.vo.common.DispatcherVo;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
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
	public class BaseMovie extends MovieClip
	{
		protected var dispatcher:CairngormEventDispatcher;
		protected var constModel:ConstModel;
		protected var stageManager:StageManager;
		private var displays:Array;
		private var dispatchers:Array;
		public function BaseMovie() 
		{
			dispatcher = CairngormEventDispatcher.getInstance();
			constModel = ConstModel.getInstance();
			dispatchers = new Array();
			displays = new Array();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStageHandler);
		}
		
		override public function addChild(child:DisplayObject):DisplayObject 
		{
			displays.push(child);
			return super.addChild(child);
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject 
		{
			displays.splice(displays.indexOf(child), 1);
			return super.removeChild(child);
		}
		
		protected function addDispatcher(dv:DispatcherVo):void
		{
			dispatchers.push(dv);
			dv.dispatcher.addEventListener(dv.type, dv.handler);
		}
		
		protected function removeDispatcher(dv:DispatcherVo):void
		{
			dispatchers.splice(dispatchers.indexOf(dv), 1);
			dv.dispatcher.removeEventListener(dv.type, dv.handler);
		}
		
		protected function onRemovedFromStageHandler(event:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStageHandler);
			stage.removeEventListener(Event.RESIZE, onStageResizeHandler);
			removeAllDispatcher();
			removeAllChild();
		}
		
		private function removeAllChild():void
		{
			var len:int = displays.length;
			for (var i:int = 0; i < len; i++)
			{
				removeChild(displays[i]);
			}
		}
		
		private function removeAllDispatcher():void
		{
			var len:int = dispatchers.length;
			var dv:DispatcherVo;
			for (var i:int = 0; i < len; i++)
			{
				dv = dispatchers[i];
				dv.dispatcher.removeEventListener(dv.type, dv.handler);
			}
		}
		
		protected function onAddedToStageHandler(event:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
			stage.addEventListener(Event.RESIZE, onStageResizeHandler);
			//stageManager = StageManager.getInstance(stage);
		}
		
		protected function onStageResizeHandler(event:Event):void 
		{
			
		}
		
		
	}
	
}