package diy.view
{
	import caurina.transitions.Tweener;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class PageFlipTemplet extends Sprite
	{
		private const sheetWidth:Number = 400;
		
		private const sheetHeight:Number = 300;
		//可翻页间隔
		private const hitSpace:Number = 20;
		//可翻页区域
		private const hit_array:Array=
		[
			 new Point(-sheetWidth,0),
			 new Point(-sheetWidth,sheetHeight-hitSpace),
			 new Point(sheetWidth-hitSpace,0),
			 new Point(sheetWidth-hitSpace,sheetHeight-hitSpace)
		];
		
		private const point_array:Array=
		[
		 	new Point(0,0),
			new Point(0,1),
			new Point(1,0),
			new Point(1,1)
		];
		private var currentHit:MovieClip;
		private var isCan:Boolean=false;
		private var pointMouse:Point=new Point(0,0);
		private var page0:BitmapData;
		private var page1:BitmapData;
		private var currentPoint:Point;
		private var book_array:Array;
		private var container:Sprite;
		private var book:Sprite;
		private var sheet:Sprite;
		private var hit:Sprite;
		private var book_mc_array:Array;
		private var currentPage:int=0;
		private var render:Shape;
		private var hit_mc_array:Array;
		public function PageFlipTemplet()
		{
			this.addEventListener(Event.ADDED_TO_STAGE,setStage);
			getData();
		}
		private function getData():void
		{
			var ul:URLLoader = new URLLoader();
			ul.load(new URLRequest("assets/xml/book.xml"));
			ul.addEventListener(Event.COMPLETE, getDataSuccess);
		}
		private function getDataSuccess(event:Event):void
		{
			var xml:XML=new XML(event.target.data);
			book_array=new Array();
			var o:Object;
			for(var i:int=0;i<xml.children().length();i++)
			{
				o=new Object();
				o.id=xml.children()[i].attribute("id");
				o.name=xml.children()[i].attribute("name");
				o.pic=xml.children()[i].attribute("pic");
				book_array.push(o);
			}
			init();
		}
		private function init():void
		{
			container=new Sprite();
			container.x=sheetWidth;
			container.y=100;
			this.addChild(container);
			book=new Sprite();
			container.addChild(book);
			sheet=new Sprite();
			container.addChild(sheet);
			hit=new Sprite();
			container.addChild(hit);
			initBook();
			initSheet();
			initHit();
		}
		private function initBook():void
		{
			book_mc_array=new Array();
			var mc:MovieClip=new MovieClip();
			book.addChild(mc);
			book_mc_array.push(mc);
			var item:Sprite;
			var loader:Loader;
			for(var i:int=0;i<book_array.length;i++)
			{
				item=new Sprite();
				loader=new Loader();
				loader.load(new URLRequest(book_array[i].pic));
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadComplete);
				item.addChild(loader);
				book.addChild(item);
				book_mc_array.push(item);
			}
			refreshBook();
		}
		private function refreshBook():void
		{
			var i:int;
			if(currentPage==0 || currentPage==book_array.length-1)
			{
				for(i=0;i<book_mc_array.length;i++)
				{
					if(i==currentPage && i==0 || i==currentPage+1)
					{
						book_mc_array[i].visible=true;
						book.setChildIndex(book_mc_array[i],book_array.length-1);
					}
					else if(i==currentPage && i==book_array.length-1)
					{
						book_mc_array[i].visible=true;
						book_mc_array[i].x=-sheetWidth;
						book.setChildIndex(book_mc_array[i],book_array.length-1);
					}
					else
					{
						book_mc_array[i].visible=false;
					}
				}
			}
			else
			{
				for(i=0;i<book_mc_array.length;i++)
				{
					if(i==currentPage)
					{
						book_mc_array[i].visible=true;
						book_mc_array[i].x=-sheetWidth;
						book.setChildIndex(book_mc_array[i],book_array.length-1);
					}
					else if(i==currentPage+1)
					{
						book_mc_array[i].visible=true;
						book_mc_array[i].x=0;
						book.setChildIndex(book_mc_array[currentPage+1],book_array.length-2);
					}
					else
					{
						book_mc_array[i].visible=false;
					}
				}
			}
		}
		private function initSheet():void
		{
			render=new Shape();
			sheet.addChild(render);
		}
		private function initHit():void
		{
			hit_mc_array=new Array();
			var item:MovieClip;
			for(var i:int=0;i<hit_array.length;i++)
			{
				item=new Hit();
				item.x=hit_array[i].x;
				item.y=hit_array[i].y;
				hit.addChild(item);
				hit_mc_array.push(item);
			}
			refreshHit();
		}
		private function refreshHit():void
		{
			if(currentPage==0)
			{
				hit_mc_array[0].buttonMode=false;
				hit_mc_array[0].removeEventListener(MouseEvent.MOUSE_DOWN,hitDown);
				hit_mc_array[1].buttonMode=false;
				hit_mc_array[1].removeEventListener(MouseEvent.MOUSE_DOWN,hitDown);
				hit_mc_array[2].buttonMode=true;
				hit_mc_array[2].addEventListener(MouseEvent.MOUSE_DOWN,hitDown);
				hit_mc_array[3].buttonMode=true;
				hit_mc_array[3].addEventListener(MouseEvent.MOUSE_DOWN,hitDown);
			}
			else if(currentPage==book_array.length)
			{
				hit_mc_array[0].buttonMode=true;
				hit_mc_array[0].addEventListener(MouseEvent.MOUSE_DOWN,hitDown);
				hit_mc_array[1].buttonMode=true;
				hit_mc_array[1].addEventListener(MouseEvent.MOUSE_DOWN,hitDown);
				hit_mc_array[2].buttonMode=false;
				hit_mc_array[2].removeEventListener(MouseEvent.MOUSE_DOWN,hitDown);
				hit_mc_array[3].buttonMode=false;
				hit_mc_array[3].removeEventListener(MouseEvent.MOUSE_DOWN,hitDown);
			}
			else
			{
				hit_mc_array[0].buttonMode=true;
				hit_mc_array[0].addEventListener(MouseEvent.MOUSE_DOWN,hitDown);
				hit_mc_array[1].buttonMode=true;
				hit_mc_array[1].addEventListener(MouseEvent.MOUSE_DOWN,hitDown);
				hit_mc_array[2].buttonMode=true;
				hit_mc_array[2].addEventListener(MouseEvent.MOUSE_DOWN,hitDown);
				hit_mc_array[3].buttonMode=true;
				hit_mc_array[3].addEventListener(MouseEvent.MOUSE_DOWN,hitDown);
			}
		}
		private function hitDown(event:MouseEvent):void
		{
			currentHit=event.target as MovieClip;
			enabledHit(false);
			changeBook(event.target.x);
			currentPoint=getPoint(event.target as MovieClip);
			getBitmap(event.target.x);
			stage.addEventListener(Event.ENTER_FRAME,renderPage);
			stage.addEventListener(MouseEvent.MOUSE_UP,hitUp);
		}
		private function renderPage(event:Event):void
		{
			if(currentHit.x>0)
			{
				flip(hit.mouseX,hit.mouseY);
			}
			else
			{
				flip(sheetWidth+hit.mouseX,hit.mouseY);
			}
		}
		private var tween_mc:MovieClip;
		private function hitUp(event:MouseEvent):void
		{
			stage.removeEventListener(Event.ENTER_FRAME,renderPage);
			stage.removeEventListener(MouseEvent.MOUSE_UP,hitUp);
			var xTo:Number;
			var yTo:Number;
			pointMouse.x=hit.mouseX;
			pointMouse.y=hit.mouseY;
			tween_mc=new Hit();
			tween_mc.x=pointMouse.x;
			tween_mc.y=pointMouse.y;
			hit.addChild(tween_mc);
			tween_mc.addEventListener(Event.ENTER_FRAME,autoPage);
			if(currentHit.x>0)
			{
				if(pointMouse.x<=0)
				{
					isCan=true;
					xTo=-sheetWidth;
					yTo=currentHit.y>0 ? sheetHeight : 0;
					Tweener.addTween(tween_mc,{x:xTo,y:yTo,time:.5,delay:0,transition:"eaeOutCubic",onComplete:tweenComplete});
				}
				else
				{
					xTo=sheetWidth;
					yTo=currentHit.y>0 ? sheetHeight : 0;
					Tweener.addTween(tween_mc,{x:xTo,y:yTo,time:.5,delay:0,transition:"eaeOutCubic",onComplete:tweenComplete});
				}
			}
			else
			{
				if(pointMouse.x>=0)
				{
					isCan=true;
					xTo=sheetWidth;
					yTo=currentHit.y>0 ? sheetHeight : 0;
					Tweener.addTween(tween_mc,{x:xTo,y:yTo,time:.5,delay:0,transition:"eaeOutCubic",onComplete:tweenComplete});
				}
				else
				{
					xTo=-sheetWidth;
					yTo=currentHit.y>0 ? sheetHeight : 0;
					Tweener.addTween(tween_mc,{x:xTo,y:yTo,time:.5,delay:0,transition:"eaeOutCubic",onComplete:tweenComplete});
				}
			}
		}
		private function tweenComplete():void
		{
			tween_mc.removeEventListener(Event.ENTER_FRAME,autoPage);
			hit.removeChild(tween_mc);
			if(isCan)
			{
				isCan=false;
				if(currentHit.x>0)
				{
					currentPage+=2;
				}
				else
				{
					currentPage-=2;
				}
			}
			refreshHit();
			refreshBook();
			render.graphics.clear();
		}
		private function autoPage(event:Event):void
		{
			if(currentHit.x>0)
			{
				flip(tween_mc.x,tween_mc.y);
			}
			else
			{
				flip(sheetWidth+tween_mc.x,tween_mc.y);
			}
		}
		private function changeBook(targetX:Number):void
		{
			if(targetX>0)
			{
				render.x=0;
				book_mc_array[currentPage+1].visible=false;
				if(currentPage+3< book_array.length)
				{
					book_mc_array[currentPage+3].visible=true;
				}
			}
			else
			{
				render.x=-sheetWidth;
				book_mc_array[currentPage].visible=false;
				if(currentPage-2>0)
				{
					book_mc_array[currentPage-2].visible=true;
				}
			}
		}
		private function enabledHit(isEnabled:Boolean):void
		{
			for(var i:int=0;i<hit_array.length;i++)
			{
				hit_mc_array[i].buttonMode=isEnabled;
				if(isEnabled)
				{
					hit_mc_array[i].addEventListener(MouseEvent.MOUSE_DOWN,hitDown);
				}
				else
				{
					hit_mc_array[i].removeEventListener(MouseEvent.MOUSE_DOWN,hitDown);
				}
			}
		}
		private function flip(xTo:Number,yTo:Number):void
		{
			render.graphics.clear();
			var o:Object = PageFlip.computeFlip(new Point(xTo,yTo),	// flipped point
						currentPoint,		// of bottom-right corner
						sheetWidth,		// size of the sheet
						sheetHeight,
						true,				// in horizontal mode
						1);					
			PageFlip.drawBitmapSheet(o,					// computeflip returned object
						render,					// target
						page0,		// bitmap page 0
						page1);		// bitmap page 1
		}
		private function getBitmap(targetX:Number):void
		{
			var direct:Number=targetX>0 ? 1 : -1;
			var p0:Number=direct >0 ? currentPage+1 : currentPage;
			var p1:Number=direct >0 ? currentPage+2 : currentPage-1;
			page0=new BitmapData(sheetWidth,sheetHeight,true,0);
			page0.draw(book_mc_array[p0]);
			page1=new BitmapData(sheetWidth,sheetHeight,true,0);
			page1.draw(book_mc_array[p1]);
		}
		private function getPoint(target:MovieClip):Point
		{
			for(var i:int=0;i<hit_mc_array.length;i++)
			{
				if(hit_mc_array[i]==target)
				{
					return point_array[i];
				}
			}
			return new Point(0,0);
		}
		private function loadComplete(event:Event):void
		{
			var target:*=event.target.content;
			target.width=sheetWidth;
			target.height=sheetHeight;
		}
		private function setStage(event:Event):void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.showDefaultContextMenu = false;
		}
	}
}