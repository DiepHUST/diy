package com.diy.vo.videos.video001 
{
	/**
	 * ...
	 * @author Sheldon Song
	 * @homepage http://xinzy10.vicp.net
	 * @email xinzy10@gmail.com
	 * @version Version 1.0
	 * @description the class function
	 */
	public class VideoVo
	{
		private var _url:String;
		
		public function VideoVo() 
		{
			
		}
		
		public function get url():String 
		{ 
			return _url; 
		}
		
		public function set url(value:String):void
		{
			_url = value;
		}
		
	}
	
}