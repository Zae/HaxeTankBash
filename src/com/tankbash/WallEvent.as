package com.tankbash 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ezra Pool
	 */
	public class WallEvent extends Event 
	{
		private var Wall_Reference:Wall;
		
		public static const WALL_DESTROYED:String = "WallEventDestroyed";
		
		public function WallEvent(type:String="WallEventDestroyed", wall:Wall=null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			if (wall)
			{
				Wall_Reference = wall;
				super(type, bubbles, cancelable);	
			}
		} 
		
		public override function clone():Event 
		{ 
			return new WallEvent(type, wall, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("WallEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		public function get wall():Wall 
		{
			return Wall_Reference;
		}
	}
	
}