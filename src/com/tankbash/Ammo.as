package com.tankbash 
{
	import com.greensock.TweenLite;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ezra Pool
	 * @version 0.1;
	 **/
	public class Ammo extends MovieClip
	{
		public static const TYPE_ROCKET:String = "AmmoType_Rocket";
		public static const TYPE_BULLETS:String = "AmmoType_Bullets";
		public static const TYPE_CANNON:String = "AmmoType_Cannon";
		public static const TYPE_DEFAULT:String = TYPE_BULLETS;
		
		[Embed(source="../../../assets/rocket.png")]
		private static var RocketVisual:Class;
		[Embed(source="../../../assets/bullet.png")]
		private static var BulletsVisual:Class;
		[Embed(source="../../../assets/tank_bullet.png")]
		private static var CannonVisual:Class;
		
		private var _strength:int;
		private var _ammoType:String;
		
		public function Ammo(ammoType:String = "AmmoType_Bullets")
		{
			this._ammoType = ammoType;
			switch(ammoType) {
				case TYPE_ROCKET:
					addChild(new RocketVisual());
					_strength = Main.instance.settings.ammo.rocket.@strength;
					break;
				case TYPE_BULLETS:
					addChild(new BulletsVisual());
					_strength = Main.instance.settings.ammo.bullets.@strength;
					break;
				case TYPE_CANNON:
					addChild(new CannonVisual());
					_strength = Main.instance.settings.ammo.cannon.@strength;
					break;
			}
		}
		/**
		 * 
		 * @return Boolean Has the ammo been fired?
		 */
		public function fire():Boolean {
			switch(_ammoType)
			{
				case Ammo.TYPE_BULLETS:
					TweenLite.to(this, Main.instance.settings.ammo.bullets.@speed, { x:Main.instance.stage.stageWidth, onUpdate: onAmmoMove, onComplete: onAmmoComplete } );
					break;
				case Ammo.TYPE_CANNON:
					TweenLite.to(this, Main.instance.settings.ammo.cannon.@speed, { x:Main.instance.stage.stageWidth, onUpdate: onAmmoMove, onComplete: onAmmoComplete } );
					break;
				case Ammo.TYPE_ROCKET:
					TweenLite.to(this, Main.instance.settings.ammo.rocket.@speed, { x:Main.instance.stage.stageWidth, onUpdate: onAmmoMove, onComplete: onAmmoComplete } );
					break;
			}
			return false;
		}
		private function onAmmoMove():void 
		{
			this.dispatchEvent(new AmmoEvent(AmmoEvent.AMMO_MOVE, this));
		}
		private function onAmmoComplete():void 
		{
			this._strength = 0;
			this.dispatchEvent(new AmmoEvent(AmmoEvent.AMMO_DESTROYED, this));
		}
		public function hit():void 
		{
			this.dispatchEvent(new AmmoEvent(AmmoEvent.AMMO_DESTROYED, this));
		}
		public function get strength():int
		{
			return _strength;
		}
	}
}