package com.tankbash
{
	import flash.display.MovieClip;
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.display.Bitmap;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * 
	 * @author Sytze
	 * @version 0.1;
	 */
	public class Tank extends MovieClip
	{
		[Embed(source = "../../../assets/tank.jpg")]
		private var t:Class;
		private var tank:Bitmap;
		
		private var _health:int;
		private var _ammo:Ammo;
				
		public function Tank() 
		{
			init();
		}
		
		private function init():void
		{
			tank = new t();
			addChild(tank);
			this.ammo = new Ammo(Ammo.TYPE_BULLETS);
		};
		
		/**
		 * Dispatches the shooting event
		 */
		public function shoot():void
		{
			this.currentAmmo.fire();
			this.dispatchEvent(new AmmoEvent(AmmoEvent.AMMO_FIRED, this.currentAmmo));
		};
		
		/**
		 * Destroy the tank
		 */
		public function destroy():void
		{
			removeChild(tank);
		};
		
		/**
		 * Get the current health
		 * @return int the current health
		 */
		public function get health():int
		{
			return _health;
		};
		
		/**
		 * Set the new health
		 * @param int the new health
		 */
		public function set health(setHealth:int):void
		{
			_health = setHealth;
		};
		
		/**
		 * Set the new ammo type
		 * @param String the new ammo type
		 */
		public function set ammo(setAmmo:String):void
		{
			_ammo = new Ammo(setAmmo);
		};
		
		/**
		 * Get the current ammo type
		 * @return Ammo the current ammo type
		 */
		public function get currentAmmo():Ammo
		{
			return _ammo;
		};
	}

}