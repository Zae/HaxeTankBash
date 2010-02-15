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
		private var _ammoType:String;
		private var ammoFlying:Boolean = false;
				
		public function Tank() 
		{
			init();
		}
		
		private function init():void
		{
			this._ammoType = Ammo.TYPE_DEFAULT;
			tank = new t();
			addChild(tank);

			this._ammo = new Ammo(this._ammoType);
			this._ammo.addEventListener(AmmoEvent.AMMO_DESTROYED, onAmmoDestroyed);

		};
		
		/**
		 * Dispatches the shooting event
		 */
		public function shoot():void
		{
			this.ammoFlying = true;
			addChild(this.currentAmmo);
			this.currentAmmo.fire();
			//this.dispatchEvent(new AmmoEvent(AmmoEvent.AMMO_FIRED, this.currentAmmo));
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
		public function set setAmmoType(setAmmo:String):void
		{
			_ammoType = setAmmo;
		}
		private function onAmmoDestroyed(e:AmmoEvent):void 
		{
			trace("KABOOOOM");
			try {
				removeChild(this._ammo);
			}catch (err:Error){}
			this._ammo = new Ammo(this._ammoType);
			this._ammo.addEventListener(AmmoEvent.AMMO_DESTROYED, onAmmoDestroyed);
			this.ammoFlying = false;
		}
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