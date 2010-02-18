package com.tankbash 
{
	import com.greensock.TweenLite;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.media.Sound;
	
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
		
		private static var bullets:int = Main.instance.settings.ammo.bullets.@startAmount;
		private static var rockets:int = Main.instance.settings.ammo.rocket.@startAmount;
		private static var cannons:int = Main.instance.settings.ammo.cannon.@startAmount;
		
		[Embed(source="../../../assets/rocket.png")]
		private static var RocketVisual:Class;
		[Embed(source="../../../assets/bullet.png")]
		private static var BulletsVisual:Class;
		[Embed(source="../../../assets/tank_bullet.png")]
		private static var CannonVisual:Class;
		[Embed(source = "../../../assets/impact.mp3")]
		private var _impact:Class;
		private var impact:Sound;
		
		private var _strength:int;
		private var _ammoType:String;
		
		private var moveTween:TweenLite;
		
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
			
			impact = new _impact();
		}
		/**
		 * 
		 */
		public function fire():void {
			switch(_ammoType)
			{
				case Ammo.TYPE_BULLETS:
					//if(bullets > 0){
						moveTween = TweenLite.to(this, Main.instance.settings.ammo.bullets.@speed, { x:Main.instance.stage.stageWidth, onUpdate: onAmmoMove, onComplete: onAmmoComplete } );
						bullets--;
					//}
					break;
				case Ammo.TYPE_CANNON:
					//if(cannons > 0){
						moveTween = TweenLite.to(this, Main.instance.settings.ammo.cannon.@speed, { x:Main.instance.stage.stageWidth, onUpdate: onAmmoMove, onComplete: onAmmoComplete } );
						cannons--;
					//}
					break;
				case Ammo.TYPE_ROCKET:
					//if (rockets > 0) {
						moveTween = TweenLite.to(this, Main.instance.settings.ammo.rocket.@speed, { x:Main.instance.stage.stageWidth, onUpdate: onAmmoMove, onComplete: onAmmoComplete } );
						rockets--;
					//}
					break;
			}
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
			trace("Hit something");
			moveTween.kill();
			this.dispatchEvent(new AmmoEvent(AmmoEvent.AMMO_DESTROYED, this));
			impact.play();
		}
		public function get strength():int
		{
			return _strength;
		}
		public static function get bullets_left():int 
		{
			return bullets;
		}
		public static function get rockets_left():int 
		{
			return rockets;
		}
		public static function get cannon_left():int 
		{
			return cannons;
		}
	}
}