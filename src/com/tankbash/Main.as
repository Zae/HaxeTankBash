package com.tankbash
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author Sytze
	 */
	public class Main extends MovieClip
	{
		private var ammo:Ammo = new Ammo();
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			addChild(ammo);
			this.dispatchEvent(new AmmoEvent(AmmoEvent.AMMO_FIRED, ammo));
		}
		
	}
}