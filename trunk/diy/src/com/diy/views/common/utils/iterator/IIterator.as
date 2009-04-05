package com.diy.views.common.utils.iterator 
{
	
	/**
	 * ...
	 * @author Sheldon Song
	 * @homepage http://xinzy10.vicp.net
	 * @email xinzy10@gmail.com
	 * @version Version 1.0
	 * @description the class function
	 */
	public interface IIterator 
	{
		function reset():void;
		function next():Object;
		function hasNext():Boolean;
	}
	
}