package com.tankbash 
{
	import flash.display.MovieClip;
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	/**
	 * ...
	 * @author Sytze
	 */
	public class LevelOne extends MovieClip
	{
		[Embed(source = "../../../assets/smile.jpg")]
		private var bg:Class;
		
		public function LevelOne() 
		{
			init();
		}
		
		public function init():void 
		{
			addChild(new bg());
			this.x = Main.instance.stage.stageWidth;
			TweenLite.to(this, 60, { x:0 } );
		}
		
	}

}