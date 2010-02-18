﻿package com.tankbash 
{
	import flash.display.MovieClip;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.Font;
	import flash.events.EventDispatcher;
	
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
			
			ammoType.x = Main.instance.stage.stageWidth - ammoType.width;
			ammoAmmount.x = ammoType.x - ammoAmmount.width;
			health.x = score.x + score.width;
			
			Main.instance.tank.addEventListener(AmmoEvent.AMMO_CHANGE, onAmmoChange);
			Main.instance.tank.addEventListener(AmmoEvent.AMMO_FIRED, ammoFired);
			Main.instance.tank.addEventListener(TankEvent.TANK_HIT, onTankHit);
			Main.instance.addEventListener(WallEvent.WALL_DESTROYED, onWallDestroyed);
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