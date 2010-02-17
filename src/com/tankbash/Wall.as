﻿package com.tankbash 
{
	import com.greensock.TweenLite;
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import com.greensock.easing.*;
	
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
		
		private var moveTween:TweenLite;
		
		public function Wall(wallType:String) 
		{
			this._wallType = wallType;
			switch(wallType)
			{
				case TYPE_WOOD:
					addChild(new WoodVisual());
					_hp = Main.instance.settings.wall.wood.@hp;
					break;
				case TYPE_METAL:
					addChild(new MetalVisual());
					_hp = Main.instance.settings.wall.metal.@hp;
					break;
				case TYPE_CONCRETE:
					addChild(new ConcreteVisual());
					_hp = Main.instance.settings.wall.concrete.@hp;
					break; 
			}
			Main.instance.tank.addEventListener(AmmoEvent.AMMO_FIRED, onAmmoFire);
			
			this.scaleX = .5;
			this.scaleY = .5;
			this.x = 1200;
			this.y = Main.instance.stage.stageHeight-Main.instance.stage.stageHeight/100*25;
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
				Main.instance.tank.destroy();
			}
		}
		private function onAmmoFire(e:AmmoEvent):void 
		{
			trace("fired");
			Main.instance.tank.addEventListener(AmmoEvent.AMMO_MOVE, onAmmoMove);
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
	}

}