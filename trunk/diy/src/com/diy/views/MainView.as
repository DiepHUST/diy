package com.diy.views 
{
	import com.diy.control.Controller;
	import com.diy.events.TestModuleEvent;
	import com.diy.models.Setting;
	import com.diy.views.common.BaseSprite;
	import flash.events.Event;
	
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
		
		public function MainView() 
		{
			controller = new Controller;
		}
		
		override protected function onAddedToStageHandler(event:Event):void 
		{
			super.onAddedToStageHandler(event);
			//dispatcher.dispatchEvent(new TestModuleEvent(TestModuleEvent.GET_BOBO_MODULE_REQUEST, Setting.MAIN_XML));
			//dispatcher.addEventListener(TestModuleEvent.GET_BOBO_MODULE_RESPONSE, testHandler);
		}
		
		//private function testHandler(e:TestModuleEvent):void 
		//{
			//trace(e.xml);
		//}
		
		override protected function onRemovedFromStageHandler(event:Event):void 
		{
			super.onRemovedFromStageHandler(event);
		}
		
		override protected function onStageResizeHandler(event:Event):void 
		{
			super.onStageResizeHandler(event);
		}
	}
	
}