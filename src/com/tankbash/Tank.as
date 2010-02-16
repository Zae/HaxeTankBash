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
		[Embed(source = "../../../assets/tank_niveau0.png")]
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
		}
		private function onAmmoMove(e:AmmoEvent):void 
		{
			this.dispatchEvent(e);  
		}
		/**
		 * Dispatches the shooting event
		 */
		public function shoot():void
		{
			if(!this.ammoFlying){
				this.ammoFlying = true;
				this._ammo = new Ammo(this._ammoType);
				this._ammo.addEventListener(AmmoEvent.AMMO_DESTROYED, onAmmoDestroyed);
				this._ammo.addEventListener(AmmoEvent.AMMO_MOVE, onAmmoMove);
				this.addChild(this._ammo);			
				this.currentAmmo.fire();
				this.dispatchEvent(new AmmoEvent(AmmoEvent.AMMO_FIRED, this.currentAmmo));
			}
		}
		
		/**
		 * Destroy the tank
		 */
		public function destroy():void
		{
			removeChild(tank);
		}
		
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
			//this.dispatchEvent(new AmmoEvent(AmmoEvent.AMMO_RELOAD, currentAmmo));
		}
		private function onAmmoDestroyed(e:AmmoEvent):void 
		{
			trace("KABOOOOM");
	
			for (var i:int = 0; i < this.numChildren; i++)
			{
				if (this.getChildAt(i) === this._ammo) {
					trace("FOUND!"+e.ammo.strength);
					this.removeChildAt(i);
					break;
				}
				trace("CAN'T FIND IT");
			}
			
			this.ammoFlying = false;
		}
		/**
		 * Get the current ammo type
		 * @return Ammo the current ammo type
		 */
		public function get currentAmmo():Ammo
		{
			return _ammo;
		}
	}

}