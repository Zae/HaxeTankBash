package com.tankbash 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ezra Pool
	 * @version 0.1
	 * @eventType Ammo_Fired
	 */
	public class AmmoEvent extends Event 
	{
		private var Ammo_Reference:Ammo;
		
		public static const AMMO_FIRED:String = "AmmoEventFired";
		
		public function AmmoEvent(type:String="AmmoEventFired", ammo:Ammo=null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			if (ammo){
				Ammo_Reference = ammo;
				super(type, bubbles, cancelable);
			}
		} 
		/**
		 * clone the event
		 * @return Event
		 */
		public override function clone():Event 
		{ 
			return new Ammo_Fired(type, bubbles, cancelable);
		} 
		/**
		 * express the object as a string
		 * @return String
		 */
		public override function toString():String 
		{ 
			return formatToString("AmmoEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get ammo():Ammo 
		{
			return Ammo_Reference;
		}
	}
	
}