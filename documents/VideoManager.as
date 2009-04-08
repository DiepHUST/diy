package 
{
	import flash.events.AsyncErrorEvent;
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;

	public class VideoManager extends EventDispatcher
	{
		private var video:Video;
		private var netStream:NetStream;
		private var netCon:NetConnection;
		private var url:String;
		
		private var _totalTime:Number;
		private var _totalHour:int;
		private var _totalMinute:int;
		private var _totalSecond:int;
		
		private var _currentTime:Number;
		private var _currentHour:int;
		private var _currentMinute:int;
		private var _currentSecond:int;
		
		private var _movieWidth:Number;
		private var _movieHeight:Number;
		
		private var _isPause:Boolean;
		private var _isPlaying:Boolean;
		private var _isSoundOn:Boolean;
		private var _volume:Number;
		private var _isGetMetaData:Boolean;

		private const BUFFER_TIME:int = 1;
		
		public function VideoManager(video:Video, mediaServerUrl:String = null)
		{
			this.playConut = 0;
			this.video = video;
			this._isSoundOn = true;
			this._isPause = false;
			this._volume = 0.5;
		}
		
		private function addNetConnectListen():void
		{
			netCon = new NetConnection();
			netCon.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			netCon.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			netCon.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			netCon.connect(null);
		}
		
		private function removeNetConnectListen():void
		{
			if (netCon != null)
			{
				netCon.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
				netCon.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
				netCon.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
				netCon.close();
				netCon = null;
			}
		}
		
		private function netStatusHandler(e:NetStatusEvent):void
		{
			switch(e.info.code)
			{
				case "NetConnection.Connect.Success":
					connectStream();
					break;
				case "NetStream.Play.StreamNotFound":
					dispatchEvent(new VideoManagerEvent(VideoManagerEvent.EVENT_STREAM_NOT_FOUND));
					break;
				case "NetStream.Play.Start":
					dispatchEvent(new VideoManagerEvent(VideoManagerEvent.EVENT_PLAY_START));
					break;
				case "NetStream.Play.Stop":
					dispatchEvent(new VideoManagerEvent(VideoManagerEvent.EVENT_PLAY_STOP));
					break;
				case "NetStream.Buffer.Empty":
					dispatchEvent(new VideoManagerEvent(VideoManagerEvent.EVENT_BUFFER_EMPTY));
					break;
				case "NetStream.Buffer.Full":
					dispatchEvent(new VideoManagerEvent(VideoManagerEvent.EVENT_BUFFER_FULL));
					break;
			}
			dispatchEvent(new VideoManagerEvent(VideoManagerEvent.EVENT_INFO_CODE, e.info.code));
		}
		
		private function connectStream():void
		{
			addNetStreamListen();
			video.attachNetStream(netStream);
			var head:String = url.split(":")[0];
			var server:String = url.substring(0, url.lastIndexOf("/") + 1);
			var fileName:String = url.substring(url.lastIndexOf("/") + 1);
			if (head == "rtmp")
			{
				var extension:String = fileName.substr(fileName.length - 3, 3);
				switch (extension.toLowerCase()) 
				{
					case "f4v":
						url = server + "mp4:" + fileName;
						break;
					case "mp4":
						url = server + "mp4:" + fileName.substring(0, fileName.length - 4);
						break;
				}
			}
			netStream.play(url);
			_isPlaying = true;
			_isPause = false;
		}
		
		private function addNetStreamListen():void
		{
			netStream = new NetStream(netCon);
			var client:Object = new Object();
			client.onMetaData = onMetaData;
			netStream.client = client;
			netStream.bufferTime = BUFFER_TIME;
			netStream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			netStream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
		}
		
		private function removeNetStreamListen():void
		{
			if (netStream != null)
			{
				netStream.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
				netStream.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
				netStream.close();
				netStream = null;
			}
		}
		
		private function asyncErrorHandler(e:AsyncErrorEvent):void 
		{
			trace("asyncErrorHandler: " + e);
		}
		
		private function securityErrorHandler(e:SecurityErrorEvent):void
		{
			trace("securityErrorHandler: " + e);
		}
		
		public function onMetaData(info:Object):void
		{
			_totalTime = info.duration;
			_totalHour = _totalTime / 3600;
			_totalMinute = _totalTime % 3600 / 60;
			_totalSecond = _totalTime % 3600 % 60;
			_isGetMetaData = true;
			_movieWidth = info.width;
			_movieHeight = info.height;
			dispatchEvent(new VideoManagerEvent(VideoManagerEvent.EVENT_META_DATA_COMPLETE));
		}
		
		private function play(url:String):void
		{
			this.url = url;
			if (netCon != null)
			{
				video.clear();
				if (netStream != null)
				{
					removeNetStreamListen();
				}
				removeNetConnectListen();
			}
			addNetConnectListen();
		}
		
		public function pause():void
		{
			netStream.pause();
			_isPause = true;
		}
		
		public function resume():void
		{
			netStream.resume();
			_isPause = false;
		}
		
		public function stop():void
		{
			netStream.close();
			_isPlaying = false;
		}
		
		public function close():void 
		{
			netStream.close();
			netCon.close();
			netStream = null;
			netCon = null;
		}
		
		public function soundOff():void
		{
			var st:SoundTransform = new SoundTransform();
			st.volume = 0;
			netStream.soundTransform = st;
			_isSoundOn = false;
		}
		
		public function soundOn():void
		{
			var st:SoundTransform = new SoundTransform();
			st.volume = _volume;
			netStream.soundTransform = st;
			_isSoundOn = true;
		}
		
		private function setCurrentTime():void
		{
			_currentTime = netStream.time;
			_currentHour = _currentTime / 3600;
			_currentMinute = _currentTime % 3600 / 60;
			_currentSecond = _currentTime % 3600 % 60;
		}
		
		private function timeFormat(value:int):String
		{
			if (value < 10)
			{
				return "0" + value;
			}
			return value.toString(10);
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
		
		public function get totalTime():Number
		{
			return _totalTime;
		}
		
		public function get currentTime():Number
		{
			setCurrentTime();
			return _currentTime;
		}
		
		public function set currentTime(value:Number):void
		{
			netStream.seek(value);
		}
		
		public function get totalHour():int
		{
			return _totalHour;
		}
		
		public function get totalMinute():int
		{
			return _totalMinute;
		}
		
		public function get totalSecond():int
		{
			return _totalSecond;
		}
		
		public function get currentHour():int
		{
			setCurrentTime();
			return _currentHour;
		}
		
		public function get currentMinute():int
		{
			setCurrentTime();
			return _currentMinute;
		}
		
		public function get currentSecond():int
		{
			setCurrentTime();
			return _currentSecond;
		}
		
		public function get isPlaning():Boolean
		{
			return _isPlaying;
		}
		
		public function get isPause():Boolean
		{
			return _isPause;
		}
		
		public function get bytesTotal():uint
		{
			return netStream.bytesTotal;
		}
		
		public function get bytesLoaded():uint
		{
			return netStream.bytesLoaded;
		}
		
		public function get bufferPercent():int
		{
			if (_totalTime - netStream.time < BUFFER_TIME)
			{
				return 100;
			}
			return (netStream.bufferLength / BUFFER_TIME) * 100;
		}
		
		public function get isSoundOn():Boolean 
		{ 
			return _isSoundOn; 
		}
		
		public function set volume(value:Number):void
		{
			if (_isSoundOn)
			{
				var st:SoundTransform = new SoundTransform();
				st.volume = value;
				netStream.soundTransform = st;
			}
			_volume = value;
		}
		
		public function get isGetMetaData():Boolean 
		{ 
			return _isGetMetaData;
		}
		
		public function get movieWidth():Number 
		{
			return _movieWidth; 
		}
		
		public function get movieHeight():Number 
		{ 
			return _movieHeight; 
		}
	}
}
