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
		private var Ammo_Type:String;
		
		public static const AMMO_FIRED:String = "AmmoEventFired";
		public static const AMMO_MOVE:String = "AmmoEventMove";
		public static const AMMO_DESTROYED:String = "AmmoEventDestroyed";
		public static const AMMO_RELOAD:String = "AmmoEventReload";
		public static const AMMO_CHANGE:String = "AmmoEventChange";
		public static const AMMO_EMPTY:String = "AmmoEventEmpty";
		
		public function AmmoEvent(type:String="AmmoEventFired", ammo:Ammo=null, ammoType:String = null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			Ammo_Reference = ammo;
			Ammo_Type = ammoType;
			super(type, bubbles, cancelable);
		} 
		/**
		 * clone the event
		 * @return Event
		 */
		public override function clone():Event 
		{ 
			return new AmmoEvent(type, ammo, ammo_type, bubbles, cancelable);
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
		public function get ammo_type():String {
			return Ammo_Type;
		}
	}
}