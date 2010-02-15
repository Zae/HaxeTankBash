package com.tankbash 
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Ezra Pool
	 */
	public class Wall extends MovieClip
	{
		public static const TYPE_WOOD:String = "WallType_Wood";
		public static const TYPE_METAL:String = "WallType_Metal";
		public static const TYPE_CONCRETE:String = "WallType_Concrete";
		
		[Embed(source="../../../assets/wood_object.png")]
		private static var WoodVisual:Class;
		[Embed(source="../../../assets/metaal_object.png")]
		private static var MetalVisual:Class;
		[Embed(source="../../../assets/muur_object.png")]
		private static var ConcreteVisual:Class;
		
		private var _hp:int;
		private var _wallType:String;
		
		public function Wall(wallType:String) 
		{
			this._wallType = wallType;
			switch(wallType)
			{
				case TYPE_WOOD:
					addChild(new WoodVisual());
					_hp = 10;
					break;
				case TYPE_METAL:
					addChild(new MetalVisual());
					_hp = 40;
					break;
				case TYPE_CONCRETE:
					addChild(new ConcreteVisual());
					_hp = 80;
					break; 
			}
			Main.instance.tank.addEventListener(AmmoEvent.AMMO_FIRED, onAmmoFire);
		}
		private function onAmmoFire(e:AmmoEvent):void 
		{
			trace("fired");
			Main.instance.tank.addEventListener(AmmoEvent.AMMO_MOVE, onAmmoMove);
		}
		private function onAmmoMove(e:AmmoEvent):void 
		{
			if (e.ammo.hitTestObject(this)) {
				trace("paf");
				this._hp -= e.ammo.strength;
				e.ammo.hit();
				if (this._hp <= 0) {
					this.destroyed();
				}
			}
		}
		private function destroyed():void 
		{
			this.dispatchEvent(new WallEvent(WallEvent.WALL_DESTROYED));
		}
	}

}