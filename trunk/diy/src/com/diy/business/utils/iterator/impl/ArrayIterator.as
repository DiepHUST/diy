package com.diy.business.utils.iterator.impl
{
	import com.diy.views.common.utils.iterator.IIterator;
	
	/**
	 * ...
	 * @author Sheldon Song
	 * @homepage http://xinzy10.vicp.net
	 * @email xinzy10@gmail.com
	 * @version Version 1.0
	 * @description the class function
	 */
	public class ArrayIterator implements IIterator
	{
		private var _index:uint = 0;
		private var _collection:Array;
		public function ArrayIterator(collection:Array) 
		{
			this._collection = collection;
			this._index = 0;
		}
		
		public function hasNext():Boolean
		{
			return _index < this._collection.length;
		}
		
		public function next():Object
		{
			return _collection[_index++];
		}
		
		public function reset():void
		{
			_index = 0;
		}
	}
	
}