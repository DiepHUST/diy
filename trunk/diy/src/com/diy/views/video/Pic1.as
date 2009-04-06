package com.diy.views.video 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Sheldon Song
	 * @homepage http://xinzy10.vicp.net
	 * @email xinzy10@gmail.com
	 * @version Version 1.0
	 * @description the class function
	 */
	public class Pic1 extends MovieClip
	{
		private var loader:Loader;
		
		public function Pic1() 
		{
			loaderImage()
		}
		
		private function loaderImage():void
		{
			loader = new Loader;
			loader.load(new URLRequest("images/pic001.jpg"));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderCompleteHandler);
		}
		
		private function loaderCompleteHandler(e:Event):void 
		{
			var image:Bitmap = Bitmap(loader.content);
			addChild(image);
		}
		
	}
	
}