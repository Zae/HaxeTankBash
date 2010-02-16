package com.tankbash 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ezra Pool
	 */
	public class TankEvent extends Event 
	{
		public static const TANK_DESTROYED:String = "tankEventMove";
		
		private var tankReference:Tank;
		
		public function TankEvent(type:String = "tankEventMove", tank:Tank=null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			if (!tank) {
				tankReference = tank;
				super(type, bubbles, cancelable);
			}
		} 
		
		public override function clone():Event 
		{ 
			return new TankEvent(type, tankReference, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("TankEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get tank():Tank
		{
			return tankReference;
		}
	}
	
}