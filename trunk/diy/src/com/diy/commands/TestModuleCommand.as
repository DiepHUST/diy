package com.diy.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.diy.business.utils.Debug;
	import com.diy.events.TestModuleEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Sheldon Song
	 * @homepage http://xinzy10.vicp.net
	 * @email xinzy10@gmail.com
	 * @version Version 1.0
	 * @description the class function
	 */
	public class TestModuleCommand extends BaseCommand implements ICommand
	{
		
		private var loader:URLLoader;
		
		public function TestModuleCommand() 
		{
		}
		
		public function execute(event:CairngormEvent):void
		{
			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onLoaderCompleteHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onLoaderIOErrorHandler);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityHandler);
			try
			{
				loader.load(new URLRequest(event["url"]));
			}
			catch (err:Error)
			{
				removeLoader();
				Debug.error("error:load xml failed!");
			}
		}
		
		private function removeLoader():void
		{
			loader.removeEventListener(Event.COMPLETE, onLoaderCompleteHandler);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, onLoaderIOErrorHandler);
			loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityHandler);
		}
		
		private function onSecurityHandler(event:SecurityErrorEvent):void 
		{
			removeLoader();
			Debug.error("error:load angel module security error!");
		}
		
		private function onLoaderIOErrorHandler(event:IOErrorEvent):void 
		{
			removeLoader();
			Debug.error("error:load angel module io error!");
		}
		
		private function onLoaderCompleteHandler(event:Event):void 
		{
			removeLoader();
			var xml:XML = new XML(event.target.data);
			dispatcher.dispatchEvent(new TestModuleEvent(TestModuleEvent.GET_BOBO_MODULE_RESPONSE,"", xml));
		
		}
		
	}
	
}