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
		[Embed(source = "../../../assets/ARDARLING.ttf", fontName = "ARDARLING", fontFamily = "ARDARLING", mimeType = "application/x-font-truetype")]
		private var font:Class;
		
		private var score:TextField;
		private var ammoType:TextField;
		private var ammoAmmount:TextField;
		private var format:TextFormat;
		
		private var bullets:int = 25;
		private var rockets:int = 5;
		private var cannons:int = 10;
		
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
			format.size = 16;
			
			score = new TextField();
			ammoType = new TextField();
			ammoAmmount = new TextField();
			
			score.defaultTextFormat = format;
			ammoType.defaultTextFormat = format;
			ammoAmmount.defaultTextFormat = format;
			
			ammoAmmount.embedFonts = true;
			score.embedFonts = true;
			ammoType.embedFonts = true;
			
			score.text = 'Score: 0';
			ammoType.text = 'Bullets';
			ammoAmmount.text = bullets + 'x';
			ammoAmmount.x = ammoType.x - ammoAmmount.width;
			
			addChild(score);
			addChild(ammoType);
			addChild(ammoAmmount);
			
			ammoType.x = Main.instance.stage.stageWidth - ammoType.width;
			
			Main.instance.tank.addEventListener(AmmoEvent.AMMO_CHANGE, onAmmoChange);
			Main.instance.tank.addEventListener(AmmoEvent.AMMO_FIRED, ammoFired);
			Main.instance.addEventListener(WallEvent.WALL_DESTROYED, onWallDestroyed);
		}
		
		private function onAmmoChange(e:AmmoEvent):void
		{
			trace(e.ammo_type);
			switch (e.ammo_type)
			{
				case Ammo.TYPE_BULLETS:
					ammoType.text = 'Bullets';
					ammoAmmount.text = bullets + 'x';
					break;
					
				case Ammo.TYPE_ROCKET:
					ammoType.text = 'Rockets';
					ammoAmmount.text = rockets + 'x';
					break;
					
				case Ammo.TYPE_CANNON:
					ammoType.text = 'Cannonballs';
					ammoAmmount.text = cannons + 'x';
					break;
			}
		}
		
		private function onWallDestroyed(e:WallEvent):void
		{
			scoreInt++;
			score.text = 'Score: ' + scoreInt;
		}
		
		private function ammoFired(e:AmmoEvent):void
		{
			switch (e.ammo_type)
			{
				case Ammo.TYPE_BULLETS:
					bullets--;
					ammoAmmount.text = bullets + 'x';
					break;
					
				case Ammo.TYPE_ROCKET:
					rockets--;
					ammoAmmount.text = rockets + 'x';
					break;
					
				case Ammo.TYPE_CANNON:
					cannons--;
					ammoAmmount.text = cannons + 'x';
					break;
			}
		}
		
	}

}