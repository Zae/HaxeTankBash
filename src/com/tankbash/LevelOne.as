package com.tankbash 
{
	import flash.display.MovieClip;
	import flash.display.Bitmap;
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
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
		
		[Embed(source = "../../../assets/gameover.png")]
		private var _gameoverImg:Class;
		
		[Embed(source = "../../../assets/gameover.mp3")]
		private var _gameoverSound:Class;
		
		[Embed(source = "../../../assets/WarContinues_1.mp3")]
		private var _sound:Class;
		
		private var road:Bitmap;
		private var roadStart:Bitmap;
		private var building:Bitmap;
		private var buildingStart:Bitmap;
		private var gameoverImg:Bitmap;
		private var gameoverSound:Sound;
		private var sound:Sound;
		private var soundChannel:SoundChannel;
		private var soundTransformm:SoundTransform;

		public function LevelOne() 
		{
			init();
		}
		
		private function init():void 
		{	
			sound = new _sound();
			soundChannel = new SoundChannel();
			soundChannel = sound.play();
			soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			soundTransformm = new SoundTransform;
			soundTransformm.volume = 0.5;
			
			gameoverSound = new _gameoverSound();
			
			Main.instance.tank.addEventListener(TankEvent.TANK_DESTROYED, onTankDestroyed, false, 0, true);
			
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
			
			gameoverImg = new _gameoverImg();
			addChild(gameoverImg);
			gameoverImg.x = Main.instance.stage.stageWidth / 2 - gameoverImg.width / 2;
			gameoverImg.y = Main.instance.stage.stageHeight / 2 - gameoverImg.height / 2;
			gameoverImg.visible = false;
			
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
		
		private function onTankDestroyed(e:TankEvent):void
		{
			soundChannel.soundTransform = soundTransformm;
			gameoverImg.visible = true;
			gameoverSound.play();
		}		
	}

}