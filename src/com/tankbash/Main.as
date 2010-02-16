package com.tankbash
{
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
		public var settings:Settings;
		public var tank:Tank;
		private var lvl:LevelOne;
		private var walls:Array;
		private var timer:Timer;
		
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
			tank = new Tank();
			lvl = new LevelOne();
			addChild(lvl);
			addChild(tank);
			walls = new Array();
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyboardHandler);
			timer = new Timer(10 * 1000);
			timer.addEventListener(TimerEvent.TIMER, onTimerTik);
			timer.start();
		}
		private function onTimerTik(e:TimerEvent):void
		{
			var tmp:Wall = new Wall(Wall.TYPE_WOOD);
			addChild(tmp);
			tmp.addEventListener(WallEvent.WALL_DESTROYED, onWallEvent);
			walls.push(tmp);
		}
		private function onWallEvent(e:WallEvent):void 
		{
			trace("muurtje weghalen");
			var index:int = walls.indexOf(e.wall);
			try {
				removeChild(walls[index]);
			}catch (err:Error){}
			walls[index] = null;
			walls.splice(index, 1);
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
	}
}
