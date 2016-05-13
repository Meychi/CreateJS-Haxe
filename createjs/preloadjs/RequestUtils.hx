package createjs.preloadjs;

/**
* Utilities that assist with parsing load items, and determining file types, etc.
*/
@:native("createjs.RequestUtils")
extern class RequestUtils
{
	/**
	* The Regular Expression used to test file URLS for a relative path.
	*/
	public static var RELATIVE_PATH:EReg;
	
	/**
	* The Regular Expression used to test file URLS for an absolute path.
	*/
	public static var ABSOLUTE_PATH:EReg;
	
	/**
	* The Regular Expression used to test file URLS for an extension. Note that URIs must already have the query string removed.
	*/
	public static var EXTENSION_PATT:EReg;
	
	/**
	* A utility method that builds a file path using a source and a data object, and formats it into a new path.
	* @param src The source path to add values to.
	* @param data Object used to append values to this request as a query string. Existing parameters on the
	*	path will be preserved.
	*/
	public static function buildURI(src:String, ?data:Dynamic):String;
	
	/**
	* Determine if a specific type is a text-based asset, and should be loaded as UTF-8.
	* @param type The item type.
	*/
	public static function isText(type:String):Bool;
	
	/**
	* Determine if a specific type should be loaded as a binary file. Currently, only images and items marked
	*	specifically as "binary" are loaded as binary. Note that audio is <b>not</b> a binary type, as we can not play
	*	back using an audio tag if it is loaded as binary. Plugins can change the item type to binary to ensure they get
	*	a binary result to work with. Binary files are loaded using XHR2. Types are defined as static constants on
	*	{{#crossLink "AbstractLoader"}}{{/crossLink}}.
	* @param type The item type.
	*/
	public static function isBinary(type:String):Bool;
	
	/**
	* Determine the type of the object using common extensions. Note that the type can be passed in with the load item
	*	if it is an unusual extension.
	* @param extension The file extension to use to determine the load type.
	*/
	public static function getTypeByExtension(extension:String):String;
	
	/**
	* Formats an object into a query string for either a POST or GET request.
	* @param data The data to convert to a query string.
	* @param query Existing name/value pairs to append on to this query.
	*/
	public static function formatQueryString(data:Dynamic, ?query:Array<Dynamic>):Dynamic;
	
	/**
	* Parse a file path to determine the information we need to work with it. Currently, PreloadJS needs to know:
	*	<ul>
	*	    <li>If the path is absolute. Absolute paths start with a protocol (such as `http://`, `file://`, or
	*	    `//networkPath`)</li>
	*	    <li>If the path is relative. Relative paths start with `../` or `/path` (or similar)</li>
	*	    <li>The file extension. This is determined by the filename with an extension. Query strings are dropped, and
	*	    the file path is expected to follow the format `name.ext`.</li>
	*	</ul>
	* @param path 
	*/
	public static function parseURI(path:String):Dynamic;
	
	public static function isCrossDomain(item:Dynamic):Bool;
	
	public static function isLocal(item:Dynamic):Bool;
	
}
