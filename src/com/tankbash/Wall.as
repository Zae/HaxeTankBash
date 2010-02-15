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
		
		[Embed(source="../../../assets/smile.jpg")]
		private static var WoodVisual:Class;
		private static var MetalVisual:Class;
		private static var ConcreteVisual:Class;
		
		private var _hp:int;
		
		public function Wall(wallType:String) 
		{
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
			Main.instance.tank.addEventListener(AmmoEvent.AMMO_MOVE, onAmmoMove);
		}
		private function onAmmoMove(e:AmmoEvent):void 
		{
			if (e.ammo.hitTestObject(this)) {
				//paf
				this._hp -= e.ammo.strength;
				e.ammo.hit();
				if (this._hp <= 0) {
					this.destroyed();
				}
			}
		}
		private function destroyed():void 
		{
			
		}
	}

}