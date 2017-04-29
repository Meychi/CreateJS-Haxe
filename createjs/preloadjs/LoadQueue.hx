package createjs.preloadjs;

import js.html.ErrorEvent;
import js.html.Event;
import js.html.ProgressEvent;

/**
* The LoadQueue class is the main API for preloading content. LoadQueue is a load manager, which can preload either
*	a single file, or queue of files.
*	
*	<b>Creating a Queue</b><br />
*	To use LoadQueue, create a LoadQueue instance. If you want to force tag loading where possible, set the preferXHR
*	argument to false.
*	
*	     var queue = new createjs.LoadQueue(true);
*	
*	<b>Listening for Events</b><br />
*	Add any listeners you want to the queue. Since PreloadJS 0.3.0, the {{#crossLink "EventDispatcher"}}{{/crossLink}}
*	lets you add as many listeners as you want for events. You can subscribe to the following events:<ul>
*	    <li>{{#crossLink "AbstractLoader/complete:event"}}{{/crossLink}}: fired when a queue completes loading all
*	    files</li>
*	    <li>{{#crossLink "AbstractLoader/error:event"}}{{/crossLink}}: fired when the queue encounters an error with
*	    any file.</li>
*	    <li>{{#crossLink "AbstractLoader/progress:event"}}{{/crossLink}}: Progress for the entire queue has
*	    changed.</li>
*	    <li>{{#crossLink "LoadQueue/fileload:event"}}{{/crossLink}}: A single file has completed loading.</li>
*	    <li>{{#crossLink "LoadQueue/fileprogress:event"}}{{/crossLink}}: Progress for a single file has changes. Note
*	    that only files loaded with XHR (or possibly by plugins) will fire progress events other than 0 or 100%.</li>
*	</ul>
*	
*	     queue.on("fileload", handleFileLoad, this);
*	     queue.on("complete", handleComplete, this);
*	
*	<b>Adding files and manifests</b><br />
*	Add files you want to load using {{#crossLink "LoadQueue/loadFile"}}{{/crossLink}} or add multiple files at a
*	time using a list or a manifest definition using {{#crossLink "LoadQueue/loadManifest"}}{{/crossLink}}. Files are
*	appended to the end of the active queue, so you can use these methods as many times as you like, whenever you
*	like.
*	
*	     queue.loadFile("filePath/file.jpg");
*	     queue.loadFile({id:"image", src:"filePath/file.jpg"});
*	     queue.loadManifest(["filePath/file.jpg", {id:"image", src:"filePath/file.jpg"}]);
*	
*	     // Use an external manifest
*	     queue.loadManifest("path/to/manifest.json");
*	     queue.loadManifest({src:"manifest.json", type:"manifest"});
*	
*	If you pass `false` as the `loadNow` parameter, the queue will not kick of the load of the files, but it will not
*	stop if it has already been started. Call the {{#crossLink "AbstractLoader/load"}}{{/crossLink}} method to begin
*	a paused queue. Note that a paused queue will automatically resume when new files are added to it with a
*	`loadNow` argument of `true`.
*	
*	     queue.load();
*	
*	<b>File Types</b><br />
*	The file type of a manifest item is auto-determined by the file extension. The pattern matching in PreloadJS
*	should handle the majority of standard file and url formats, and works with common file extensions. If you have
*	either a non-standard file extension, or are serving the file using a proxy script, then you can pass in a
*	<code>type</code> property with any manifest item.
*	
*	     queue.loadFile({src:"path/to/myFile.mp3x", type:createjs.AbstractLoader.SOUND});
*	
*	     // Note that PreloadJS will not read a file extension from the query string
*	     queue.loadFile({src:"http://server.com/proxy?file=image.jpg", type:createjs.AbstractLoader.IMAGE});
*	
*	Supported types are defined on the {{#crossLink "AbstractLoader"}}{{/crossLink}} class, and include:
*	<ul>
*	    <li>{{#crossLink "AbstractLoader/BINARY:property"}}{{/crossLink}}: Raw binary data via XHR</li>
*	    <li>{{#crossLink "AbstractLoader/CSS:property"}}{{/crossLink}}: CSS files</li>
*	    <li>{{#crossLink "AbstractLoader/IMAGE:property"}}{{/crossLink}}: Common image formats</li>
*	    <li>{{#crossLink "AbstractLoader/JAVASCRIPT:property"}}{{/crossLink}}: JavaScript files</li>
*	    <li>{{#crossLink "AbstractLoader/JSON:property"}}{{/crossLink}}: JSON data</li>
*	    <li>{{#crossLink "AbstractLoader/JSONP:property"}}{{/crossLink}}: JSON files cross-domain</li>
*	    <li>{{#crossLink "AbstractLoader/MANIFEST:property"}}{{/crossLink}}: A list of files to load in JSON format, see
*	    {{#crossLink "AbstractLoader/loadManifest"}}{{/crossLink}}</li>
*	    <li>{{#crossLink "AbstractLoader/SOUND:property"}}{{/crossLink}}: Audio file formats</li>
*	    <li>{{#crossLink "AbstractLoader/SPRITESHEET:property"}}{{/crossLink}}: JSON SpriteSheet definitions. This
*	    will also load sub-images, and provide a {{#crossLink "SpriteSheet"}}{{/crossLink}} instance.</li>
*	    <li>{{#crossLink "AbstractLoader/SVG:property"}}{{/crossLink}}: SVG files</li>
*	    <li>{{#crossLink "AbstractLoader/TEXT:property"}}{{/crossLink}}: Text files - XHR only</li>
*	    <li>{{#crossLink "AbstractLoader/VIDEO:property"}}{{/crossLink}}: Video objects</li>
*	    <li>{{#crossLink "AbstractLoader/XML:property"}}{{/crossLink}}: XML data</li>
*	</ul>
*	
*	<em>Note: Loader types used to be defined on LoadQueue, but have been moved to AbstractLoader for better
*	portability of loader classes, which can be used individually now. The properties on LoadQueue still exist, but
*	are deprecated.</em>
*	
*	<b>Handling Results</b><br />
*	When a file is finished downloading, a {{#crossLink "LoadQueue/fileload:event"}}{{/crossLink}} event is
*	dispatched. In an example above, there is an event listener snippet for fileload. Loaded files are usually a
*	formatted object that can be used immediately, including:
*	<ul>
*	    <li>Binary: The binary loaded result</li>
*	    <li>CSS: A &lt;link /&gt; tag</li>
*	    <li>Image: An &lt;img /&gt; tag</li>
*	    <li>JavaScript: A &lt;script /&gt; tag</li>
*	    <li>JSON/JSONP: A formatted JavaScript Object</li>
*	    <li>Manifest: A JavaScript object.
*	    <li>Sound: An &lt;audio /&gt; tag</a>
*	    <li>SpriteSheet: A {{#crossLink "SpriteSheet"}}{{/crossLink}} instance, containing loaded images.
*	    <li>SVG: An &lt;object /&gt; tag</li>
*	    <li>Text: Raw text</li>
*	    <li>Video: A Video DOM node</li>
*	    <li>XML: An XML DOM node</li>
*	</ul>
*	
*	     function handleFileLoad(event) {
*	         var item = event.item; // A reference to the item that was passed in to the LoadQueue
*	         var type = item.type;
*	
*	         // Add any images to the page body.
*	         if (type == createjs.LoadQueue.IMAGE) {
*	             document.body.appendChild(event.result);
*	         }
*	     }
*	
*	At any time after the file has been loaded (usually after the queue has completed), any result can be looked up
*	via its "id" using {{#crossLink "LoadQueue/getResult"}}{{/crossLink}}. If no id was provided, then the
*	"src" or file path can be used instead, including the `path` defined by a manifest, but <strong>not including</strong>
*	a base path defined on the LoadQueue. It is recommended to always pass an id if you want to look up content.
*	
*	     var image = queue.getResult("image");
*	     document.body.appendChild(image);
*	
*	Raw loaded content can be accessed using the <code>rawResult</code> property of the {{#crossLink "LoadQueue/fileload:event"}}{{/crossLink}}
*	event, or can be looked up using {{#crossLink "LoadQueue/getResult"}}{{/crossLink}}, passing `true` as the 2nd
*	argument. This is only applicable for content that has been parsed for the browser, specifically: JavaScript,
*	CSS, XML, SVG, and JSON objects, or anything loaded with XHR.
*	
*	     var image = queue.getResult("image", true); // load the binary image data loaded with XHR.
*	
*	<b>Plugins</b><br />
*	LoadQueue has a simple plugin architecture to help process and preload content. For example, to preload audio,
*	make sure to install the <a href="http://soundjs.com">SoundJS</a> Sound class, which will help load HTML audio,
*	Flash audio, and WebAudio files. This should be installed <strong>before</strong> loading any audio files.
*	
*	     queue.installPlugin(createjs.Sound);
*	
*	<h4>Known Browser Issues</h4>
*	<ul>
*	    <li>Browsers without audio support can not load audio files.</li>
*	    <li>Safari on Mac OS X can only play HTML audio if QuickTime is installed</li>
*	    <li>HTML Audio tags will only download until their <code>canPlayThrough</code> event is fired. Browsers other
*	    than Chrome will continue to download in the background.</li>
*	    <li>When loading scripts using tags, they are automatically added to the document.</li>
*	    <li>Scripts loaded via XHR may not be properly inspectable with browser tools.</li>
*	    <li>IE6 and IE7 (and some other browsers) may not be able to load XML, Text, or JSON, since they require
*	    XHR to work.</li>
*	    <li>Content loaded via tags will not show progress, and will continue to download in the background when
*	    canceled, although no events will be dispatched.</li>
*	</ul>
*/
@:native("createjs.LoadQueue")
extern class LoadQueue extends AbstractLoader
{
	/**
	* A list of scripts in the order they were requested. This helps ensure that scripts are "completed" in the right order.
	*/
	private var _scriptOrder:Array<Dynamic>;
	
	/**
	* A list of scripts that have been loaded. Items are added to this list as <code>null</code> when they are requested, contain the loaded item if it has completed, but not been dispatched to the user, and <code>true</true> once they are complete and have been dispatched.
	*/
	private var _loadedScripts:Array<Dynamic>;
	
	/**
	* A path that will be prepended on to the item's {{#crossLink "LoadItem/src:property"}}{{/crossLink}}. The `_basePath` property will only be used if an item's source is relative, and does not include a protocol such as `http://`, or a relative path such as `../`.
	*/
	private var _basePath:String;
	
	/**
	* An array containing downloads that have not completed, so that the LoadQueue can be properly reset.
	*/
	private var _loadQueueBackup:Array<Dynamic>;
	
	/**
	* An array containing the currently downloading files.
	*/
	private var _currentLoads:Array<Dynamic>;
	
	/**
	* An array containing the queued items that have not yet started downloading.
	*/
	private var _loadQueue:Array<Dynamic>;
	
	/**
	* An array of the plugins registered using {{#crossLink "LoadQueue/installPlugin"}}{{/crossLink}}.
	*/
	private var _plugins:Array<Dynamic>;
	
	/**
	* An internal list of all the default Loaders that are included with PreloadJS. Before an item is loaded, the available loader list is iterated, in the order they are included, and as soon as a loader indicates it can handle the content, it will be selected. The default loader, ({{#crossLink "TextLoader"}}{{/crossLink}} is last in the list, so it will be used if no other match is found. Typically, loaders will match based on the {{#crossLink "LoadItem/type"}}{{/crossLink}}, which is automatically determined using the file extension of the {{#crossLink "LoadItem/src:property"}}{{/crossLink}}.  Loaders can be removed from PreloadJS by simply not including them.  Custom loaders installed using {{#crossLink "registerLoader"}}{{/crossLink}} will be prepended to this list so that they are checked first.
	*/
	private var _availableLoaders:Array<Dynamic>;
	
	/**
	* An object hash of callbacks that are fired for each file extension before the file is loaded, giving plugins the ability to override properties of the load. Please see the {{#crossLink "LoadQueue/installPlugin"}}{{/crossLink}} method for more information.
	*/
	private var _extensionCallbacks:Dynamic;
	
	/**
	* An object hash of callbacks that are fired for each file type before the file is loaded, giving plugins the ability to override properties of the load. Please see the {{#crossLink "LoadQueue/installPlugin"}}{{/crossLink}} method for more information.
	*/
	private var _typeCallbacks:Dynamic;
	
	/**
	* An object hash of items that have finished downloading, indexed by the {{#crossLink "LoadItem"}}{{/crossLink}} id.
	*/
	private var _loadItemsById:Dynamic;
	
	/**
	* An object hash of items that have finished downloading, indexed by {{#crossLink "LoadItem"}}{{/crossLink}} source.
	*/
	private var _loadItemsBySrc:Dynamic;
	
	/**
	* An object hash of loaded items, indexed by the ID of the {{#crossLink "LoadItem"}}{{/crossLink}}.
	*/
	private var _loadedResults:Dynamic;
	
	/**
	* An object hash of un-parsed loaded items, indexed by the ID of the {{#crossLink "LoadItem"}}{{/crossLink}}.
	*/
	private var _loadedRawResults:Dynamic;
	
	/**
	* An optional flag to set on images that are loaded using PreloadJS, which enables CORS support. Images loaded cross-domain by servers that support CORS require the crossOrigin flag to be loaded and interacted with by a canvas. When loading locally, or with a server with no CORS support, this flag can cause other security issues, so it is recommended to only set it if you are sure the server supports it. Currently, supported values are "" and "Anonymous".
	*/
	private var _crossOrigin:String;
	
	/**
	* Determines if the LoadQueue will stop processing the current queue when an error is encountered.
	*/
	public var stopOnError:Bool;
	
	/**
	* Determines if the loadStart event was dispatched already. This event is only fired one time, when the first file is requested.
	*/
	private var _loadStartWasDispatched:Bool;
	
	/**
	* Determines if there is currently a script loading. This helps ensure that only a single script loads at once when using a script tag to do preloading.
	*/
	private var _currentlyLoadingScript:Bool;
	
	/**
	* Ensure loaded scripts "complete" in the order they are specified. Loaded scripts are added to the document head once they are loaded. Scripts loaded via tags will load one-at-a-time when this property is `true`, whereas scripts loaded using XHR can load in any order, but will "finish" and be added to the document in the order specified.  Any items can be set to load in order by setting the {{#crossLink "maintainOrder:property"}}{{/crossLink}} property on the load item, or by ensuring that only one connection can be open at a time using {{#crossLink "LoadQueue/setMaxConnections"}}{{/crossLink}}. Note that when the `maintainScriptOrder` property is set to `true`, scripts items are automatically set to `maintainOrder=true`, and changing the `maintainScriptOrder` to `false` during a load will not change items already in a queue.  <h4>Example</h4>       var queue = new createjs.LoadQueue();      queue.setMaxConnections(3); // Set a higher number to load multiple items at once      queue.maintainScriptOrder = true; // Ensure scripts are loaded in order      queue.loadManifest([          "script1.js",          "script2.js",          "image.png", // Load any time          {src: "image2.png", maintainOrder: true} // Will wait for script2.js          "image3.png",          "script3.js" // Will wait for image2.png before loading (or completing when loading with XHR)      ]);
	*/
	public var maintainScriptOrder:Bool;
	
	/**
	* The last progress amount. This is used to suppress duplicate progress events.
	*/
	private var _lastProgress:Float;
	
	/**
	* The next preload queue to process when this one is complete. If an error is thrown in the current queue, and {{#crossLink "LoadQueue/stopOnError:property"}}{{/crossLink}} is `true`, the next queue will not be processed.
	*/
	public var next:LoadQueue;
	
	/**
	* The number of built in loaders, so they can't be removed by {{#crossLink "unregisterLoader"}}{{/crossLink}.
	*/
	private var _defaultLoaderLength:Float;
	
	/**
	* The number of items that have been requested. This helps manage an overall progress without knowing how large the files are before they are downloaded. This does not include items inside of loaders such as the {{#crossLink "ManifestLoader"}}{{/crossLink}}.
	*/
	private var _numItems:Float;
	
	/**
	* The number of items that have completed loaded. This helps manage an overall progress without knowing how large the files are before they are downloaded.
	*/
	private var _numItemsLoaded:Float;
	
	/**
	* The number of maximum open connections that a loadQueue tries to maintain. Please see {{#crossLink "LoadQueue/setMaxConnections"}}{{/crossLink}} for more information.
	*/
	private var _maxConnections:Float;
	
	/**
	* The time in milliseconds to assume a load has failed.
	*/
	public var LOAD_TIMEOUT:Float;
	
	/**
	* The time in milliseconds to assume a load has failed. An {{#crossLink "AbstractLoader/error:event"}}{{/crossLink}} event is dispatched if the timeout is reached before any data is received.
	*/
	public static var loadTimeout:Float;
	
	/**
	* Whether the queue is currently paused or not.
	*/
	private var _paused:Bool;
	
	public static var BINARY:String;
	
	public static var CSS:String;
	
	public static var IMAGE:String;
	
	public static var JAVASCRIPT:String;
	
	public static var JSON:String;
	
	public static var JSONP:String;
	
	public static var MANIFEST:String;
	
	public static var SOUND:String;
	
	public static var SVG:String;
	
	public static var TEXT:String;
	
	public static var VIDEO:String;
	
	public static var XML:String;
	
	public var GET:String;
	
	public var POST:String;
	
	public var useXHR:Bool;
	
	/**
	* <strong>REMOVED</strong>. Removed in favor of using `MySuperClass_constructor`.
	*	See {{#crossLink "Utility Methods/extend"}}{{/crossLink}} and {{#crossLink "Utility Methods/promote"}}{{/crossLink}}
	*	for details.
	*	
	*	There is an inheritance tutorial distributed with EaselJS in /tutorials/Inheritance.
	*/
	private function initialize():Dynamic;
	
	/**
	* A file has completed loading, and the LoadQueue can move on. This triggers the complete event, and kick-starts
	*	the next item.
	* @param item 
	* @param loader 
	*/
	private function _processFinishedLoad(item:Dynamic, loader:AbstractLoader):Dynamic;
	
	/**
	* A load item is completed or was canceled, and needs to be removed from the LoadQueue.
	* @param loader A loader instance to remove.
	*/
	private function _removeLoadItem(loader:AbstractLoader):Dynamic;
	
	/**
	* Add an item to the queue. Items are formatted into a usable object containing all the properties necessary to
	*	load the content. The load queue is populated with the loader instance that handles preloading, and not the load
	*	item that was passed in by the user. To look up the load item by id or src, use the {{#crossLink "LoadQueue.getItem"}}{{/crossLink}}
	*	method.
	* @param value The item to add to the queue.
	* @param path An optional path prepended to the `src`. The path will only be prepended if the src is
	*	relative, and does not start with a protocol such as `http://`, or a path like `../`. If the LoadQueue was
	*	provided a {{#crossLink "_basePath"}}{{/crossLink}}, then it will optionally be prepended after.
	* @param basePath <strong>Deprecated</strong>An optional basePath passed into a {{#crossLink "LoadQueue/loadManifest"}}{{/crossLink}}
	*	or {{#crossLink "LoadQueue/loadFile"}}{{/crossLink}} call. This parameter will be removed in a future tagged
	*	version.
	*/
	private function _addItem(value:Dynamic, ?path:String, ?basePath:String):Dynamic;
	
	/**
	* An internal initialization method, which is used for initial set up, but also to reset the LoadQueue.
	* @param preferXHR 
	* @param basePath 
	* @param crossOrigin 
	*/
	private function init(preferXHR:Dynamic, basePath:Dynamic, crossOrigin:Dynamic):Dynamic;
	
	/**
	* An item has dispatched progress. Propagate that progress, and update the LoadQueue's overall progress.
	* @param event The progress event from the item.
	*/
	private function _handleProgress(event:ProgressEvent):Dynamic;
	
	/**
	* An item has finished loading. We can assume that it is totally loaded, has been parsed for immediate use, and
	*	is available as the "result" property on the load item. The raw text result for a parsed item (such as JSON, XML,
	*	CSS, JavaScript, etc) is available as the "rawResult" property, and can also be looked up using {{#crossLink "LoadQueue/getResult"}}{{/crossLink}}.
	* @param event The event object from the loader.
	*/
	private function _handleFileComplete(event:Event):Dynamic;
	
	/**
	* Begin loading an item. Event listeners are not added to the loaders until the load starts.
	* @param loader The loader instance to start. Currently, this will be an XHRLoader or TagLoader.
	*/
	private function _loadItem(loader:AbstractLoader):Dynamic;
	
	/**
	* Change the {{#crossLink "preferXHR:property"}}{{/crossLink}} value. Note that if this is set to `true`, it may
	*	fail, or be ignored depending on the browser's capabilities and the load type.
	* @param value 
	*/
	public function setPreferXHR(value:Bool):Bool;
	
	/**
	* Clean out item results, to free them from memory. Mainly, the loaded item and results are cleared from internal
	*	hashes.
	* @param item The item that was passed in for preloading.
	*/
	private function _disposeItem(item:Dynamic):Dynamic;
	
	/**
	* Close the active queue. Closing a queue completely empties the queue, and prevents any remaining items from
	*	starting to download. Note that currently any active loads will remain open, and events may be processed.
	*	
	*	To stop and restart a queue, use the {{#crossLink "LoadQueue/setPaused"}}{{/crossLink}} method instead.
	*/
	public function close():Dynamic;
	
	/**
	* Create a loader for a load item.
	* @param item A formatted load item that can be used to generate a loader.
	*/
	private function _createLoader(item:Dynamic):AbstractLoader;
	
	/**
	* Create a refined {{#crossLink "LoadItem"}}{{/crossLink}}, which contains all the required properties. The type of
	*	item is determined by browser support, requirements based on the file type, and developer settings. For example,
	*	XHR is only used for file types that support it in new browsers.
	*	
	*	Before the item is returned, any plugins registered to handle the type or extension will be fired, which may
	*	alter the load item.
	* @param value The item that needs to be preloaded.
	* @param path A path to prepend to the item's source. Sources beginning with http:// or similar will
	*	not receive a path. Since PreloadJS 0.4.1, the src will be modified to include the `path` and {{#crossLink "LoadQueue/_basePath:property"}}{{/crossLink}}
	*	when it is added.
	* @param basePath <strong>Deprectated</strong> A base path to prepend to the items source in addition to
	*	the path argument.
	*/
	private function _createLoadItem(value:Dynamic, ?path:String, ?basePath:String):Dynamic;
	
	/**
	* Dispatch a "fileprogress" {{#crossLink "Event"}}{{/crossLink}}. Please see the LoadQueue {{#crossLink "LoadQueue/fileprogress:event"}}{{/crossLink}}
	*	event for details on the event payload.
	* @param item The item that is being loaded.
	* @param progress The amount the item has been loaded (between 0 and 1).
	*/
	private function _sendFileProgress(item:Dynamic, progress:Float):Dynamic;
	
	/**
	* Dispatch a fileload {{#crossLink "Event"}}{{/crossLink}}. Please see the {{#crossLink "LoadQueue/fileload:event"}}{{/crossLink}} event for
	*	details on the event payload.
	* @param item The item that is being loaded.
	* @param loader 
	*/
	private function _sendFileComplete(item:LoadItem, loader:AbstractLoader):Dynamic;
	
	/**
	* Dispatch a filestart {{#crossLink "Event"}}{{/crossLink}} immediately before a file starts to load. Please see
	*	the {{#crossLink "LoadQueue/filestart:event"}}{{/crossLink}} event for details on the event payload.
	* @param item The item that is being loaded.
	*/
	private function _sendFileStart(item:Dynamic):Dynamic;
	
	/**
	* Ensure items with `maintainOrder=true` that are before the specified item have loaded. This only applies to
	*	JavaScript items that are being loaded with a TagLoader, since they have to be loaded and completed <strong>before</strong>
	*	the script can even be started, since it exist in the DOM while loading.
	* @param loader The loader for the item
	*/
	private function _canStartLoad(loader:AbstractLoader):Bool;
	
	/**
	* Ensure the scripts load and dispatch in the correct order. When using XHR, scripts are stored in an array in the
	*	order they were added, but with a "null" value. When they are completed, the value is set to the load item,
	*	and then when they are processed and dispatched, the value is set to `true`. This method simply
	*	iterates the array, and ensures that any loaded items that are not preceded by a `null` value are
	*	dispatched.
	*/
	private function _checkScriptLoadOrder():Dynamic;
	
	/**
	* Flag an item as finished. If the item's order is being managed, then ensure that it is allowed to finish, and if
	*	so, trigger prior items to trigger as well.
	* @param loader 
	* @param loadFailed 
	*/
	private function _finishOrderedItem(loader:AbstractLoader, loadFailed:Bool):Bool;
	
	/**
	* Generate an list of items loaded by this queue.
	* @param loaded Determines if only items that have been loaded should be returned. If false, in-progress
	*	and failed load items will also be included.
	*/
	public function getItems(loaded:Bool):Array<Dynamic>;
	
	/**
	* Load a single file. To add multiple files at once, use the {{#crossLink "LoadQueue/loadManifest"}}{{/crossLink}}
	*	method.
	*	
	*	Files are always appended to the current queue, so this method can be used multiple times to add files.
	*	To clear the queue first, use the {{#crossLink "AbstractLoader/close"}}{{/crossLink}} method.
	* @param file The file object or path to load. A file can be either
	*	<ul>
	*	    <li>A {{#crossLink "LoadItem"}}{{/crossLink}} instance</li>
	*	    <li>An object containing properties defined by {{#crossLink "LoadItem"}}{{/crossLink}}</li>
	*	    <li>OR A string path to a resource. Note that this kind of load item will be converted to a {{#crossLink "LoadItem"}}{{/crossLink}}
	*	    in the background.</li>
	*	</ul>
	* @param loadNow Kick off an immediate load (true) or wait for a load call (false). The default
	*	value is true. If the queue is paused using {{#crossLink "LoadQueue/setPaused"}}{{/crossLink}}, and the value is
	*	`true`, the queue will resume automatically.
	* @param basePath A base path that will be prepended to each file. The basePath argument overrides the
	*	path specified in the constructor. Note that if you load a manifest using a file of type {{#crossLink "AbstractLoader/MANIFEST:property"}}{{/crossLink}},
	*	its files will <strong>NOT</strong> use the basePath parameter. <strong>The basePath parameter is deprecated.</strong>
	*	This parameter will be removed in a future version. Please either use the `basePath` parameter in the LoadQueue
	*	constructor, or a `path` property in a manifest definition.
	*/
	public function loadFile(file:Dynamic, ?loadNow:Bool, ?basePath:String):Dynamic;
	
	/**
	* Load an array of files. To load a single file, use the {{#crossLink "LoadQueue/loadFile"}}{{/crossLink}} method.
	*	The files in the manifest are requested in the same order, but may complete in a different order if the max
	*	connections are set above 1 using {{#crossLink "LoadQueue/setMaxConnections"}}{{/crossLink}}. Scripts will load
	*	in the right order as long as {{#crossLink "LoadQueue/maintainScriptOrder"}}{{/crossLink}} is true (which is
	*	default).
	*	
	*	Files are always appended to the current queue, so this method can be used multiple times to add files.
	*	To clear the queue first, use the {{#crossLink "AbstractLoader/close"}}{{/crossLink}} method.
	* @param manifest An list of files to load. The loadManifest call supports four types of
	*	manifests:
	*	<ol>
	*	    <li>A string path, which points to a manifest file, which is a JSON file that contains a "manifest" property,
	*	    which defines the list of files to load, and can optionally contain a "path" property, which will be
	*	    prepended to each file in the list.</li>
	*	    <li>An object which defines a "src", which is a JSON or JSONP file. A "callback" can be defined for JSONP
	*	    file. The JSON/JSONP file should contain a "manifest" property, which defines the list of files to load,
	*	    and can optionally contain a "path" property, which will be prepended to each file in the list.</li>
	*	    <li>An object which contains a "manifest" property, which defines the list of files to load, and can
	*	    optionally contain a "path" property, which will be prepended to each file in the list.</li>
	*	    <li>An Array of files to load.</li>
	*	</ol>
	*	
	*	Each "file" in a manifest can be either:
	*	<ul>
	*	    <li>A {{#crossLink "LoadItem"}}{{/crossLink}} instance</li>
	*	    <li>An object containing properties defined by {{#crossLink "LoadItem"}}{{/crossLink}}</li>
	*	    <li>OR A string path to a resource. Note that this kind of load item will be converted to a {{#crossLink "LoadItem"}}{{/crossLink}}
	*	    in the background.</li>
	*	</ul>
	* @param loadNow Kick off an immediate load (true) or wait for a load call (false). The default
	*	value is true. If the queue is paused using {{#crossLink "LoadQueue/setPaused"}}{{/crossLink}} and this value is
	*	`true`, the queue will resume automatically.
	* @param basePath A base path that will be prepended to each file. The basePath argument overrides the
	*	path specified in the constructor. Note that if you load a manifest using a file of type {{#crossLink "LoadQueue/MANIFEST:property"}}{{/crossLink}},
	*	its files will <strong>NOT</strong> use the basePath parameter. <strong>The basePath parameter is deprecated.</strong>
	*	This parameter will be removed in a future version. Please either use the `basePath` parameter in the LoadQueue
	*	constructor, or a `path` property in a manifest definition.
	*/
	public function loadManifest(manifest:Dynamic, ?loadNow:Bool, ?basePath:String):Dynamic;
	
	/**
	* Load the next item in the queue. If the queue is empty (all items have been loaded), then the complete event
	*	is processed. The queue will "fill up" any empty slots, up to the max connection specified using
	*	{{#crossLink "LoadQueue.setMaxConnections"}}{{/crossLink}} method. The only exception is scripts that are loaded
	*	using tags, which have to be loaded one at a time to maintain load order.
	*/
	private function _loadNext():Dynamic;
	
	/**
	* Look up a loaded result using either the "id" or "src" that was specified when loading it. Note that if no "id"
	*	was supplied with the load item, the ID will be the "src", including a `path` property defined by a manifest. The
	*	`basePath` will not be part of the ID.
	* @param value The <code>id</code> or <code>src</code> of the load item.
	* @param rawResult Return a raw result instead of a formatted result. This applies to content
	*	loaded via XHR such as scripts, XML, CSS, and Images. If there is no raw result, the formatted result will be
	*	returned instead.
	*/
	//public function getResult(value:String, ?rawResult:Bool):Dynamic;
	
	/**
	* Look up a {{#crossLink "LoadItem"}}{{/crossLink}} using either the "id" or "src" that was specified when loading it. Note that if no "id" was
	*	supplied with the load item, the ID will be the "src", including a `path` property defined by a manifest. The
	*	`basePath` will not be part of the ID.
	* @param value The <code>id</code> or <code>src</code> of the load item.
	*/
	//public function getItem(value:String):Dynamic;
	
	/**
	* Overall progress has changed, so determine the new progress amount and dispatch it. This changes any time an
	*	item dispatches progress or completes. Note that since we don't always know the actual filesize of items before
	*	they are loaded. In this case, we define a "slot" for each item (1 item in 10 would get 10%), and then append
	*	loaded progress on top of the already-loaded items.
	*	
	*	For example, if 5/10 items have loaded, and item 6 is 20% loaded, the total progress would be:
	*	<ul>
	*	     <li>5/10 of the items in the queue (50%)</li>
	*	     <li>plus 20% of item 6's slot (2%)</li>
	*	     <li>equals 52%</li>
	*	</ul>
	*/
	private function _updateProgress():Dynamic;
	
	/**
	* Pause or resume the current load. Active loads will not be cancelled, but the next items in the queue will not
	*	be processed when active loads complete. LoadQueues are not paused by default.
	*	
	*	Note that if new items are added to the queue using {{#crossLink "LoadQueue/loadFile"}}{{/crossLink}} or
	*	{{#crossLink "LoadQueue/loadManifest"}}{{/crossLink}}, a paused queue will be resumed, unless the `loadNow`
	*	argument is `false`.
	* @param value Whether the queue should be paused or not.
	*/
	public function setPaused(value:Bool):Dynamic;
	
	/**
	* Register a custom loaders class. New loaders are given precedence over loaders added earlier and default loaders.
	*	It is recommended that loaders extend {{#crossLink "AbstractLoader"}}{{/crossLink}}. Loaders can only be added
	*	once, and will be prepended to the list of available loaders.
	* @param loader The AbstractLoader class to add.
	*/
	public function registerLoader(loader:Dynamic):Dynamic;
	
	/**
	* Register a plugin. Plugins can map to load types (sound, image, etc), or specific extensions (png, mp3, etc).
	*	Currently, only one plugin can exist per type/extension.
	*	
	*	When a plugin is installed, a <code>getPreloadHandlers()</code> method will be called on it. For more information
	*	on this method, check out the {{#crossLink "SamplePlugin/getPreloadHandlers"}}{{/crossLink}} method in the
	*	{{#crossLink "SamplePlugin"}}{{/crossLink}} class.
	*	
	*	Before a file is loaded, a matching plugin has an opportunity to modify the load. If a `callback` is returned
	*	from the {{#crossLink "SamplePlugin/getPreloadHandlers"}}{{/crossLink}} method, it will be invoked first, and its
	*	result may cancel or modify the item. The callback method can also return a `completeHandler` to be fired when
	*	the file is loaded, or a `tag` object, which will manage the actual download. For more information on these
	*	methods, check out the {{#crossLink "SamplePlugin/preloadHandler"}}{{/crossLink}} and {{#crossLink "SamplePlugin/fileLoadHandler"}}{{/crossLink}}
	*	methods on the {{#crossLink "SamplePlugin"}}{{/crossLink}}.
	* @param plugin The plugin class to install.
	*/
	public function installPlugin(plugin:Dynamic):Dynamic;
	
	/**
	* Remove a custom loader added using {{#crossLink "registerLoader"}}{{/crossLink}}. Only custom loaders can be
	*	unregistered, the default loaders will always be available.
	* @param loader The AbstractLoader class to remove
	*/
	public function unregisterLoader(loader:Dynamic):Dynamic;
	
	/**
	* Set the maximum number of concurrent connections. Note that browsers and servers may have a built-in maximum
	*	number of open connections, so any additional connections may remain in a pending state until the browser
	*	opens the connection. When loading scripts using tags, and when {{#crossLink "LoadQueue/maintainScriptOrder:property"}}{{/crossLink}}
	*	is `true`, only one script is loaded at a time due to browser limitations.
	*	
	*	<h4>Example</h4>
	*	
	*	     var queue = new createjs.LoadQueue();
	*	     queue.setMaxConnections(10); // Allow 10 concurrent loads
	* @param value The number of concurrent loads to allow. By default, only a single connection per LoadQueue
	*	is open at any time.
	*/
	public function setMaxConnections(value:Float):Dynamic;
	
	/**
	* Some loaders might load additional content, other than the item they were passed (such as {{#crossLink "ManifestLoader"}}{{/crossLink}}).
	*	Any items exposed by the loader using {{#crossLink "AbstractLoader/getLoadItems"}}{{/crossLink}} are added to the
	*	LoadQueue's look-ups, including {{#crossLink "getItem"}}{{/crossLink}} and {{#crossLink "getResult"}}{{/crossLink}}
	*	methods.
	* @param loader 
	*/
	private function _saveLoadedItems(loader:AbstractLoader):Dynamic;
	
	/**
	* Start a LoadQueue that was created, but not automatically started.
	*/
	//public function load():Dynamic;
	
	/**
	* Stops all open loads, destroys any loaded items, and resets the queue, so all items can
	*	be reloaded again by calling {{#crossLink "AbstractLoader/load"}}{{/crossLink}}. Items are not removed from the
	*	queue. To remove items use the {{#crossLink "LoadQueue/remove"}}{{/crossLink}} or
	*	{{#crossLink "LoadQueue/removeAll"}}{{/crossLink}} method.
	*/
	public function reset():Dynamic;
	
	/**
	* Stops all queued and loading items, and clears the queue. This also removes all internal references to loaded
	*	content, and allows the queue to be used again.
	*/
	public function removeAll():Dynamic;
	
	/**
	* Stops an item from being loaded, and removes it from the queue. If nothing is passed, all items are removed.
	*	This also removes internal references to loaded item(s).
	*	
	*	<h4>Example</h4>
	*	
	*	     queue.loadManifest([
	*	         {src:"test.png", id:"png"},
	*	         {src:"test.jpg", id:"jpg"},
	*	         {src:"test.mp3", id:"mp3"}
	*	     ]);
	*	     queue.remove("png"); // Single item by ID
	*	     queue.remove("png", "test.jpg"); // Items as arguments. Mixed id and src.
	*	     queue.remove(["test.png", "jpg"]); // Items in an Array. Mixed id and src.
	* @param idsOrUrls The id or ids to remove from this queue. You can pass an item, an array of
	*	items, or multiple items as arguments.
	*/
	public function remove(idsOrUrls:Dynamic):Dynamic;
	
	/**
	* The callback that is fired when a loader encounters an error. The queue will continue loading unless {{#crossLink "LoadQueue/stopOnError:property"}}{{/crossLink}}
	*	is set to `true`.
	* @param event The error event, containing relevant error information.
	*/
	private function _handleError(event:ErrorEvent):Dynamic;
	
	/**
	* The LoadQueue class is the main API for preloading content. LoadQueue is a load manager, which can preload either
	*	a single file, or queue of files.
	*	
	*	<b>Creating a Queue</b><br />
	*	To use LoadQueue, create a LoadQueue instance. If you want to force tag loading where possible, set the preferXHR
	*	argument to false.
	*	
	*	     var queue = new createjs.LoadQueue(true);
	*	
	*	<b>Listening for Events</b><br />
	*	Add any listeners you want to the queue. Since PreloadJS 0.3.0, the {{#crossLink "EventDispatcher"}}{{/crossLink}}
	*	lets you add as many listeners as you want for events. You can subscribe to the following events:<ul>
	*	    <li>{{#crossLink "AbstractLoader/complete:event"}}{{/crossLink}}: fired when a queue completes loading all
	*	    files</li>
	*	    <li>{{#crossLink "AbstractLoader/error:event"}}{{/crossLink}}: fired when the queue encounters an error with
	*	    any file.</li>
	*	    <li>{{#crossLink "AbstractLoader/progress:event"}}{{/crossLink}}: Progress for the entire queue has
	*	    changed.</li>
	*	    <li>{{#crossLink "LoadQueue/fileload:event"}}{{/crossLink}}: A single file has completed loading.</li>
	*	    <li>{{#crossLink "LoadQueue/fileprogress:event"}}{{/crossLink}}: Progress for a single file has changes. Note
	*	    that only files loaded with XHR (or possibly by plugins) will fire progress events other than 0 or 100%.</li>
	*	</ul>
	*	
	*	     queue.on("fileload", handleFileLoad, this);
	*	     queue.on("complete", handleComplete, this);
	*	
	*	<b>Adding files and manifests</b><br />
	*	Add files you want to load using {{#crossLink "LoadQueue/loadFile"}}{{/crossLink}} or add multiple files at a
	*	time using a list or a manifest definition using {{#crossLink "LoadQueue/loadManifest"}}{{/crossLink}}. Files are
	*	appended to the end of the active queue, so you can use these methods as many times as you like, whenever you
	*	like.
	*	
	*	     queue.loadFile("filePath/file.jpg");
	*	     queue.loadFile({id:"image", src:"filePath/file.jpg"});
	*	     queue.loadManifest(["filePath/file.jpg", {id:"image", src:"filePath/file.jpg"}]);
	*	
	*	     // Use an external manifest
	*	     queue.loadManifest("path/to/manifest.json");
	*	     queue.loadManifest({src:"manifest.json", type:"manifest"});
	*	
	*	If you pass `false` as the `loadNow` parameter, the queue will not kick of the load of the files, but it will not
	*	stop if it has already been started. Call the {{#crossLink "AbstractLoader/load"}}{{/crossLink}} method to begin
	*	a paused queue. Note that a paused queue will automatically resume when new files are added to it with a
	*	`loadNow` argument of `true`.
	*	
	*	     queue.load();
	*	
	*	<b>File Types</b><br />
	*	The file type of a manifest item is auto-determined by the file extension. The pattern matching in PreloadJS
	*	should handle the majority of standard file and url formats, and works with common file extensions. If you have
	*	either a non-standard file extension, or are serving the file using a proxy script, then you can pass in a
	*	<code>type</code> property with any manifest item.
	*	
	*	     queue.loadFile({src:"path/to/myFile.mp3x", type:createjs.AbstractLoader.SOUND});
	*	
	*	     // Note that PreloadJS will not read a file extension from the query string
	*	     queue.loadFile({src:"http://server.com/proxy?file=image.jpg", type:createjs.AbstractLoader.IMAGE});
	*	
	*	Supported types are defined on the {{#crossLink "AbstractLoader"}}{{/crossLink}} class, and include:
	*	<ul>
	*	    <li>{{#crossLink "AbstractLoader/BINARY:property"}}{{/crossLink}}: Raw binary data via XHR</li>
	*	    <li>{{#crossLink "AbstractLoader/CSS:property"}}{{/crossLink}}: CSS files</li>
	*	    <li>{{#crossLink "AbstractLoader/IMAGE:property"}}{{/crossLink}}: Common image formats</li>
	*	    <li>{{#crossLink "AbstractLoader/JAVASCRIPT:property"}}{{/crossLink}}: JavaScript files</li>
	*	    <li>{{#crossLink "AbstractLoader/JSON:property"}}{{/crossLink}}: JSON data</li>
	*	    <li>{{#crossLink "AbstractLoader/JSONP:property"}}{{/crossLink}}: JSON files cross-domain</li>
	*	    <li>{{#crossLink "AbstractLoader/MANIFEST:property"}}{{/crossLink}}: A list of files to load in JSON format, see
	*	    {{#crossLink "AbstractLoader/loadManifest"}}{{/crossLink}}</li>
	*	    <li>{{#crossLink "AbstractLoader/SOUND:property"}}{{/crossLink}}: Audio file formats</li>
	*	    <li>{{#crossLink "AbstractLoader/SPRITESHEET:property"}}{{/crossLink}}: JSON SpriteSheet definitions. This
	*	    will also load sub-images, and provide a {{#crossLink "SpriteSheet"}}{{/crossLink}} instance.</li>
	*	    <li>{{#crossLink "AbstractLoader/SVG:property"}}{{/crossLink}}: SVG files</li>
	*	    <li>{{#crossLink "AbstractLoader/TEXT:property"}}{{/crossLink}}: Text files - XHR only</li>
	*	    <li>{{#crossLink "AbstractLoader/VIDEO:property"}}{{/crossLink}}: Video objects</li>
	*	    <li>{{#crossLink "AbstractLoader/XML:property"}}{{/crossLink}}: XML data</li>
	*	</ul>
	*	
	*	<em>Note: Loader types used to be defined on LoadQueue, but have been moved to AbstractLoader for better
	*	portability of loader classes, which can be used individually now. The properties on LoadQueue still exist, but
	*	are deprecated.</em>
	*	
	*	<b>Handling Results</b><br />
	*	When a file is finished downloading, a {{#crossLink "LoadQueue/fileload:event"}}{{/crossLink}} event is
	*	dispatched. In an example above, there is an event listener snippet for fileload. Loaded files are usually a
	*	formatted object that can be used immediately, including:
	*	<ul>
	*	    <li>Binary: The binary loaded result</li>
	*	    <li>CSS: A &lt;link /&gt; tag</li>
	*	    <li>Image: An &lt;img /&gt; tag</li>
	*	    <li>JavaScript: A &lt;script /&gt; tag</li>
	*	    <li>JSON/JSONP: A formatted JavaScript Object</li>
	*	    <li>Manifest: A JavaScript object.
	*	    <li>Sound: An &lt;audio /&gt; tag</a>
	*	    <li>SpriteSheet: A {{#crossLink "SpriteSheet"}}{{/crossLink}} instance, containing loaded images.
	*	    <li>SVG: An &lt;object /&gt; tag</li>
	*	    <li>Text: Raw text</li>
	*	    <li>Video: A Video DOM node</li>
	*	    <li>XML: An XML DOM node</li>
	*	</ul>
	*	
	*	     function handleFileLoad(event) {
	*	         var item = event.item; // A reference to the item that was passed in to the LoadQueue
	*	         var type = item.type;
	*	
	*	         // Add any images to the page body.
	*	         if (type == createjs.LoadQueue.IMAGE) {
	*	             document.body.appendChild(event.result);
	*	         }
	*	     }
	*	
	*	At any time after the file has been loaded (usually after the queue has completed), any result can be looked up
	*	via its "id" using {{#crossLink "LoadQueue/getResult"}}{{/crossLink}}. If no id was provided, then the
	*	"src" or file path can be used instead, including the `path` defined by a manifest, but <strong>not including</strong>
	*	a base path defined on the LoadQueue. It is recommended to always pass an id if you want to look up content.
	*	
	*	     var image = queue.getResult("image");
	*	     document.body.appendChild(image);
	*	
	*	Raw loaded content can be accessed using the <code>rawResult</code> property of the {{#crossLink "LoadQueue/fileload:event"}}{{/crossLink}}
	*	event, or can be looked up using {{#crossLink "LoadQueue/getResult"}}{{/crossLink}}, passing `true` as the 2nd
	*	argument. This is only applicable for content that has been parsed for the browser, specifically: JavaScript,
	*	CSS, XML, SVG, and JSON objects, or anything loaded with XHR.
	*	
	*	     var image = queue.getResult("image", true); // load the binary image data loaded with XHR.
	*	
	*	<b>Plugins</b><br />
	*	LoadQueue has a simple plugin architecture to help process and preload content. For example, to preload audio,
	*	make sure to install the <a href="http://soundjs.com">SoundJS</a> Sound class, which will help load HTML audio,
	*	Flash audio, and WebAudio files. This should be installed <strong>before</strong> loading any audio files.
	*	
	*	     queue.installPlugin(createjs.Sound);
	*	
	*	<h4>Known Browser Issues</h4>
	*	<ul>
	*	    <li>Browsers without audio support can not load audio files.</li>
	*	    <li>Safari on Mac OS X can only play HTML audio if QuickTime is installed</li>
	*	    <li>HTML Audio tags will only download until their <code>canPlayThrough</code> event is fired. Browsers other
	*	    than Chrome will continue to download in the background.</li>
	*	    <li>When loading scripts using tags, they are automatically added to the document.</li>
	*	    <li>Scripts loaded via XHR may not be properly inspectable with browser tools.</li>
	*	    <li>IE6 and IE7 (and some other browsers) may not be able to load XML, Text, or JSON, since they require
	*	    XHR to work.</li>
	*	    <li>Content loaded via tags will not show progress, and will continue to download in the background when
	*	    canceled, although no events will be dispatched.</li>
	*	</ul>
	* @param preferXHR Determines whether the preload instance will favor loading with XHR (XML HTTP
	*	Requests), or HTML tags. When this is `false`, the queue will use tag loading when possible, and fall back on XHR
	*	when necessary.
	* @param basePath A path that will be prepended on to the source parameter of all items in the queue
	*	before they are loaded.  Sources beginning with a protocol such as `http://` or a relative path such as `../`
	*	will not receive a base path.
	* @param crossOrigin An optional flag to support images loaded from a CORS-enabled server. To
	*	use it, set this value to `true`, which will default the crossOrigin property on images to "Anonymous". Any
	*	string value will be passed through, but only "" and "Anonymous" are recommended. <strong>Note: The crossOrigin
	*	parameter is deprecated. Use LoadItem.crossOrigin instead</strong>
	*/
	public function new(?preferXHR:Bool, ?basePath:String, ?crossOrigin:Dynamic):Void;
	
	public function setUseXHR(value:Bool):Bool;
	
}
