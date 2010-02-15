package com.tankbash 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ezra Pool
	 * @version 0.1
	 * @eventType Ammo_Fired
	 */
	public class Ammo_Fired extends Event 
	{
		private var Ammo_Reference:Ammo;
		
		public function Ammo_Fired(type:String, bubbles:Boolean=false, cancelable:Boolean=false, ammo:Ammo=null) 
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
			return formatToString("Ammo_Fired", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get ammo():Ammo 
		{
			return Ammo_Reference;
		}
	}
	
}