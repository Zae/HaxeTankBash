/* xmlLoader v1.1

Adapted by Ezra (ezra.pool@hva.nl);
	Added Events:
		No longer neccasary to keep polling the object to know if the
		object is done with loading the XML file.
	vb: xmlLoad.addEventListener(Event.COMPLETE, onComplete);
	
	Made it more complying with URLLoader.

Description:
	xmlLoader.as is an ActionScript 3.0 class to go with Flash 9
	it allows you to dynamicaly load XML files without the bother
	of having to type the same couple of lines of code over and
	over again.

Public variables:
	content:XML - the content of the XML file
	
Public functions:
	xmlLoader(url:URLRequest) - the constructor
	load(url:URLRequest) - load the XMl file
	reload():void - reloads the XML file
	loadComplete():Boolean - returns true/ false when loading is done or not
	getContent():XML - returns the content of the XML file
	setDebug():void - gives arbitrary output when called

Events:
	Event.ACTIVATE - Dispatched when Flash Player gains operating system focus and becomes active.
	Event.COMPLETE - Dispatched after all the received data is decoded and placed in the data property of the XMLLoader object.
	Event.DEACTIVATE - Dispatched when Flash Player loses operating system focus and is becoming inactive.
	HTTPStatusEvent.HTTP_STATUS - Dispatched if a call to XMLLoader.load() attempts to access data over HTTP and the current Flash Player environment is able to detect and return the status code for the request.
	IOErrorEvent.IO_ERROR - Dispatched if a call to XMLLoader.load() results in a fatal error that terminates the download.
	Event.OPEN - Dispatched when the download operation commences following a call to the XMLLoader.load() method.
	ProgressEvent.PROGRESS - Dispatched when data is received as the download operation progresses.
	SecurityErrorEvent.SECURITY_ERROR - Dispatched if a call to XMLLoader.load() attempts to load data from a server outside the security sandbox.
	
Author:
	Justus Sturkenboom 	<j.p.sturkenboom@hva.nl>
	Ezra Pool			<ezra.pool@hva.nl>

Copyleft 2008, all wrongs reversed.

This program is free software; you can redistribute it and/or modify it under the
terms of the GNU General Public License as published by the Free Software Foundation;
either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
*/

package nl.tsdme{
	// Import needed classes
	import flash.net.*
	import flash.events.*;
	import flash.errors.*;
	import flash.xml.*;

	public class xmlLoader extends EventDispatcher{
		//Variable declaration
		private var mainXML:XML;
		private var xmlUrl:URLRequest;
		private var loaded:Boolean;
		private var loader:URLLoader;
		private var debug:Boolean;
		
		/* constructor xmlLoader
		** Initializes some objects, assigns the passed url to the internal private variable
		** xmlUrl and calls the init function.
		** @param url:URLRequest -  An URLRequest object containing the url to the XML document you want to load
		** @param debugFlag:Boolean - To debug or not to debug (True/false)
		*/
		public function xmlLoader(url:URLRequest = null, debugFlag:Boolean = false) {
			mainXML = new XML();
			loaded = new Boolean(false);
			loader = new URLLoader();
			debug = new Boolean(debugFlag);
			
			if(url != null){
				xmlUrl = url;
				this.load(xmlUrl);
			}			
		}
		
		/* public function load:void
		** Attempts to load the XML file into it and calls the onComplete function when the
		** Event.COMPLETE event is triggered (iow: the file is loaded or fails loading)
		** @return: void
		*/
		public function load(url:URLRequest):void {
			xmlUrl = url;
			if(debug){
				trace("xmlLoader object: function load called\r");
			}
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIOErrorEvent);
			loader.addEventListener(Event.ACTIVATE, onEvent);
			loader.addEventListener(Event.DEACTIVATE, onEvent);
			loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHTTPStatusEvent);
			loader.addEventListener(Event.OPEN, onEvent);
			loader.addEventListener(ProgressEvent.PROGRESS, onProgressEvent);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityErrorEvent);
			
			loader.load(xmlUrl);
		}
		
		/* private function onSecurityErrorEvent:void
		** If an SecurityErrorEvent occurs during the loading of the XML file the error can be cought with this Event.
		** @param evt:Event - The event that is triggered, in this case any SecurityErrorEvent
		*/
		private function onSecurityErrorEvent(evt:SecurityErrorEvent):void {
			this.dispatchEvent(evt);
		}
		
		/* private function onProgressEvent:void
		** If an ProgressEvent occurs during the loading of the XML file the event can be cought with this Event.
		** @param evt:Event - The event that is triggered, in this case any ProgressEvent
		*/
		private function onProgressEvent(evt:ProgressEvent):void {
			this.dispatchEvent(evt);
		}
		
		/* private function onHTTPStatusEvent:void
		** If an HTTPSTatusEvent occurs during the loading of the XML file the event can be cought with this Event.
		** @param evt:Event - The event that is triggered, in this case any HTTPStatusEvent
		*/
		private function onHTTPStatusEvent(evt:HTTPStatusEvent):void {
			this.dispatchEvent(evt);
		}
		
		/* private function onEvent:void
		** If an event occurs during the loading of the XML file the event can be cought with this Event.
		** @param evt:Event - The event that is triggered, in this case any Event
		*/
		private function onEvent(evt:Event):void {
			this.dispatchEvent(evt);
		}
		
		/* private function onIOError:void
		** If an error occurs during the loading of the XML file the error can be cought with this Event.
		** @param evt:Event - The event that is triggered, in this case any IOErrorEvent
		*/
		private function onIOErrorEvent(evt:IOErrorEvent):void {
			this.dispatchEvent(evt);
		}
		
		/* private function onComplete:void
		** If no errors occur during the loading of the XML file the contents of this file are put in the
		** variable mainXML. If errors do occur the error message is being put into the trace output.
		** @param evt:Event - The event that is triggered, in this case an Event.COMPLETE
		*/
		private function onComplete(evt:Event):void {
			try {
				mainXML = new XML(evt.target.data);
			} catch (e:Error) {
				if(debug){
					trace("xmlLoader object: XML error during load of file:  " + xmlUrl.url + "\r\tmessage: " + e.message + "\r");
				}
				return;
			}
			loaded = true;
			this.dispatchEvent(new Event(Event.COMPLETE));
			if(debug){
				trace("xmlLoader object: XML bestand " + xmlUrl.url + " is correct ingeladen!\r");
				trace(mainXML);
			}
		}
		
		/* public function reload:void
		** Initializes the loader object, attempts to load the XML file into it and calls the onComplete
		** function when the Event.COMPLETE event is triggered (iow: the file is loaded or fails loading)
		** @return: void
		*/
		public function reload():void {
			if(debug){
				trace("xmlLoader object: function reload called, variable loaded = " + loaded + "\r");
			}
			if(loaded == true){
				loaded = false;
				loader.load(xmlUrl);
			}
		}
		
		/* public function loadComplete
		** Checks if the script is loaded completely and returns if this is the case or not.
		** @return: Boolean (true/ false)
		*/
		public function loadComplete():Boolean{
			if(debug){
				trace("xmlLoader object: function loadComplete called\r");
			}
			return loaded;
		}
		
		/* public function getContent
		** Passes the conten of the XML object to the caller
		** @return: XML (the XML object which contains the content of the loaded file)
		*/
		public function getContent():XML {
			if(debug){
				trace("xmlLoader object: function getContent called\r");
			}
			return mainXML;
		}
		
		/* public function debug
		** Sets the debug Boolean var to true which will make the class trace everything it does
		** @return: void
		*/
		public function setDebug():void {
			trace("xmlLoader object: Starting debug output:\r");
			debug = true;
		}
		
		/* public get content
		** Passes the conten of the XML object to the caller
		** @return: XML (the XML object which contains the content of the loaded file)
		*/
		public function get content():XML {
			return mainXML;
		}
	}
}