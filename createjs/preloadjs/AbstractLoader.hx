package createjs.preloadjs;

import js.html.Element;
import js.html.ErrorEvent;
import js.html.Event;

/**
* The base loader, which defines all the generic methods, properties, and events. All loaders extend this class,
*	including the {{#crossLink "LoadQueue"}}{{/crossLink}}.
*/
@:native("createjs.AbstractLoader")
extern class AbstractLoader extends EventDispatcher
{
	/**
	* A custom result formatter function, which is called just before a request dispatches its complete event. Most loader types already have an internal formatter, but this can be user-overridden for custom formatting. The formatted result will be available on Loaders using {{#crossLink "getResult"}}{{/crossLink}}, and passing `true`.
	*/
	public var resultFormatter:Dynamic;
	
	/**
	* A list of items that loaders load behind the scenes. This does not include the main item the loader is responsible for loading. Examples of loaders that have sub-items include the {{#crossLink "SpriteSheetLoader"}}{{/crossLink}} and {{#crossLink "ManifestLoader"}}{{/crossLink}}.
	*/
	private var _loadItems:Dynamic;
	
	/**
	* An HTML tag (or similar) that a loader may use to load HTML content, such as images, scripts, etc.
	*/
	private var _tag:Dynamic;
	
	/**
	* Defines a GET request, use for a method value when loading data.
	*/
	public static var GET:String;
	
	/**
	* Defines a POST request, use for a method value when loading data.
	*/
	public static var POST:String;
	
	/**
	* Determine if the loader was canceled. Canceled loads will not fire complete events. Note that this property is readonly, so {{#crossLink "LoadQueue"}}{{/crossLink}} queues should be closed using {{#crossLink "LoadQueue/close"}}{{/crossLink}} instead.
	*/
	public var canceled:Bool;
	
	/**
	* If the loader has completed loading. This provides a quick check, but also ensures that the different approaches used for loading do not pile up resulting in more than one `complete` {{#crossLink "Event"}}{{/crossLink}}.
	*/
	public var loaded:Bool;
	
	/**
	* The current load progress (percentage) for this item. This will be a number between 0 and 1.  <h4>Example</h4>      var queue = new createjs.LoadQueue();     queue.loadFile("largeImage.png");     queue.on("progress", function() {         console.log("Progress:", queue.progress, event.progress);     });
	*/
	public var progress:Float;
	
	/**
	* The loaded result after it is formatted by an optional {{#crossLink "resultFormatter"}}{{/crossLink}}. For items that are not formatted, this will be the same as the {{#crossLink "_rawResult:property"}}{{/crossLink}}. The result is accessed using the {{#crossLink "getResult"}}{{/crossLink}} method.
	*/
	private var _result:Dynamic;
	
	/**
	* The loaded result before it is formatted. The rawResult is accessed using the {{#crossLink "getResult"}}{{/crossLink}} method, and passing `true`.
	*/
	private var _rawResult:Dynamic;
	
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
	* The type of item this loader will load. See {{#crossLink "AbstractLoader"}}{{/crossLink}} for a full list of supported types.
	*/
	public var type:String;
	
	/**
	* The {{#crossLink "LoadItem"}}{{/crossLink}} this loader represents. Note that this is null in a {{#crossLink "LoadQueue"}}{{/crossLink}}, but will be available on loaders such as {{#crossLink "XMLLoader"}}{{/crossLink}} and {{#crossLink "ImageLoader"}}{{/crossLink}}.
	*/
	private var _item:Dynamic;
	
	/**
	* Whether the loader will try and load content using XHR (true) or HTML tags (false).
	*/
	private var _preferXHR:Bool;
	
	/**
	* Begin loading the item. This method is required when using a loader by itself.
	*	
	*	<h4>Example</h4>
	*	
	*	     var queue = new createjs.LoadQueue();
	*	     queue.on("complete", handleComplete);
	*	     queue.loadManifest(fileArray, false); // Note the 2nd argument that tells the queue not to start loading yet
	*	     queue.load();
	*/
	public function load():Dynamic;
	
	/**
	* Clean up the loader.
	*/
	public function destroy():Dynamic;
	
	/**
	* Close the the item. This will stop any open requests (although downloads using HTML tags may still continue in
	*	the background), but events will not longer be dispatched.
	*/
	public function cancel():Dynamic;
	
	/**
	* Create an internal request used for loading. By default, an {{#crossLink "XHRRequest"}}{{/crossLink}} or
	*	{{#crossLink "TagRequest"}}{{/crossLink}} is created, depending on the value of {{#crossLink "preferXHR:property"}}{{/crossLink}}.
	*	Other loaders may override this to use different request types, such as {{#crossLink "ManifestLoader"}}{{/crossLink}},
	*	which uses {{#crossLink "JSONLoader"}}{{/crossLink}} or {{#crossLink "JSONPLoader"}}{{/crossLink}} under the hood.
	*/
	private function _createRequest():Dynamic;
	
	/**
	* Create the HTML tag used for loading. This method does nothing by default, and needs to be implemented
	*	by loaders that require tag loading.
	* @param src The tag source
	*/
	private function _createTag(src:String):Element;
	
	/**
	* Determine if the load has been canceled. This is important to ensure that method calls or asynchronous events
	*	do not cause issues after the queue has been cleaned up.
	*/
	private function _isCanceled():Bool;
	
	/**
	* Dispatch a complete {{#crossLink "Event"}}{{/crossLink}}. Please see the {{#crossLink "AbstractLoader/complete:event"}}{{/crossLink}} event
	*/
	private function _sendComplete():Dynamic;
	
	/**
	* Dispatch a loadstart {{#crossLink "Event"}}{{/crossLink}}. Please see the {{#crossLink "AbstractLoader/loadstart:event"}}{{/crossLink}}
	*	event for details on the event payload.
	*/
	private function _sendLoadStart():Dynamic;
	
	/**
	* Dispatch a {{#crossLink "ProgressEvent"}}{{/crossLink}}.
	* @param value The progress of the loaded item, or an object containing <code>loaded</code>
	*	and <code>total</code> properties.
	*/
	private function _sendProgress(value:Dynamic):Dynamic;
	
	/**
	* Dispatch an error {{#crossLink "Event"}}{{/crossLink}}. Please see the {{#crossLink "AbstractLoader/error:event"}}{{/crossLink}}
	*	event for details on the event payload.
	* @param event The event object containing specific error properties.
	*/
	private function _sendError(event:ErrorEvent):Dynamic;
	
	/**
	* Get a reference to the content that was loaded by the loader (only available after the {{#crossLink "complete:event"}}{{/crossLink}}
	*	event is dispatched.
	* @param raw Determines if the returned result will be the formatted content, or the raw loaded
	*	data (if it exists).
	*/
	public function getResult(?raw:Bool):Dynamic;
	
	/**
	* Get a reference to the manifest item that is loaded by this loader. In some cases this will be the value that was
	*	passed into {{#crossLink "LoadQueue"}}{{/crossLink}} using {{#crossLink "LoadQueue/loadFile"}}{{/crossLink}} or
	*	{{#crossLink "LoadQueue/loadManifest"}}{{/crossLink}}. However if only a String path was passed in, then it will
	*	be a {{#crossLink "LoadItem"}}{{/crossLink}}.
	*/
	public function getItem():Dynamic;
	
	/**
	* Get any items loaded internally by the loader. The enables loaders such as {{#crossLink "ManifestLoader"}}{{/crossLink}}
	*	to expose items it loads internally.
	*/
	public function getLoadedItems():Array<Dynamic>;
	
	/**
	* Handle events from internal requests. By default, loaders will handle, and redispatch the necessary events, but
	*	this method can be overridden for custom behaviours.
	* @param event The event that the internal request dispatches.
	*/
	private function handleEvent(event:Event):Dynamic;
	
	/**
	* Return the `tag` this object creates or uses for loading.
	*/
	public function getTag():Dynamic;
	
	/**
	* Set the `tag` this item uses for loading.
	* @param tag The tag instance
	*/
	public function setTag(tag:Dynamic):Dynamic;
	
	/**
	* The "error" callback passed to {{#crossLink "AbstractLoader/resultFormatter"}}{{/crossLink}} asynchronous
	*	functions.
	* @param error The error event
	*/
	private function _resultFormatSuccess(error:Dynamic):Dynamic;
	
	private function buildPath():Dynamic;
	
	public function toString():String;
	
}
