package com.diy.vo.common 
{
	
	/**
	 * ...
	 * @author Sheldon Song
	 * @homepage http://xinzy10.vicp.net
	 * @email xinzy10@gmail.com
	 * @version Version 1.0
	 * @description the class function
	 */
	public class SysConfigVo 
	{
		private var _mainSwfUrl:String;
		
		public function SysConfigVo() 
		{
			
		}
		
		public function get mainSwfUrl():String 
		{ 
			return _mainSwfUrl; 
		}
		
		public function set mainSwfUrl(value:String):void 
		{
			_mainSwfUrl = value;
		}
		
	}
	
}