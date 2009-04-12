package com.diy.views.common.loading 
{
	import com.diy.business.LoadSwf;
	import com.diy.business.LoadXml;
	import com.diy.models.Setting;
	import com.diy.views.common.BaseMovie;
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
	public class LoadingBar extends BaseMovie
	{
		private var loading:Loading;
		private var _message:String = "";
		private var label:TextField;
		
		public function LoadingBar() 
		{
			
		}
		
		override protected function onAddedToStageHandler(event:Event):void 
		{
			super.onAddedToStageHandler(event);
			configUI();
			
		}
		
		private function configUI():void
		{
			loading = new Loading;
			addChild(loading);
			
			label = new TextField;
			label.defaultTextFormat = new TextFormat("Verdana", 14, "0x49941D", true, null, null, null, "right");
			label.width = 56;
			label.height = 25;
			label.x = 116;
			label.y = 7;
			label.selectable = false;
			label.text = _message;
			addChild(label);
		}
		
		public function get message():String 
		{ 
			return _message; 
		}
		
		public function set message(value:String):void 
		{
			_message = value;
			label.text = _message;
		}
		
	}
	
}