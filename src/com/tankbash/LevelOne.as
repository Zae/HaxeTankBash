package com.tankbash 
{
	import flash.display.MovieClip;
	import flash.display.Bitmap;
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
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
		
		private var road:Bitmap;
		private var roadStart:Bitmap;
		private var building:Bitmap;
		private var buildingStart:Bitmap;
		
		public function LevelOne() 
		{
			init();
		}
		
		private function init():void 
		{			
			road = new _road();
			roadStart = new _road();
			building = new _building();
			buildingStart = new _building();
			
			road.y = 166;
			building.y = 80;
			
			road.x = road.width;
			building.x = building.width;
			
			roadStart.y = 166;
			buildingStart.y = 80;
			
			addChild(new bg());
			addChild(building);
			addChild(road);
			
			addChild(buildingStart);
			addChild(roadStart);
			
			TweenLite.to(roadStart, 10, { x: -roadStart.width, ease:Linear.easeNone } );
			TweenLite.to(buildingStart, 15, { x:-buildingStart.width, ease:Linear.easeNone } );
			
			TweenLite.to(road, 10, { x:0, onComplete:roadComplete, ease:Linear.easeNone } );
			TweenLite.to(building, 15, { x:0, onComplete:buildingComplete,ease:Linear.easeNone } );
		}
		
		private function roadComplete():void
		{
			road.x = road.width;
			roadStart.x = 0;
			TweenLite.to(road, 10, { x:0, onComplete:roadComplete, ease:Linear.easeNone } );
			TweenLite.to(roadStart, 10, { x: -roadStart.width, ease:Linear.easeNone } );
			
		}
		
		private function buildingComplete():void
		{
			building.x = building.width;
			buildingStart.x = 0;
			TweenLite.to(buildingStart, 15, { x: -buildingStart.width, ease:Linear.easeNone } );
			TweenLite.to(building, 15, { x:0, onComplete:buildingComplete,ease:Linear.easeNone } );
		}
		
	}

}