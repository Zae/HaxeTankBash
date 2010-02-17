package com.tankbash 
{
	import flash.display.MovieClip;
	import flash.display.Bitmap;
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.events.Event;
	/**
	 * ...
	 * @author Sytze
	 */
	public class LevelOne extends MovieClip
	{
		[Embed(source = "../../../assets/bgImage.png")]
		private var bg:Class;
		
		[Embed(source = "../../../assets/bgSurface.png")]
		private var _road:Class;
		
		[Embed(source = "../../../assets/bgBuildings.png")]
		private var _building:Class;
		
		[Embed(source = "../../../assets/WarContinues_1.mp3")]
		private var _sound:Class;
		
		private var road:Bitmap;
		private var roadStart:Bitmap;
		private var building:Bitmap;
		private var buildingStart:Bitmap;
		private var sound:Sound;

		public function LevelOne() 
		{
			init();
		}
		
		private function init():void 
		{	
			sound = new _sound();
			sound.play().addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			
			road = new _road();
			roadStart = new _road();
			building = new _building();
			buildingStart = new _building();
			
			road.y = 245;
			building.y = 90;
			
			road.x = road.width;
			building.x = building.width;
			
			roadStart.y = 245;
			buildingStart.y = 90;
			
			addChild(new bg());
			addChild(building);
			addChild(road);
			
			addChild(buildingStart);
			addChild(roadStart);
			
			TweenLite.to(roadStart, (Main.instance.timer.delay / 1000), { x: -roadStart.width, ease:Linear.easeNone } );
			TweenLite.to(buildingStart, (Main.instance.timer.delay / 1000), { x:-buildingStart.width, ease:Linear.easeNone } );
			
			TweenLite.to(road, (Main.instance.timer.delay / 1000), { x:0, onComplete:tweenComplete, ease:Linear.easeNone } );
			TweenLite.to(building, (Main.instance.timer.delay / 1000), { x:0 , ease:Linear.easeNone } );
		}
		
		private function tweenComplete():void
		{
			road.x = road.width;
			building.x = building.width;
			
			buildingStart.x = 0;
			roadStart.x = 0;
						
			TweenLite.to(road, (Main.instance.timer.delay / 1000), { x:0, onComplete:tweenComplete, ease:Linear.easeNone } );
			TweenLite.to(roadStart, (Main.instance.timer.delay / 1000), { x: -roadStart.width, ease:Linear.easeNone } );
			
			TweenLite.to(building, (Main.instance.timer.delay / 1000), { x:0 , ease:Linear.easeNone } );
			TweenLite.to(buildingStart, (Main.instance.timer.delay / 1000), { x: -buildingStart.width, ease:Linear.easeNone } );
			
		}
		
		private function onSoundComplete(e:Event):void
		{
			sound.play();
		}
		
		
	}

}