package com.diy.views.common.utils.iterator.impl
{
	import com.diy.views.common.utils.iterator.ICollection;
	import com.diy.views.common.utils.iterator.IIterator;
	
	/**
	 * ...
	 * @author Sheldon Song
	 * @homepage http://xinzy10.vicp.net
	 * @email xinzy10@gmail.com
	 * @version Version 1.0
	 * @description the class function
	 */
	public class UIntCollection implements ICollection
	{
		private var _data:Array;

		public function UIntCollection() 
		{
			_data = new Array();
		}
		
		public function addElement(value:uint):void
		{
			_data.push(value);
		}
		
		public function iterator(type:String = null):IIterator
		{
			return new ArrayIterator(_data);
		}
	}
		
}