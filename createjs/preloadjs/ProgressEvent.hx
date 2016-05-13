package createjs.preloadjs;

import js.html.ProgressEvent;

/**
* A CreateJS {{#crossLink "Event"}}{{/crossLink}} that is dispatched when progress changes.
*/
@:native("createjs.ProgressEvent")
extern class ProgressEvent
{
	/**
	* Defines a GET request, use for a method value when loading data.
	*/
	public static var GET:String;
	
	/**
	* Defines a POST request, use for a method value when loading data.
	*/
	public static var POST:String;
	
	/**
	* The amount that has been loaded (out of a total amount)
	*/
	public var loaded:Float;
	
	/**
	* The percentage (out of 1) that the load has been completed. This is calculated using `loaded/total`.
	*/
	public var progress:Float;
	
	/**
	* The preload type for css files. CSS files are loaded using a &lt;link&gt; when loaded with XHR, or a &lt;style&gt; tag when loaded with tags.
	*/
	public static var CSS:String;
	
	/**
	* The preload type for generic binary types. Note that images are loaded as binary files when using XHR.
	*/
	public static var BINARY:String;
	
	/**
	* The preload type for image files, usually png, gif, or jpg/jpeg. Images are loaded into an &lt;image&gt; tag.
	*/
	public static var IMAGE:String;
	
	/**
	* The preload type for javascript files, usually with the "js" file extension. JavaScript files are loaded into a &lt;script&gt; tag.  Since version 0.4.1+, due to how tag-loaded scripts work, all JavaScript files are automatically injected into the body of the document to maintain parity between XHR and tag-loaded scripts. In version 0.4.0 and earlier, only tag-loaded scripts are injected.
	*/
	public static var JAVASCRIPT:String;
	
	/**
	* The preload type for json files, usually with the "json" file extension. JSON data is loaded and parsed into a JavaScript object. Note that if a `callback` is present on the load item, the file will be loaded with JSONP, no matter what the {{#crossLink "LoadQueue/preferXHR:property"}}{{/crossLink}} property is set to, and the JSON must contain a matching wrapper function.
	*/
	public static var JSON:String;
	
	/**
	* The preload type for json-based manifest files, usually with the "json" file extension. The JSON data is loaded and parsed into a JavaScript object. PreloadJS will then look for a "manifest" property in the JSON, which is an Array of files to load, following the same format as the {{#crossLink "LoadQueue/loadManifest"}}{{/crossLink}} method. If a "callback" is specified on the manifest object, then it will be loaded using JSONP instead, regardless of what the {{#crossLink "LoadQueue/preferXHR:property"}}{{/crossLink}} property is set to.
	*/
	public static var MANIFEST:String;
	
	/**
	* The preload type for jsonp files, usually with the "json" file extension. JSON data is loaded and parsed into a JavaScript object. You are required to pass a callback parameter that matches the function wrapper in the JSON. Note that JSONP will always be used if there is a callback present, no matter what the {{#crossLink "LoadQueue/preferXHR:property"}}{{/crossLink}} property is set to.
	*/
	public static var JSONP:String;
	
	/**
	* The preload type for sound files, usually mp3, ogg, or wav. When loading via tags, audio is loaded into an &lt;audio&gt; tag.
	*/
	public static var SOUND:String;
	
	/**
	* The preload type for SpriteSheet files. SpriteSheet files are JSON files that contain string image paths.
	*/
	public static var SPRITESHEET:String;
	
	/**
	* The preload type for SVG files.
	*/
	public static var SVG:String;
	
	/**
	* The preload type for text files, which is also the default file type if the type can not be determined. Text is loaded as raw text.
	*/
	public static var TEXT:String;
	
	/**
	* The preload type for video files, usually mp4, ts, or ogg. When loading via tags, video is loaded into an &lt;video&gt; tag.
	*/
	public static var VIDEO:String;
	
	/**
	* The preload type for xml files. XML is loaded into an XML document.
	*/
	public static var XML:String;
	
	/**
	* The total "size" of the load.
	*/
	public var total:Float;
	
	/**
	* A CreateJS {{#crossLink "Event"}}{{/crossLink}} that is dispatched when progress changes.
	* @param loaded The amount that has been loaded. This can be any number relative to the total.
	* @param total The total amount that will load. This will default to 1, so if the `loaded` value is
	*	a percentage (between 0 and 1), it can be omitted.
	*/
	public function new(loaded:Float, ?total:Float):Void;
	
	/**
	* Returns a clone of the ProgressEvent instance.
	*/
	public function clone():ProgressEvent;
	
}
