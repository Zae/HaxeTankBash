package com.tankbash
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Sytze
	 */
	public class Main extends MovieClip
	{
		[Embed(source = "../../../assets/instructions.png")]
		private var instructions:Class;
		
		public var settings:Settings;
		public var tank:Tank;
		private var lvl:LevelOne;
		private var walls:Vector.<Wall>;
		public var hud:HUD;
		public var timer:Timer;
		private var loadingScreen:Bitmap;
		
		private static var _instance:Main;
		public static function get instance():Main { return _instance; }
		
		public function Main():void 
		{
			_instance = this;
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			settings = new Settings();
			settings.addEventListener(Event.COMPLETE, settingsLoaded);
		}
		
		private function settingsLoaded(e:Event):void 
		{
			loadingScreen = new instructions();
			addChild(loadingScreen);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, spaceDown);
		}
		private function onTankEvent(e:TankEvent):void
		{
			switch (e.type) 
			{
				case TankEvent.TANK_DESTROYED:
					trace("CRAAAASH");
					for (var i:int = 0; i < this.numChildren; i++)
					{
						if (this.getChildAt(i) === e.tank)
						{
							this.removeChildAt(i);
							tank.removeEventListener(TankEvent.TANK_DESTROYED, onTankEvent);
							trace("Destroyed the tank");
							timer.stop();
							break;
						}
						trace("Didn't find a tank!");
					}
					break;
			}
		}
		private function onTimerTik(e:TimerEvent):void
		{
			var walltypes:Array = new Array(Wall.TYPE_WOOD, Wall.TYPE_METAL, Wall.TYPE_CONCRETE);
			var randwall:int = Math.round(Math.random() * 2);
			var tmp:Wall = new Wall(walltypes[randwall]);
			addChild(tmp);
			tmp.addEventListener(WallEvent.WALL_DESTROYED, onWallEvent);
			walls.push(tmp);
			if (timer.delay > 5000)
			{
				timer.delay -= 700;
			}else if (timer.delay > 2000)
			{
				timer.delay -= 500;
			}else if (timer.delay > 900)
			{
				timer.delay -= 300;
			}
		}
		private function onWallEvent(e:WallEvent):void 
		{
			switch (e.type) 
			{
				case WallEvent.WALL_DESTROYED:
					trace("muurtje weghalen");
					this.dispatchEvent(e);
					for (var j:int = 0; j < walls.length; j++)
					{
						if (walls[j] === e.wall)
						{
							trace("wallIndex"+j);
							for (var i:int = 0; i < this.numChildren; i++)
							{
								if (this.getChildAt(i) === e.wall)
								{
									trace("FOUND-WALL!");
									this.removeChildAt(i);
									break;
								}
								trace("CAN'T FIND IT-WALL");
							}
							walls[j].removeEventListener(WallEvent.WALL_DESTROYED, onWallEvent);						
							walls[j] = null;
							walls.splice(j, 1);
						}
					}
					break;
			}
		}
		private function keyboardHandler(e:KeyboardEvent):void
		{
			trace(e.keyCode);
			switch (e.keyCode)
			{
				case Keyboard.SPACE:
					tank.shoot();
					trace('SPACEBAR PRESSED: tank.shoot()');
					break;
					
				case 49:
					tank.setAmmoType = Ammo.TYPE_BULLETS;
					break;
					
				case 50:
					tank.setAmmoType = Ammo.TYPE_ROCKET;
					break;
					
				case 51:
					tank.setAmmoType = Ammo.TYPE_CANNON;
					break;
			}
		}
		private function spaceDown(e:KeyboardEvent):void 
		{
			switch (e.keyCode) 
			{
				case Keyboard.SPACE:
					removeChild(loadingScreen);
					loadingScreen = null;
					
					timer = new Timer(5 * 1000);
					timer.addEventListener(TimerEvent.TIMER, onTimerTik);
					timer.start();
					
					tank = new Tank();
					tank.y = stage.stageHeight - stage.stageHeight/100*20;
					tank.x = 175;
					tank.scaleX = .4;
					tank.scaleY = .4;
					tank.addEventListener(TankEvent.TANK_DESTROYED, onTankEvent);
					
					lvl = new LevelOne();
					addChild(lvl);
					addChild(tank);
					walls = new Vector.<Wall>;
					
					hud = new HUD();
					addChild(hud);
					stage.addEventListener(KeyboardEvent.KEY_DOWN, keyboardHandler);
					stage.removeEventListener(KeyboardEvent.KEY_DOWN, spaceDown);
					break;
			}
		}
	}
}
