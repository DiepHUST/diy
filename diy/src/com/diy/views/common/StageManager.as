package com.diy.views.common 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	/**
	 * ...
	 * @author Ron Tian
	 * @homepage http://www.ronme.cn
	 * @email TianJingrong@188.com
	 * @version v1.0
	 * @description This class function is
	 */
	public class StageManager 
	{
		private static var instance:StageManager;
		public static const WINDOW_LEVEL:int = 0;
		public static const ALERT_LEVEL:int = 1;
		public static const TIP_LEVEL:int = 2;
		protected var stage:Stage;
		private var windowLevel:Sprite;
		private var alertLevel:Sprite;
		private var tipLevel:Sprite;
		private var windows:Array;
		private var alerts:Array;
		private var tips:Array;
		
		public function StageManager(s:Stage) 
		{
			if (instance != null)
			{
				throw(new Error(" use getInstance to get instance"));
			}
			else
			{
				instance = this;
				stage = s;
				configUI();
			}
		}
		
		public static function getInstance(s:Stage):StageManager
		{
			if (instance == null)
			{
				instance = new StageManager(s);
			}
			return instance;
		}
		
		public function addChild(display:DisplayObject, level:int=0):void
		{
			switch(level)
			{
				case 0:
					windows.push(display);
					windowLevel.addChild(display);
					break;
				case 1:
					alerts.push(display);
					alertLevel.addChild(display);
					break;
				case 2:
					tips.push(display);
					tipLevel.addChild(display);
					break;
			}
		}
		
		public function removeChild(display:DisplayObject, level:int = 0):void
		{
			switch(level)
			{
				case 0:
					windows.splice(windows.indexOf(display), 1);
					windowLevel.removeChild(display);
					break;
				case 1:
					alerts.splice(alerts.indexOf(display), 1);
					alertLevel.removeChild(display);
					break;
				case 2:
					tips.splice(tips.indexOf(display), 1);
					tipLevel.removeChild(display);
					break;
			}
		}
		
		public function removeAllChild(level:int=0):void
		{
			switch(level)
			{
				case 0:
					removeWindows();
					break;
				case 1:
					removeAlerts();
					break;
				case 2:
					removeTips();
					break;
			}
		}
		
		private function removeAlerts():void
		{
			var len:int = alerts.length;
			for (var i:int = 0; i < len; i++)
			{
				alertLevel.removeChild(alerts[i]);
			}
			alerts = new Array();
		}
		
		private function removeTips():void
		{
			var len:int = tips.length;
			for (var i:int = 0; i < len; i++)
			{
				tipLevel.removeChild(tips[i]);
			}
			tips = new Array();
		}
		
		private function removeWindows():void
		{
			var len:int = windows.length;
			for (var i:int = 0; i < len; i++)
			{
				windowLevel.removeChild(windows[i]);
			}
			windows = new Array();
		}
		
		private function configUI():void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.showDefaultContextMenu = false;
			windowLevel = new Sprite();
			stage.addChild(windowLevel);
			alertLevel = new Sprite();
			stage.addChild(alertLevel);
			tipLevel = new Sprite();
			stage.addChild(tipLevel);
			windows = new Array();
			alerts = new Array();
			tips = new Array();
		}
	}
	
}