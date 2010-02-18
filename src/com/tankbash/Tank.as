package com.tankbash
{
	import tank_niveau3;
	import flash.display.MovieClip;
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.display.Bitmap;
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import com.greensock.TweenLite;
	/**
	 * ...
	 * 
	 * @author Sytze
	 * @version 0.1;
	 */
	public class Tank extends MovieClip
	{
		private var tank:tank_niveau3;
		
		private var _health:int;
		private var _ammo:Vector.<Ammo>;
		private var _ammoType:String;
		private var ammoFlying:Boolean = false;
		
		[Embed(source = "../../../assets/wpnChange.mp3")]
		private var _wpnChange:Class;
		
		
		[Embed(source = "../../../assets/rocket.mp3")]
		private var _rocket:Class;
		[Embed(source = "../../../assets/bullet.mp3")]
		private var _bullet:Class;
		[Embed(source = "../../../assets/tankbullet.mp3")]
		private var _tankbullet:Class;
		
		private var wpnChange:Sound;
		private var rocket:Sound;
		private var bullet:Sound;
		private var tankbullet:Sound;
		
		private var killed:Boolean = false;
		
		private var _hp:int;
		
		public function Tank() 
		{
			init();
		}
		private function init():void
		{
			this._hp = Main.instance.settings.tank.@hp;
			this._ammo = new Vector.<Ammo>;
			this._ammoType = Ammo.TYPE_DEFAULT;
			tank = new tank_niveau3();
			addChild(tank);
			
			wpnChange = new _wpnChange();
			rocket = new _rocket();
			bullet = new _bullet();
			tankbullet = new _tankbullet();
			
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
			if(!killed){
				if (!this.ammoFlying)
				{
					var shootAllowed:Boolean = false;
					var playSound:Sound;
					switch (this._ammoType) 
					{
						case Ammo.TYPE_BULLETS:
							if (Ammo.bullets_left > 0)
							{
								shootAllowed = true;
								playSound = bullet;
							}
							break;
						case Ammo.TYPE_CANNON:
							if (Ammo.cannon_left > 0)
							{
								shootAllowed = true;
								playSound = tankbullet;
							}
							break;
						case Ammo.TYPE_ROCKET:
							if (Ammo.rockets_left > 0)
							{
								shootAllowed = true;
								playSound = rocket;
							}
							break;
					}
					if(shootAllowed){
						this.ammoFlying = true;
						var newAmmo:Ammo = new Ammo(this._ammoType);
						newAmmo.addEventListener(AmmoEvent.AMMO_DESTROYED, onAmmoDestroyed, false, 0, true);
						newAmmo.addEventListener(AmmoEvent.AMMO_MOVE, onAmmoMove, false, 0, true);
						Main.instance.addChild(newAmmo);
						newAmmo.y = this.y;
						this._ammo.push(newAmmo);
						newAmmo.fire();
						this.dispatchEvent(new AmmoEvent(AmmoEvent.AMMO_FIRED, newAmmo, this._ammoType));
						playSound.play();
					}
				}
			}
		}
		
		/**
		 * Destroy the tank
		 */
		public function destroy():void
		{
			this.dispatchEvent(new TankEvent(TankEvent.TANK_DESTROYED, this));
			killed = true;
		}
		public function hit(strength:int):void 
		{
			this._hp -= strength;
			trace("tank HP LEFT: "+this._hp);
			this.dispatchEvent(new TankEvent(TankEvent.TANK_HIT, this));
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
			wpnChange.play();
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
		public function get hp():int 
		{
			return _hp;
		}
	}

}