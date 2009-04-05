package com.diy.commands 
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.diy.models.ConstModel;
	
	/**
	 * ...
	 * @author Sheldon Song
	 * @homepage http://xinzy10.vicp.net
	 * @email xinzy10@gmail.com
	 * @version Version 1.0
	 * @description the class function
	 */
	public class BaseCommand
	{		
		protected var dispatcher:CairngormEventDispatcher;
		protected var constModel:ConstModel;
		public function BaseCommand() 
		{
			dispatcher = CairngormEventDispatcher.getInstance();
			constModel = ConstModel.getInstance();
		}
	}
	
}