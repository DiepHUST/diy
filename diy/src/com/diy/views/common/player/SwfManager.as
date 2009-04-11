package com.diy.views.common.player 
{
	import com.diy.business.LoadSwf;
	import com.diy.business.utils.Debug;
	import com.diy.views.common.BaseMovie;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Sheldon Song
	 * @homepage http://xinzy10.vicp.net
	 * @email xinzy10@gmail.com
	 * @version Version 1.0
	 * @description the class function
	 */
	public class SwfManager extends EventDispatcher
	{
		private var swfContainer:Sprite;
		private var swf:MovieClip;
		private var url:String;
		
		private var _totalTime:Number;
		private var _totalHour:int;
		private var _totalMinute:int;
		private var _totalSecond:int;
		
		private var _currentTime:Number;
		private var _currentHour:int;
		private var _currentMinute:int;
		private var _currentSecond:int;
		
		private var _bufferLoad:int;
		private var _bufferTotal:int;
		private var _bufferPercnet:int;
		
		private var _isPause:Boolean;
		private var _isPlaying:Boolean;
		
		private var _movieWidth:Number;
		private var _movieHeight:Number;
		
		private var fps:int;
		
		public function SwfManager(swfContainer:Sprite, widthValue:Number, heightValue:Number ) 
		{
			this.swfContainer = swfContainer;
			this._isPause = true;
			this._isPlaying = false;
			this._movieWidth = widthValue;
			this._movieHeight = heightValue;
		}
		
		public function play(url:String):void
		{
			this.url = url;
			if (swf != null && swfContainer.contains(swf))
			{
				swfContainer.removeChild(swf);
			}
			new LoadSwf(url, onCompleteHandler, onOpenHandler, onIOErrorHandler, onProgressHandler, onHttpStatusHandler);
		}
		
		private function onHttpStatusHandler(e:HTTPStatusEvent):void
		{
			Debug.log(e.status);
		}
		
		public function close():void
		{
			swf.stop();
			if (swf !=null && swfContainer.contains(swf)) 
			{
				swfContainer.removeChild(swf);
			} 
		}
		
		public function stop():void
		{
			swf.gotoAndStop(1);
			isPlaying = false;
		}
		
		public function resume():void
		{
			swf.play();
			isPause = false;
		}
		
		public function pause():void
		{
			swf.stop();
			isPause = true;
		}
		
		public function rePlay():void
		{
			swf.gotoAndPlay(1);
			isPlaying = true;
			isPause = false;
		}
		
		public function goToPlay(frame:int):void
		{
			swf.gotoAndPlay(frame);
			isPause = false;
		}
		
		public function goToStop(frame:int):void
		{
			swf.gotoAndStop(frame);
			isPause = true;
		}
		
		private function onOpenHandler(e:Event):void
		{
			
		}
		
		private function onCompleteHandler(e:Event):void 
		{
			swf = e.target.content;
			fps = e.target.frameRate;
			_totalTime = Math.round(swf.totalFrames / fps);
			_totalHour = Math.floor(_totalTime / 3600);
			_totalMinute = Math.floor(_totalTime / 60);
			_totalSecond =  _totalTime;
			swf.width = _movieWidth;
			swf.height = _movieHeight;
			swfContainer.addChild(swf);
		}
		
		private function onProgressHandler(e:ProgressEvent):void 
		{
			_bufferLoad = e.target.bytesLoaded;
			
			if (_bufferTotal == 0) 
			{
				_bufferTotal = e.target.bytesTotal;
			}
			
			if (_bufferLoad == _bufferTotal) 
			{
				dispatchEvent(new SwfManagerEvent(SwfManagerEvent.EVENT_SWF_LOAD_COMPLETE));
			}
		}
		
		private function onIOErrorHandler(e:Event):void 
		{
			Debug.error("Error." + e);
		}
		
		public function getCurrentTimeString():String
		{
			setCurrentTime();
			var temp:String;
			if (_currentHour > 0)
			{
				temp = timeFormat(_currentHour) + ":" + timeFormat(_currentMinute) + ":" + timeFormat(_currentSecond);
			}
			else
			{
				temp = timeFormat(_currentMinute) + ":" + timeFormat(_currentSecond);
			}
			return temp;
		}
		
		private function setCurrentTime():void
		{
			_currentTime = Math.floor(swf.currentFrame / fps);
			_currentHour = Math.floor(_currentTime / 3600);
			_currentMinute = Math.floor(_currentTime / 60);
			_currentSecond =  _currentTime;
		}
		
		public function getTotalTimeString():String
		{
			var temp:String;
			if (_totalHour > 0)
			{
				temp = timeFormat(_totalHour) + ":" + timeFormat(_totalMinute) + ":" + timeFormat(_totalSecond);
			}
			else
			{
				temp = timeFormat(_totalMinute) + ":" + timeFormat(_totalSecond);
			}
			return temp;
		}
		
		private function timeFormat(value:int):String
		{
			if (value < 10)
			{
				return "0" + value;
			}
			return value.toString(10);
		}
		
		public function get totalTime():Number 
		{ 
			return _totalTime; 
		}
		
		public function set totalTime(value:Number):void 
		{
			_totalTime = value;
		}
		
		public function get totalHour():int 
		{ 
			return _totalHour; 
		}
		
		public function set totalHour(value:int):void 
		{
			_totalHour = value;
		}
		
		public function get totalMinute():int 
		{ 
			return _totalMinute; 
		}
		
		public function set totalMinute(value:int):void 
		{
			_totalMinute = value;
		}
		
		public function get totalSecond():int 
		{ 
			return _totalSecond; 
		}
		
		public function set totalSecond(value:int):void 
		{
			_totalSecond = value;
		}
		
		public function get bufferLoad():int 
		{ 
			return _bufferLoad; 
		}
		
		public function set bufferLoad(value:int):void 
		{
			_bufferLoad = value;
		}
		
		public function get bufferTotal():int 
		{ 
			return _bufferTotal; 
		}
		
		public function set bufferTotal(value:int):void 
		{
			_bufferTotal = value;
		}
		
		public function get bufferPercnet():int 
		{ 
			if (_bufferLoad == _bufferTotal)
			{
				return 100;
			}
			_bufferPercnet = _bufferLoad / _bufferTotal * 100;
			return _bufferPercnet; 
		}
		
		public function set bufferPercnet(value:int):void 
		{
			_bufferPercnet = value;
		}
		
		public function get isPause():Boolean 
		{ 
			return _isPause; 
		}
		
		public function set isPause(value:Boolean):void 
		{
			_isPause = value;
		}
		
		public function get isPlaying():Boolean 
		{ 
			return _isPlaying; 
		}
		
		public function set isPlaying(value:Boolean):void 
		{
			_isPlaying = value;
		}
		
		public function get currentTime():int 
		{ 
			setCurrentTime();
			return _currentTime; 
		}
		
		public function set currentTime(value:int):void 
		{
			_currentTime = value;
		}
		
		public function get currentHour():int 
		{ 
			setCurrentTime();
			return _currentHour; 
		}
		
		public function set currentHour(value:int):void 
		{
			_currentHour = value;
		}
		
		public function get currentMinute():int 
		{ 
			setCurrentTime();
			return _currentMinute; 
		}
		
		public function set currentMinute(value:int):void 
		{
			setCurrentTime();
			_currentMinute = value;
		}
		
		public function get currentSecond():int 
		{ 
			return _currentSecond; 
		}
		
		public function set currentSecond(value:int):void 
		{
			_currentSecond = value;
		}
		
		public function get movieWidth():Number 
		{ 
			return _movieWidth; 
		}
		
		public function set movieWidth(value:Number):void 
		{
			_movieWidth = value;
		}
		
		public function get movieHeight():Number 
		{ 
			return _movieHeight; 
		}
		
		public function set movieHeight(value:Number):void 
		{
			_movieHeight = value;
		}
		
	}
	
}