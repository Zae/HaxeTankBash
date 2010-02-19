package com.tankbash 
{
	import com.greensock.TweenLite;
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import com.greensock.easing.*;
	import explosion;
	
	/**
	 * ...
	 * @author Ezra Pool
	 */
	public class Wall extends MovieClip
	{
		public static const TYPE_WOOD:String = "WallType_Wood";
		public static const TYPE_METAL:String = "WallType_Metal";
		public static const TYPE_CONCRETE:String = "WallType_Concrete";
		
		[Embed(source="../../../assets/building_1.png")]//"../../../assets/wood_object.png")]
		private static var WoodVisual:Class;
		[Embed(source="../../../assets/metaal_object.png")]
		private static var MetalVisual:Class;
		[Embed(source="../../../assets/muur_object.png")]
		private static var ConcreteVisual:Class;
		
		private var _hp:int;
		private var _wallType:String;
		private var _strength:int;
		
		private var moveTween:TweenLite;
		
		private var _explosion:explosion;
		
		public function Wall(wallType:String) 
		{
			this._wallType = wallType;
			switch(wallType)
			{
				case TYPE_WOOD:
					addChild(new WoodVisual());
					_hp = Main.instance.settings.wall.wood.@hp;
					_strength = Main.instance.settings.wall.wood.@strength;
					break;
				case TYPE_METAL:
					addChild(new MetalVisual());
					_hp = Main.instance.settings.wall.metal.@hp;
					_strength = Main.instance.settings.wall.metal.@strength;
					break;
				case TYPE_CONCRETE:
					addChild(new ConcreteVisual());
					_hp = Main.instance.settings.wall.concrete.@hp;
					_strength = Main.instance.settings.wall.concrete.@strength;
					break; 
			}
			Main.instance.tank.addEventListener(AmmoEvent.AMMO_FIRED, onAmmoFire, false, 0, true);
			
			this.scaleX = 1;
			this.scaleY = 1;
			this.x = 1200;
			this.y = Main.instance.stage.stageHeight-Main.instance.stage.stageHeight/100*5 - this.height;
			moveTween = TweenLite.to(this, Main.instance.timer.delay / 1000, { x: 0, ease: Linear.easeNone, onUpdate: onWallMove, onComplete: onMoveComplete } );
			trace(Main.instance.timer.delay / 1000);
		}
		private function onMoveComplete():void 
		{
			this.destroyed();
		}
		private function onWallMove():void 
		{
			this.dispatchEvent(new WallEvent(WallEvent.WALL_MOVE, this));
			if (this.hitTestObject(Main.instance.tank)) {
				this.destroyed();
				Main.instance.tank.hit(this._strength);
				if(Main.instance.tank.hp <= 0){
					Main.instance.tank.destroy();
				}
			}
		}
		private function onAmmoFire(e:AmmoEvent):void 
		{
			trace("fired");
			Main.instance.tank.addEventListener(AmmoEvent.AMMO_MOVE, onAmmoMove, false, 0, true);
		}
		private function onAmmoMove(e:AmmoEvent):void 
		{
			trace("swooosh");
			if (this.hitTestObject(e.ammo))
			{
				trace("paf");
				this._hp -= e.ammo.strength;
				e.ammo.hit();
				if (this._hp <= 0) {
					trace("wall destroyed!");
					this.destroyed();
				}else {
					trace(this._hp + " left");
					if (_explosion)
					{
						this.removeChild(this._explosion);
					}
					this._explosion = new explosion();
					this.addChild(this._explosion);
					this._explosion.y = 100;
				}
			}
		}
		private function destroyed():void 
		{
			moveTween.kill();
			Main.instance.tank.removeEventListener(AmmoEvent.AMMO_MOVE, onAmmoMove);
			Main.instance.tank.removeEventListener(AmmoEvent.AMMO_FIRED, onAmmoFire);
			this.dispatchEvent(new WallEvent(WallEvent.WALL_DESTROYED, this));
		}
		public function get strength():int 
		{
			return _strength;
		}
	}

}