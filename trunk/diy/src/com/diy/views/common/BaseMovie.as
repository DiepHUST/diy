package com.diy.views.common
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.diy.models.ConstModel;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.system.System;
	
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
		public function BaseMovie() 
		{
			dispatcher = CairngormEventDispatcher.getInstance();
			constModel = ConstModel.getInstance();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStageHandler);
		}
		
		protected function onRemovedFromStageHandler(event:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStageHandler);
			stage.removeEventListener(Event.RESIZE, onStageResizeHandler);
			var display:DisplayObject;
			for (var i:int = 0; i < numChildren; i++)
			{
				display = getChildAt(i);
				removeChild(display);
				display = null;
			}
			System.gc();
		}
		
		protected function onAddedToStageHandler(event:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
			stage.addEventListener(Event.RESIZE, onStageResizeHandler);
		}
		
		protected function onStageResizeHandler(event:Event):void 
		{
			
		}
		
	}
	
}