package com.diy.models 
{
	import com.diy.vo.common.SysConfigVo;
	
	/**
	 * ...
	 * @author Sheldon Song
	 * @homepage http://xinzy10.vicp.net
	 * @email xinzy10@gmail.com
	 * @version Version 1.0
	 * @description the class function
	 */
	public class ConstModel 
	{
		private static var instance:ConstModel;
		private var _sysConfigVo:SysConfigVo;
		
		public function ConstModel() 
		{
			if (instance == null)
			{
				instance = this;
			}
		}
		
		public static function getInstance():ConstModel
		{
			if (instance == null)
			{
				instance = new ConstModel();
			}
			return instance;
		}
		
		public function get sysConfigVo():SysConfigVo 
		{ 
			return _sysConfigVo;
		}
		
		public function set sysConfigVo(value:SysConfigVo):void 
		{
			_sysConfigVo = value;
		}
	}
	
}