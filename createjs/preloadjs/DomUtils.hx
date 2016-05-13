package createjs.preloadjs;

/**
* Convenience methods for creating various elements used by PrelaodJS.
*/
@:native("createjs.DomUtils")
extern class DomUtils
{
	/**
	* Check if item is a valid HTMLAudioElement
	* @param item 
	*/
	public static function isAudioTag(item:Dynamic):Bool;
	
	/**
	* Check if item is a valid HTMLImageElement
	* @param item 
	*/
	public static function isImageTag(item:Dynamic):Bool;
	
	/**
	* Check if item is a valid HTMLVideoElement
	* @param item 
	*/
	public static function isVideoTag(item:Dynamic):Bool;
	
}
