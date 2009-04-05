package com.diy.control
{
	import com.adobe.cairngorm.control.FrontController;
	import com.diy.commands.TestModuleCommand;
	import com.diy.events.TestModuleEvent;
	/**
	 * ...
	 * @author Sheldon Song
	 * @homepage http://xinzy10.vicp.net
	 * @email xinzy10@gmail.com
	 * @version Version 1.0
	 * @description the class function
	 */
	public class Controller extends FrontController
	{
		
		public function Controller() 
		{
			super();
			initCommand();
		}
		
		private function initCommand():void
		{
			addCommand(TestModuleEvent.GET_BOBO_MODULE_REQUEST, TestModuleCommand);
		}
		
	}
	
}