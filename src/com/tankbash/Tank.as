package com.tankbash
{
	import containing_fla.tank_niveau3_2;
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
		private var tank:tank_niveau3_2;
		
		private var _health:int;
		private var _ammo:Vector.<Ammo>;
		private var _ammoType:String;
		private var ammoFlying:Boolean = false;
		
		public function Tank() 
		{
			init();
			this._ammo = new Vector.<Ammo>;
		}
		private function init():void
		{
			this._ammoType = Ammo.TYPE_DEFAULT;
			tank = new tank_niveau3_2();
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
			if (!this.ammoFlying)
			{
				this.ammoFlying = true;
				var newAmmo:Ammo = new Ammo(this._ammoType);
				newAmmo.addEventListener(AmmoEvent.AMMO_DESTROYED, onAmmoDestroyed);
				newAmmo.addEventListener(AmmoEvent.AMMO_MOVE, onAmmoMove);
				Main.instance.addChild(newAmmo);
				newAmmo.y = this.y;
				this._ammo.push(newAmmo);
				newAmmo.fire();
				this.dispatchEvent(new AmmoEvent(AmmoEvent.AMMO_FIRED, newAmmo, this._ammoType));
			}
		}
		
		/**
		 * Destroy the tank
		 */
		public function destroy():void
		{
			this.dispatchEvent(new TankEvent(TankEvent.TANK_DESTROYED, this));
		}
		
		/**
		 * Get the current health
		 * @return int the current health
		 */
		public function get health():int
		{
			return _health;
		}
		
		/**
		 * Set the new health
		 * @param int the new health
		 */
		public function set health(setHealth:int):void
		{
			_health = setHealth;
		}
		
		/**
		 * Set the new ammo type
		 * @param String the new ammo type
		 */
		public function set setAmmoType(setAmmo:String):void
		{
			_ammoType = setAmmo;
			this.dispatchEvent(new AmmoEvent(AmmoEvent.AMMO_CHANGE, null, this._ammoType));
		}
		private function onAmmoDestroyed(e:AmmoEvent):void 
		{
			trace("KABOOOOM");
			for (var i:int = 0; i < Main.instance.numChildren; i++)
			{
				if (Main.instance.getChildAt(i) === e.ammo) {
					trace("FOUND!"+e.ammo.strength);
					Main.instance.removeChildAt(i);
					break;
				}
				trace("CAN'T FIND IT");
			}
			for (var j:int = 0; j < this._ammo.length; j++)
			{
				if (this._ammo[j] === e.ammo)
				{
					e.ammo.removeEventListener(AmmoEvent.AMMO_DESTROYED, onAmmoDestroyed);
					e.ammo.removeEventListener(AmmoEvent.AMMO_MOVE, onAmmoMove);
					var refkill:Ammo = e.ammo;
					refkill = null;
					refkill;
					this._ammo.splice(j, 1);
				}
			}
			
			this.ammoFlying = false;
		}
		/**
		 * Get the current ammo type
		 * @return Ammo the current ammo type
		 */
		/*public function get currentAmmo():Ammo
		{
			return _ammo;
		}*/
	}

}