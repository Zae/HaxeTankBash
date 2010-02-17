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
	public class ScoreInterface extends MovieClip
	{
		[Embed(source = "../../../assest/ARDARLING.ttf")]
		private var _font:Class;
		private var font:Font;
		
		private var score:TextField;
		private var ammoType:TextField;
		private var format:TextFormat;
		
		public function ScoreInterface() 
		{
			init();
		}
		
		private function init():void
		{
			font = new _font();
			
			score = new TextField();
			ammoType = new TextField();
			
			format = new TextFormat();
			format.font = font;
			format.color = white;
			format.size = 12;
			
			score.defaultTextFormat = format;
			ammoType.defaultTextFormat = format;
			
			score.text = 'Score: 0';
			ammoType.text = 'Bullets';
			
			addChild(score);
			addChild(ammoType);
			
			ammoType.x = Main.instance.stage.stageWidth - ammoType.width;
		}
		
	}

}