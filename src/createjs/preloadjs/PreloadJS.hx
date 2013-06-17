package createjs.preloadjs;

/**
* Static class holding library specific information such as the version and buildDate of
*	the library.
*	
*	The old PreloadJS class has been renamed to LoadQueue. Please see the {{#crossLink "LoadQueue"}}{{/crossLink}}
*	class for information on loading files.
*/
@:native("createjs.PreloadJS")
extern class PreloadJS
{	
	/**
	* The build date for this release in UTC format.
	*/
	public static var buildDate:String;
	
	/**
	* The version string for this release.
	*/
	public static var version:String;
}
