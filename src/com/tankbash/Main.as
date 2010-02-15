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
		private var tank:Tank;
		
		public function Main():void 
		{
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
			addChild(tank);
			
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
