package com.tankbash
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
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
			addChild(tank);
			addChild(lvl);
			walls = new Array(new Wall(Wall.TYPE_WOOD), new Wall(Wall.TYPE_WOOD));
			addChild(walls[0]);
			addChild(walls[1]);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyboardHandler);
		}
		
		private function keyboardHandler(e:KeyboardEvent):void
		{
			switch (e.keyCode)
			{
				case Keyboard.SPACE:
					tank.shoot();
					trace('SPACEBAR PRESSED: tank.shoot()');
					break;
			}
		}
	}
}
