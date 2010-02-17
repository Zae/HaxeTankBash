package com.tankbash 
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.Font;
	
	/**
	 * ...
	 * @author Sytze
	 */
	public class HUD extends MovieClip
	{
		[Embed(source = "../../../assets/ARDARLING.ttf", fontName = "ARDARLING", fontFamily = "FONT", mimeType = "application/x-font-truetype")]
		private var font:String;
		
		private var score:TextField;
		private var ammoType:TextField;
		private var format:TextFormat;
		
		private var scoreInt:int = 0;
		
		public function HUD() 
		{
			init();
		}
		
		private function init():void
		{
			format = new TextFormat();
			format.font = 'ARDARLING';
			format.color = 0xffffff;
			format.size = 12;
			
			score = new TextField();
			ammoType = new TextField();
			
			score.defaultTextFormat = format;
			ammoType.defaultTextFormat = format;
			
			score.text = 'Score: 0';
			ammoType.text = 'Bullets';
			
			addChild(score);
			addChild(ammoType);
			
			ammoType.x = Main.instance.stage.stageWidth - ammoType.width;
			
			Main.instance.tank.addEventListener(AmmoEvent.AMMO_CHANGE, onAmmoChange);
			Main.instance.addEventListener(WallEvent.WALL_DESTROYED, onWallDestroyed);
		}
		
		private function onAmmoChange(e:AmmoEvent):void
		{
			switch (e.ammo_type)
			{
				case Ammo.TYPE_BULLETS:
					ammoType.text = 'Bullets';
					break;
					
				case Ammo.TYPE_ROCKET:
					ammoType.text = 'Rockets';
					break;
					
				case Ammo.TYPE_CANNON:
					ammoType.text = 'Cannonballs';
					break;
			}
		}
		
		private function onWallDestroyed(e:WallEvent):void
		{
			scoreInt++;
			score.text = 'Score: ' + scoreInt;
		}
		
	}

}