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
		
		[Embed(source="../../../assets/smile.jpg")]
		private static var RocketVisual:Class;
		private static var BulletsVisual:Class;
		private static var CannonVisual:Class;
		
		private var _strenght:int;
		
		public function Ammo(ammoType:String = "AmmoType_Rocket")
		{
			switch(ammoType) {
				case TYPE_ROCKET:
					addChild(new RocketVisual());
					_strenght = 10;
					break;
				case TYPE_BULLETS:
					//..
					break;
				case TYPE_CANNON:
					//..
					break;
			}
		}
		/**
		 * 
		 * @return Boolean Has the ammo been fired?
		 */
		public function fire():Boolean{
			TweenLite.to(this, 5, { x:Main.instance.stage.stageWidth, onUpdate: onAmmoMove, onComplete: onAmmoComplete } );
			return false;
		}
		private function onAmmoMove():void 
		{
			this.dispatchEvent(new AmmoEvent(AmmoEvent.AMMO_MOVE, this));
		}
		private function onAmmoComplete():void 
		{
			this._strenght = 0;
			this.dispatchEvent(new AmmoEvent(AmmoEvent.AMMO_DESTROYED, this));
		}
		public function get strenght():int
		{
			return _strenght;
		}
	}
}