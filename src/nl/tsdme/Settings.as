/*
 * Settings class voor periscoopApp
 * 
 * Leest het settings.xml uit en
 * maakt dit uitleesbaar via properties
 * van deze class, de properties werken
 * hetzelfde als E4X dus je merkt er niks
 * van. E4X FTW;
 */
package nl.tsdme{
	import adobe.utils.CustomActions;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	import nl.tsdme.*;
	import flash.events.*;
	
	/**
	 * ...
	 * @author Ezra Pool
	 */
	public class Settings extends EventDispatcher
	{
		private const settingsLocation:String = "settings.xml";
		private var XmlLoader:xmlLoader;
		
		private var _settings:XML;
		
		/*
		 * Constructor voor de class
		 */
		public function Settings()
		{
			XmlLoader = new xmlLoader(new URLRequest(this.settingsLocation));
			XmlLoader.addEventListener(Event.COMPLETE, this.LoadComplete);
		}
		/*
		 * Event voor het laden van het settings xml bestand
		 * 
		 * @param e Event Object met informatie over het event
		 * @return void
		 */
		private function LoadComplete(e:Event):void
		{
			_settings = e.currentTarget.content;
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
		/*
		 * Getter voor het meta element
		 * @return XMLList
		 */
		public function get meta():XMLList 
		{
			return this._settings.meta;
		}
		/*
		 * Getter voor het panoramas element
		 * @return XMLList
		 */
		public function get panoramas():XMLList
		{
			return this._settings.panoramas;
		}
		/*
		 * Getter voor het dirt element
		 * @return XMLList
		 */
		public function get dirt():XMLList
		{
			return this._settings.dirt;
		}
	}
}