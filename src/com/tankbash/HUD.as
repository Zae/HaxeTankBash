package com.tankbash 
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.Font;
	import flash.events.EventDispatcher;
	import com.greensock.TweenLite;
	
	/**
	 * ...
	 * @author Sytze
	 */
	public class HUD extends MovieClip
	{
		[Embed(source = "../../../assets/ARDARLING.ttf", fontName = "ARDARLING", fontFamily = "ARDARLING", mimeType = "application/x-font-truetype")]
		private var font:Class;
		
		[Embed(source = "../../../assets/instructions.png")]
		private var instructionsvisual:Class;
		
		private var score:TextField;
		private var ammoType:TextField;
		private var ammoAmmount:TextField;
		private var format:TextFormat;
		
		private var instructions:Bitmap;
		
		private var health:TextField;
		
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
			health = new TextField();
			instructions = new instructionsvisual() as Bitmap;
			
			score.defaultTextFormat = format;
			ammoType.defaultTextFormat = format;
			ammoAmmount.defaultTextFormat = format;
			health.defaultTextFormat = format;
			
			ammoAmmount.embedFonts = true;
			score.embedFonts = true;
			ammoType.embedFonts = true;
			health.embedFonts = true;
			
			score.text = 'Score: 0';
			ammoType.text = 'Bullets';
			ammoAmmount.text = Ammo.bullets_left + 'x';
			health.text = Main.instance.tank.hp + "HP";
			
			addChild(score);
			addChild(ammoType);
			addChild(ammoAmmount);
			addChild(health);
			addChild(instructions);
			
			ammoType.x = Main.instance.stage.stageWidth - ammoType.width;
			ammoAmmount.x = ammoType.x - ammoAmmount.width;
			health.x = score.x + score.width;
			
			ammoType.y = Main.instance.stage.stageHeight - 20;
			ammoAmmount.y = Main.instance.stage.stageHeight - 20;
			health.y = Main.instance.stage.stageHeight - 20;
			score.y = Main.instance.stage.stageHeight - 20;
			
			instructions.scaleX = .6;
			instructions.scaleY = .6;
			instructions.x = 20;
			instructions.y = 20;
			
			Main.instance.tank.addEventListener(AmmoEvent.AMMO_CHANGE, onAmmoChange, false, 0, true);
			Main.instance.tank.addEventListener(AmmoEvent.AMMO_FIRED, ammoFired, false, 0, true);
			Main.instance.tank.addEventListener(TankEvent.TANK_HIT, onTankHit, false, 0, true);
			Main.instance.addEventListener(WallEvent.WALL_DESTROYED, onWallDestroyed, false, 0, true);
		}
		private function onTankHit(e:TankEvent):void 
		{
			switch (e.type) 
			{
				case TankEvent.TANK_HIT:
					health.text = Main.instance.tank.hp + "HP";
					break;
			}
		}
		private function onAmmoChange(e:AmmoEvent):void
		{
			trace(e.ammo_type);
			switch (e.ammo_type)
			{
				case Ammo.TYPE_BULLETS:
					ammoType.text = 'Bullets';
					ammoAmmount.text = Ammo.bullets_left + 'x';
					break;
					
				case Ammo.TYPE_ROCKET:
					ammoType.text = 'Rockets';
					ammoAmmount.text = Ammo.rockets_left + 'x';
					break;
					
				case Ammo.TYPE_CANNON:
					ammoType.text = 'Cannonballs';
					ammoAmmount.text = Ammo.cannon_left + 'x';
					break;
			}
		}
		
		private function onWallDestroyed(e:WallEvent):void
		{
			scoreInt++;
			score.text = 'Score: ' + scoreInt;
			if (instructions)
			{
				TweenLite.to(instructions, 2, { alpha:0, onComplete: onAlphaComplete } );
			}
		}
		private function onAlphaComplete():void 
		{
			instructions = null;
		}
		private function ammoFired(e:AmmoEvent):void
		{			
			trace(ammoAmmount.text + ' bullets left');
			switch (e.ammo_type)
			{
				case Ammo.TYPE_BULLETS:
					if (Ammo.bullets_left <= 0) {
						this.dispatchEvent(new AmmoEvent(AmmoEvent.AMMO_EMPTY, null, e.ammo_type));
					}
					ammoAmmount.text = Ammo.bullets_left + 'x';
					break;
					
				case Ammo.TYPE_ROCKET:
					if (Ammo.rockets_left <= 0) {
						this.dispatchEvent(new AmmoEvent(AmmoEvent.AMMO_EMPTY, null, e.ammo_type));
					}
					ammoAmmount.text = Ammo.rockets_left + 'x';
					break;
					
				case Ammo.TYPE_CANNON:
					if (Ammo.cannon_left <= 0) {
						this.dispatchEvent(new AmmoEvent(AmmoEvent.AMMO_EMPTY, null, e.ammo_type));
					}
					ammoAmmount.text = Ammo.cannon_left + 'x';
					break;
			}
		}
	}

}