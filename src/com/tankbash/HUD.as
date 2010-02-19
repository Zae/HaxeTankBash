package com.tankbash 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
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
		
		[Embed(source = "../../../assets/bullet_icon.png")]
		private var bullet_icon:Class;
		
		[Embed(source = "../../../assets/cannon_icon.png")]
		private var cannon_icon:Class;
		
		[Embed(source = "../../../assets/rocket_icon.png")]
		private var rocket_icon:Class;
		
		[Embed(source = "../../../assets/health_icon.png")]
		private var health_icon:Class;
		
		private var score:TextField;
		private var ammoType:TextField;
		private var ammoAmmount:TextField;
		private var format:TextFormat;
		
		private var health:TextField;
		
		private var scoreInt:int = 0;
		
		private var bullet_IconVisual:Bitmap;
		private var rocket_IconVisual:Bitmap;
		private var cannon_IconVisual:Bitmap;
		private var health_IconVisual:Bitmap;
		
		public function HUD() 
		{
			init();
		}
		
		private function init():void
		{	
			bullet_IconVisual = new bullet_icon();
			rocket_IconVisual = new rocket_icon();
			cannon_IconVisual = new cannon_icon();
			health_IconVisual = new health_icon();
			
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
			//addChild(ammoType);
			addChild(ammoAmmount);
			addChild(health);
			addChild(bullet_IconVisual);
			addChild(health_IconVisual);			
			
			bullet_IconVisual.scaleX = .1;
			bullet_IconVisual.scaleY = .1;
			rocket_IconVisual.scaleX = .1;
			rocket_IconVisual.scaleY = .1;
			cannon_IconVisual.scaleX = .1;
			cannon_IconVisual.scaleY = .1;
			health_IconVisual.scaleX = .1;
			health_IconVisual.scaleY = .1;
			
			score.x = Main.instance.stage.stageWidth - score.width;
			
			bullet_IconVisual.x = 10;
			rocket_IconVisual.x = 10;
			cannon_IconVisual.x = 10;
			health_IconVisual.x = 10;
			
			ammoAmmount.x = 10;
			health.x = 10;
			score.x = 10;
			
			bullet_IconVisual.y = Main.instance.stage.stageHeight - 140 - bullet_IconVisual.height;
			rocket_IconVisual.y = Main.instance.stage.stageHeight - 140 - rocket_IconVisual.height;
			cannon_IconVisual.y = Main.instance.stage.stageHeight - 140 - cannon_IconVisual.height;
			health_IconVisual.y = Main.instance.stage.stageHeight - 30 - health_IconVisual.height;
			
			ammoAmmount.y = Main.instance.stage.stageHeight - 140;
			health.y = Main.instance.stage.stageHeight - 30;
			score.y = Main.instance.stage.stageHeight - 250;
			
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
					
					try { removeChild(cannon_IconVisual) } catch (err:Error){}
					try { removeChild(rocket_IconVisual) } catch (err:Error){}
					addChild(bullet_IconVisual);
					
					break;
					
				case Ammo.TYPE_ROCKET:
					ammoType.text = 'Rockets';
					ammoAmmount.text = Ammo.rockets_left + 'x';
					
					try { removeChild(cannon_IconVisual) } catch (err:Error){}
					try { removeChild(bullet_IconVisual) } catch (err:Error){}
					addChild(rocket_IconVisual);
					
					break;
					
				case Ammo.TYPE_CANNON:
					ammoType.text = 'Cannonballs';
					ammoAmmount.text = Ammo.cannon_left + 'x';
					
					try { removeChild(bullet_IconVisual) } catch (err:Error){}
					try { removeChild(rocket_IconVisual) } catch (err:Error){}
					addChild(cannon_IconVisual);
					
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