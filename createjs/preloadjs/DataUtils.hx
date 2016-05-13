package createjs.preloadjs;

/**
* A few data utilities for formatting different data types.
*/
@:native("createjs.DataUtils")
extern class DataUtils
{
	/**
	* Parse a string into an Object.
	* @param value The loaded JSON string
	*/
	public function parseJSON(value:String):Dynamic;
	
	/**
	* Parse XML using the DOM. This is required when preloading XML or SVG.
	* @param text The raw text or XML that is loaded by XHR.
	*/
	public static function parseXML(text:String):XML;
	
}
