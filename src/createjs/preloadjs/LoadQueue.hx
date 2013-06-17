package createjs.preloadjs;

/**
* The LoadQueue class is the main API for preloading content. LoadQueue is a load manager, which maintains
*	a single file, or a queue of files.
*	
*	<b>Creating a Queue</b><br />
*	To use LoadQueue, create a LoadQueue instance. If you want to force tag loading where possible, set the useXHR
*	argument to false.
*	
*	     var queue = new createjs.LoadQueue(true);
*	
*	<b>Listening for Events</b><br />
*	Add any listeners you want to the queue. Since PreloadJS 0.3.0, the {{#crossLink "EventDispatcher"}}{{/crossLink}}
*	lets you add as many listeners as you want for events. You can subscribe to complete, error, fileload, progress,
*	and fileprogress.
*	
*	     queue.addEventListener("fileload", handleFileLoad);
*	     queue.addEventListener("complete", handleComplete);
*	
*	<b>Adding files and manifests</b><br />
*	Add files you want to load using {{#crossLink "LoadQueue/loadFile"}}{{/crossLink}} or add multiple files at a
*	time using {{#crossLink "LoadQueue/loadManifest"}}{{/crossLink}}. Files are appended to the queue, so you can use
*	these methods as many times as you like, whenever you like.
*	
*	     queue.loadFile("filePath/file.jpg");
*	     queue.loadFile({id:"image", src:"filePath/file.jpg"});
*	     queue.loadManifest(["filePath/file.jpg", {id:"image", src:"filePath/file.jpg"}];
*	
*	If you pass <code>false</code> as the second parameter, the queue will not immediately load the files (unless it
*	has already been started). Call the {{#crossLink "AbstractLoader/load"}}{{/crossLink}} method to begin a paused queue.
*	Note that a paused queue will automatically resume when new files are added to it.
*	
*	     queue.load();
*	
*	<b>Handling Results</b><br />
*	When a file is finished downloading, a "fileload" event is dispatched. In an example above, there is an event
*	listener snippet for fileload. Loaded files are always an object that can be used immediately, including:
*	<ul>
*	    <li>Image: An &lt;img /&gt; tag</li>
*	    <li>Audio: An &lt;audio /&gt; tag</a>
*	    <li>JavaScript: A &lt;script /&gt; tag</li>
*	    <li>CSS: A &lt;link /&gt; tag</li>
*	    <li>XML: An XML DOM node</li>
*	    <li>SVG: An &lt;object /&gt; tag</li>
*	    <li>JSON: A formatted JavaScript Object</li>
*	    <li>Text: Raw text</li>
*	    <li>Binary: The binary loaded result</li>
*	</ul>
*	
*	     function handleFileLoad(event) {
*	         var item = event.item; // A reference to the item that was passed in
*	         var type = item.type;
*	
*	         // Add any images to the page body.
*	         if (type == createjs.LoadQueue.IMAGE) {
*	             document.body.appendChild(event.result);
*	         }
*	     }
*	
*	At any time after the file has been loaded (usually after the queue has completed), any result can be looked up
*	via its "id" using {{#crossLink "LoadQueue/getResult"}}{{/crossLink}}. If no id was provided, then the "src" or
*	file path can be used instead. It is recommended to always pass an id.
*	
*	     var image = queue.getResult("image");
*	     document.body.appendChild(image);
*	
*	Raw loaded content can be accessed using the <code>rawResult</code> property of the <code>fileload</code> event,
*	or can be looked up using {{#crossLink "LoadQueue/getResult"}}{{/crossLink}}, and <code>true</code> as the 2nd
*	parameter. This is only applicable for content that has been parsed for the browser, specifically, JavaScript,
*	CSS, XML, SVG, and JSON objects.
*	
*	     var image = queue.getResult("image", true);
*	
*	<b>Plugins</b><br />
*	LoadQueue has a simple plugin architecture to help process and preload content. For example, to preload audio,
*	make sure to install the <a href="http://soundjs.com">SoundJS</a> Sound class, which will help preload HTML
*	audio, Flash audio, and WebAudio files. This should be installed <b>before</b> loading any audio files.
*	
*	     queue.installPlugin(createjs.Sound);
*	
*	<h4>Known Browser Issues</h4>
*	<ul><li>Browsers without audio support can not load audio files.</li>
*	     <li>Audio tags will only download until their <code>canPlayThrough</code> event is fired. Browsers other
*	     than Chrome will continue to download in the background.</li>
*	     <li>When loading scripts using tags, they are automatically added to the document.</li>
*	     <li>Scripts loaded via XHR may not be properly inspectable with browser tools.</li>
*	     <li>IE6 and IE7 (and some other browsers) may not be able to load XML, Text, or JSON, since they require
*	     XHR to work.</li>
*	     <li>Content loaded via tags will not show progress, and although they can be canceled, they will continue
*	     to download in the background.</li>
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
	* An object hash of callbacks that are fired for each file extension before the file is loaded, giving plugins the ability to override properties of the load. Please see the {{#crossLink "LoadQueue/installPlugin"}}{{/crossLink}} method for more information.
	*/
	private var _extensionCallbacks:Dynamic;
	
	/**
	* An object hash of callbacks that are fired for each file type before the file is loaded, giving plugins the ability to override properties of the load. Please see the {{#crossLink "LoadQueue/installPlugin"}}{{/crossLink}} method for more information.
	*/
	private var _typeCallbacks:Dynamic;
	
	/**
	* An object hash of items that have finished downloading, indexed by item IDs.
	*/
	private var _loadItemsById:Dynamic;
	
	/**
	* An object hash of items that have finished downloading, indexed by item source.
	*/
	private var _loadItemsBySrc:Dynamic;
	
	/**
	* An object hash of loaded items, indexed by the ID of the load item.
	*/
	private var _loadedResults:Dynamic;
	
	/**
	* An object hash of un-parsed loaded items, indexed by the ID of the load item.
	*/
	private var _loadedRawResults:Dynamic;
	
	/**
	* Determines if the loadStart event was dispatched already. This event is only fired one time, when the first file is requested.
	*/
	private var _loadStartWasDispatched:Bool;
	
	/**
	* Determines if there is currently a script loading. This helps ensure that only a single script loads at once when using a script tag to do preloading.
	*/
	private var _currentlyLoadingScript:Bool;
	
	/**
	* Does LoadQueue stop processing the current queue when an error is encountered.
	*/
	public var stopOnError:Bool;
	
	/**
	* Ensure loaded scripts "complete" in the order they are specified. Note that scripts loaded via tags will only load one at a time, and will be added to the document when they are loaded.
	*/
	public var maintainScriptOrder:Bool;
	
	/**
	* The callback that is fired when an individual file is loaded.
	*/
	public var onFileLoad:Dynamic;
	
	/**
	* The callback that is fired when an individual files progress changes.
	*/
	public var onFileProgress:Dynamic;
	
	/**
	* The next preload queue to process when this one is complete. If an error is thrown in the current queue, and <code>loadQueue.stopOnError</code> is <code>true</code>, the next queue will not be processed.
	*/
	public var next:LoadQueue;
	
	/**
	* The number of items that have been requested. This helps manage an overall progress without knowing how large the files are before they are downloaded.
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
	* The preload type for css files. CSS files are loaded into a LINK or STYLE tag (depending on the load type)
	*/
	public static var CSS:String;
	
	/**
	* The preload type for generic binary types. Note that images and sound files are treated as binary.
	*/
	public static var BINARY:String;
	
	/**
	* The preload type for image files, usually png, gif, or jpg/jpeg. Images are loaded into an IMAGE tag.
	*/
	public static var IMAGE:String;
	
	/**
	* The preload type for javascript files, usually with the "js" file extension. JavaScript files are loaded into a SCRIPT tag.
	*/
	public static var JAVASCRIPT:String;
	
	/**
	* The preload type for jsonp files, usually with the "json" file extension. You are required to pass a callback parameter when loading jsonp.
	*/
	public static var JSON:String;
	
	/**
	* The preload type for sound files, usually mp3, ogg, or wav. Audio is loaded into an AUDIO tag.
	*/
	public static var SOUND:String;
	
	/**
	* The preload type for SVG files.
	*/
	public static var SVG:String;
	
	/**
	* The preload type for text files, which is also the default file type if the type can not be determined. Text is loaded as raw text.
	*/
	public static var TEXT:String;
	
	/**
	* The preload type for xml files. XML is loaded into an XML document.
	*/
	public static var XML:String;
	
	/**
	* Time in milliseconds to assume a load has failed.
	*/
	public static var LOAD_TIMEOUT:Float;
	
	/**
	* Use XMLHttpRequest (XHR) when possible. Note that LoadQueue will default to tag loading or XHR loading depending on the requirements for a media type. For example, HTML audio can not be loaded with XHR, and WebAudio can not be loaded with tags, so it will default the the correct type instead of using the user-defined type.  <b>Note: This property is read-only.</b> To change it, please use the {{#crossLink "LoadQueue/setUseXHR"}}{{/crossLink}} method.
	*/
	public var useXHR:Bool;
	
	/**
	* A function proxy for PreloadJS methods. By default, JavaScript methods do not maintain scope, so passing a
	*	method as a callback will result in the method getting called in the scope of the caller. Using a proxy
	*	ensures that the method gets called in the correct scope.
	* @param method The function to call
	* @param scope The scope to call the method name on
	*/
	private static function proxy(method:Dynamic, scope:Dynamic):Dynamic;
	
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
	* @param basePath A path to prepend to the item's source.
	*/
	private function _addItem(value:Dynamic, basePath:String):Dynamic;
	
	/**
	* An item has dispatched progress. Propagate that progress, and update the LoadQueue overall progress.
	* @param event The progress event from the item.
	*/
	private function _handleProgress(event:Dynamic):Dynamic;
	
	/**
	* An item has finished loading. We can assume that it is totally loaded, has been parsed for immediate use, and
	*	is available as the "result" property on the load item. The raw text result for a parsed item (such as JSON, XML,
	*	CSS, JavaScript, etc) is available as the "rawResult" event, and can also be looked up using {{#crossLink "LoadQueue/getResult"}}{{/crossLink}}.
	* @param event The event object from the loader.
	*/
	private function _handleFileComplete(event:Dynamic):Dynamic;
	
	/**
	* Begin loading an item. Events are not added to the loaders until the load starts.
	* @param loader The loader instance to start. Currently, this will be an XHRLoader or TagLoader.
	*/
	private function _loadItem(loader:AbstractLoader):Dynamic;
	
	/**
	* Change the usXHR value. Note that if this is set to true, it may fail depending on the browser's capabilities.
	* @param value The new useXHR value to set.
	*/
	public function setUseXHR(value:Bool):Bool;
	
	/**
	* Clean out item results, to free them from memory. Mainly, the loaded item and results are cleared from internal
	*	hashes.
	* @param item The item that was passed in for preloading.
	*/
	private function _disposeItem(item:Dynamic):Dynamic;
	
	/**
	* Create a loader for a load item.
	* @param item A formatted load item that can be used to generate a loader.
	*/
	private function _createLoader(item:Dynamic):AbstractLoader;
	
	/**
	* Create a refined load item, which contains all the required properties (src, type, extension, tag). The type of
	*	item is determined by browser support, requirements based on the file type, and developer settings. For example,
	*	XHR is only used for file types that support it in new browsers.
	*	
	*	Before the item is returned, any plugins registered to handle the type or extension will be fired, which may
	*	alter the load item.
	* @param value The item that needs to be preloaded.
	*/
	private function _createLoadItem(value:Dynamic):Dynamic;
	
	/**
	* Create an HTML tag. This is in LoadQueue instead of {{#crossLink "TagLoader"}}{{/crossLink}} because no matter
	*	how we load the data, we may need to return it in a tag.
	* @param type The item type. Items are passed in by the developer, or deteremined by the extension.
	*/
	private function _createTag(type:String):Dynamic;
	
	/**
	* Determine if a specific type should be loaded as a binary file. Currently, only images and items marked
	*	specifically as "binary" are loaded as binary. Note that audio is <b>not</b> a binary type, as we can not play
	*	back using an audio tag if it is loaded as binary. Plugins can change the item type to binary to ensure they get
	*	a binary result to work with. Binary files are loaded using XHR2.
	* @param type The item type.
	*/
	private function isBinary(type:String):Dynamic;
	
	/**
	* Dispatch a fileload event (and onFileLoad callback). Please see the <code>LoadQueue.fileload</code> event for
	*	details on the event payload.
	* @param item The item that is being loaded.
	* @param loader 
	*/
	private function _sendFileComplete(item:Dynamic, loader:Dynamic):Dynamic;
	
	/**
	* Dispatch a fileprogress event (and onFileProgress callback). Please see the <code>LoadQueue.fileprogress</code>
	*	event for details on the event payload.
	* @param item The item that is being loaded.
	* @param progress The amount the item has been loaded (between 0 and 1).
	*/
	private function _sendFileProgress(item:Dynamic, progress:Float):Dynamic;
	
	/**
	* Dispatch a filestart event immediately before a file has started to load. Please see the <code>LoadQueue.filestart</code>
	*	event for details on the event payload.
	* @param loader 
	*/
	private function _sendFileStart(loader:Dynamic):Dynamic;
	
	/**
	* Ensure the scripts load and dispatch in the correct order. When using XHR, scripts are stored in an array in the
	*	order they were added, but with a "null" value. When they are completed, the value is set to the load item,
	*	and then when they are processed and dispatched, the value is set to <code>true</code>. This method simply
	*	iterates the array, and ensures that any loaded items that are not preceded by a <code>null</code> value are
	*	dispatched.
	*/
	private function _checkScriptLoadOrder():Dynamic;
	
	/**
	* Load a single file. To add multiple files at once, use the {{#crossLink "LoadQueue/loadManifest"}}{{/crossLink}}
	*	method.
	*	
	*	Note that files are always appended to the current queue, so this method can be used multiple times to add files.
	*	To clear the queue first, use the {{#crossLink "AbstractLoader/close"}}{{/crossLink}} method.
	* @param file The file object or path to load. A file can be either
	*	<ol>
	*	    <li>a path to a resource (string). Note that this kind of load item will be
	*	    converted to an object (see below) in the background.</li>
	*	    <li>OR an object that contains:<ul>
	*	        <li>src: The source of the file that is being loaded. This property is <b>required</b>. The source can
	*	        either be a string (recommended), or an HTML tag.</li>
	*	        <li>type: The type of file that will be loaded (image, sound, json, etc). PreloadJS does auto-detection
	*	        of types using the extension. Supported types are defined on LoadQueue, such as <code>LoadQueue.IMAGE</code>.
	*	        It is recommended that a type is specified when a non-standard file URI (such as a php script) us used.</li>
	*	        <li>id: A string identifier which can be used to reference the loaded object.</li>
	*	        <li>callback: Optional, used for JSONP requests, to define what method to call when the JSONP is loaded.</li>
	*	        <li>data: An arbitrary data object, which is included with the loaded object</li>
	*	        <li>method: used to define if this request uses GET or POST when sending data to the server. Default; GET</li>
	*	        <li>values: Optional object of name/value pairs to send to the server.</li>
	*	    </ul>
	*	</ol>
	* @param loadNow Kick off an immediate load (true) or wait for a load call (false). The default
	*	value is true. If the queue is paused using {{#crossLink "LoadQueue/setPaused"}}{{/crossLink}}, and the value is
	*	true, the queue will resume automatically.
	* @param basePath An optional base path prepended to the file source when the file is loaded. The load
	*	item will not be modified.
	*/
	public function loadFile(file:Dynamic, ?loadNow:Bool, ?basePath:String):Dynamic;
	
	/**
	* Load an array of items. To load a single file, use the {{#crossLink "LoadQueue/loadFile"}}{{/crossLink}} method.
	*	The files in the manifest are requested in the same order, but may complete in a different order if the max
	*	connections are set above 1 using {{#crossLink "LoadQueue/setMaxConnections"}}{{/crossLink}}. Scripts will load
	*	in the right order as long as <code>loadQueue.maintainScriptOrder</code> is true (which is default).
	*	
	*	Note that files are always appended to the current queue, so this method can be used multiple times to add files.
	*	To clear the queue first, use the {{#crossLink "AbstractLoader/close"}}{{/crossLink}} method.
	* @param manifest The list of files to load. Each file can be either:
	*	<ol>
	*	    <li>a path to a resource (string). Note that this kind of load item will be
	*	     converted to an object (see below) in the background.</li>
	*	    <li>OR an object that contains:<ul>
	*	        <li>src: The source of the file that is being loaded. This property is <b>required</b>.
	*	        The source can either be a string (recommended), or an HTML tag. </li>
	*	        <li>type: The type of file that will be loaded (image, sound, json, etc). PreloadJS does auto-detection
	*	        of types using the extension. Supported types are defined on LoadQueue, such as <code>LoadQueue.IMAGE</code>.
	*	        It is recommended that a type is specified when a non-standard file URI (such as a php script) us used.</li>
	*	        <li>id: A string identifier which can be used to reference the loaded object.</li>
	*	        <li>data: An arbitrary data object, which is returned with the loaded object</li>
	*	    </ul>
	*	</ol>
	* @param loadNow Kick off an immediate load (true) or wait for a load call (false). The default
	*	value is true. If the queue is paused using {{#crossLink "LoadQueue/setPaused"}}{{/crossLink}} and this value is
	*	true, the queue will resume automatically.
	* @param basePath An optional base path prepended to each of the files' source when the file is loaded.
	*	The load items will not be modified.
	*/
	public function loadManifest(manifest:Array<Dynamic>, ?loadNow:Bool, ?basePath:String):Dynamic;
	
	/**
	* Load the next item in the queue. If the queue is empty (all items have been loaded), then the complete event
	*	is processed. The queue will "fill up" any empty slots, up to the max connection specified using
	*	{{#crossLink "LoadQueue.setMaxConnections"}}{{/crossLink}} method. The only exception is scripts that are loaded
	*	using tags, which have to be loaded one at a time to maintain load order.
	*/
	private function _loadNext():Dynamic;
	
	/**
	* Look up a load item using either the "id" or "src" that was specified when loading it.
	* @param value The <code>id</code> or <code>src</code> of the load item.
	*/
	public function getItem(value:String):Dynamic;
	
	/**
	* Look up a loaded result using either the "id" or "src" that was specified when loading it.
	* @param value The <code>id</code> or <code>src</code> of the load item.
	* @param rawResult Return a raw result instead of a formatted result. This applies to content
	*	loaded via XHR such as scripts, XML, CSS, and Images. If there is no raw result, the formatted result will be
	*	returned instead.
	*/
	public function getResult(value:String, ?rawResult:Bool):Dynamic;
	
	/**
	* Overall progress has changed, so determine the new progress amount and dispatch it. This changes any time an
	*	item dispatches progress or completes. Note that since we don't know the actual filesize of items before they are
	*	loaded, and even then we can only get the size of items loaded with XHR. In this case, we define a "slot" for
	*	each item (1 item in 10 would get 10%), and then append loaded progress on top of the already-loaded items.
	*	
	*	For example, if 5/10 items have loaded, and item 6 is 20% loaded, the total progress would be:<ul>
	*	     <li>5/10 of the items in the queue (50%)</li>
	*	     <li>plus 20% of item 6's slot (2%)</li>
	*	     <li>equals 52%</li></ul>
	*/
	private function _updateProgress():Dynamic;
	
	/**
	* Pause or resume the current load. Active loads will not be cancelled, but the next items in the queue will not
	*	be processed when active loads complete. LoadQueues are not paused by default.
	* @param value Whether the queue should be paused or not.
	*/
	public function setPaused(value:Bool):Dynamic;
	
	/**
	* Register a plugin. Plugins can map to both load types (sound, image, etc), or can map to specific extensions
	*	(png, mp3, etc). Currently, only one plugin can exist per type/extension. Plugins must return an object containing:
	*	 <ul><li>callback: The function to call</li>
	*	     <li>types: An array of types to handle</li>
	*	     <li>extensions: An array of extensions to handle. This only fires if an applicable type handler has not fired.</li></ul>
	*	Note that even though a plugin might match both a type and extension handler, the type handler takes priority and
	*	is the only one that gets fired.  For example if you have a handler for type=sound, and a handler for extension=mp3,
	*	only the type handler would fire when an mp3 file is loaded.
	* @param plugin The plugin to install
	*/
	public function installPlugin(plugin:Dynamic):Dynamic;
	
	/**
	* Set the maximum number of concurrent connections. Note that browsers and servers may have a built-in maximum
	*	number of open connections, so any additional connections may remain in a pending state until the browser
	*	opens the connection. Note that when loading scripts using tags, with <code>maintainScriptOrder=true</code>, only
	*	one script is loaded at a time due to browser limitations.
	* @param value The number of concurrent loads to allow. By default, only a single connection per LoadQueue
	*	is open at any time.
	*/
	public function setMaxConnections(value:Float):Dynamic;
	
	/**
	* Stops all open loads, destroys any loaded items, and resets the queue, so all items can
	*	be reloaded again by calling {{#crossLink "AbstractLoader/load"}}{{/crossLink}}. Items are not removed from the
	*	queue. To remove items use the {{#crossLink "LoadQueue/remove"}}{{/crossLink}} or
	*	{{#crossLink "LoadQueue/removeAll"}}{{/crossLink}} method.
	*/
	public function reset():Dynamic;
	
	/**
	* Stops all queued and loading items, and clears the queue. This also removes all internal references to loaded
	*	content, and allows the queue to be used again. Items that have not yet started can be kicked off again using
	*	the {{#crossLink "AbstractLoader/load"}}{{/crossLink}} method.
	*/
	public function removeAll():Dynamic;
	
	/**
	* Stops an item from being loaded, and removes it from the queue. If nothing is passed, all items are removed.
	*	This also removes internal references to loaded item(s).
	* @param idsOrUrls The id or ids to remove from this queue. You can pass an item, an array of
	*	items, or multiple items as arguments.
	*/
	public function remove(idsOrUrls:Dynamic):Dynamic;
	
	/**
	* The callback that is fired when a loader encounters an error. The queue will continue loading unless
	*	<code>stopOnError</code> is set to <code>true</code>.
	* @param event The error event, containing relevant error information.
	*/
	private function _handleFileError(event:Dynamic):Dynamic;
	
	/**
	* The LoadQueue class is the main API for preloading content. LoadQueue is a load manager, which maintains
	*	a single file, or a queue of files.
	*	
	*	<b>Creating a Queue</b><br />
	*	To use LoadQueue, create a LoadQueue instance. If you want to force tag loading where possible, set the useXHR
	*	argument to false.
	*	
	*	     var queue = new createjs.LoadQueue(true);
	*	
	*	<b>Listening for Events</b><br />
	*	Add any listeners you want to the queue. Since PreloadJS 0.3.0, the {{#crossLink "EventDispatcher"}}{{/crossLink}}
	*	lets you add as many listeners as you want for events. You can subscribe to complete, error, fileload, progress,
	*	and fileprogress.
	*	
	*	     queue.addEventListener("fileload", handleFileLoad);
	*	     queue.addEventListener("complete", handleComplete);
	*	
	*	<b>Adding files and manifests</b><br />
	*	Add files you want to load using {{#crossLink "LoadQueue/loadFile"}}{{/crossLink}} or add multiple files at a
	*	time using {{#crossLink "LoadQueue/loadManifest"}}{{/crossLink}}. Files are appended to the queue, so you can use
	*	these methods as many times as you like, whenever you like.
	*	
	*	     queue.loadFile("filePath/file.jpg");
	*	     queue.loadFile({id:"image", src:"filePath/file.jpg"});
	*	     queue.loadManifest(["filePath/file.jpg", {id:"image", src:"filePath/file.jpg"}];
	*	
	*	If you pass <code>false</code> as the second parameter, the queue will not immediately load the files (unless it
	*	has already been started). Call the {{#crossLink "AbstractLoader/load"}}{{/crossLink}} method to begin a paused queue.
	*	Note that a paused queue will automatically resume when new files are added to it.
	*	
	*	     queue.load();
	*	
	*	<b>Handling Results</b><br />
	*	When a file is finished downloading, a "fileload" event is dispatched. In an example above, there is an event
	*	listener snippet for fileload. Loaded files are always an object that can be used immediately, including:
	*	<ul>
	*	    <li>Image: An &lt;img /&gt; tag</li>
	*	    <li>Audio: An &lt;audio /&gt; tag</a>
	*	    <li>JavaScript: A &lt;script /&gt; tag</li>
	*	    <li>CSS: A &lt;link /&gt; tag</li>
	*	    <li>XML: An XML DOM node</li>
	*	    <li>SVG: An &lt;object /&gt; tag</li>
	*	    <li>JSON: A formatted JavaScript Object</li>
	*	    <li>Text: Raw text</li>
	*	    <li>Binary: The binary loaded result</li>
	*	</ul>
	*	
	*	     function handleFileLoad(event) {
	*	         var item = event.item; // A reference to the item that was passed in
	*	         var type = item.type;
	*	
	*	         // Add any images to the page body.
	*	         if (type == createjs.LoadQueue.IMAGE) {
	*	             document.body.appendChild(event.result);
	*	         }
	*	     }
	*	
	*	At any time after the file has been loaded (usually after the queue has completed), any result can be looked up
	*	via its "id" using {{#crossLink "LoadQueue/getResult"}}{{/crossLink}}. If no id was provided, then the "src" or
	*	file path can be used instead. It is recommended to always pass an id.
	*	
	*	     var image = queue.getResult("image");
	*	     document.body.appendChild(image);
	*	
	*	Raw loaded content can be accessed using the <code>rawResult</code> property of the <code>fileload</code> event,
	*	or can be looked up using {{#crossLink "LoadQueue/getResult"}}{{/crossLink}}, and <code>true</code> as the 2nd
	*	parameter. This is only applicable for content that has been parsed for the browser, specifically, JavaScript,
	*	CSS, XML, SVG, and JSON objects.
	*	
	*	     var image = queue.getResult("image", true);
	*	
	*	<b>Plugins</b><br />
	*	LoadQueue has a simple plugin architecture to help process and preload content. For example, to preload audio,
	*	make sure to install the <a href="http://soundjs.com">SoundJS</a> Sound class, which will help preload HTML
	*	audio, Flash audio, and WebAudio files. This should be installed <b>before</b> loading any audio files.
	*	
	*	     queue.installPlugin(createjs.Sound);
	*	
	*	<h4>Known Browser Issues</h4>
	*	<ul><li>Browsers without audio support can not load audio files.</li>
	*	     <li>Audio tags will only download until their <code>canPlayThrough</code> event is fired. Browsers other
	*	     than Chrome will continue to download in the background.</li>
	*	     <li>When loading scripts using tags, they are automatically added to the document.</li>
	*	     <li>Scripts loaded via XHR may not be properly inspectable with browser tools.</li>
	*	     <li>IE6 and IE7 (and some other browsers) may not be able to load XML, Text, or JSON, since they require
	*	     XHR to work.</li>
	*	     <li>Content loaded via tags will not show progress, and although they can be canceled, they will continue
	*	     to download in the background.</li>
	*	</ul>
	* @param useXHR Determines whether the preload instance will favor loading with XHR (XML HTTP Requests),
	*	or HTML tags. When this is <code>false</code>, LoadQueue will use tag loading when possible, and fall back on XHR
	*	when necessary.
	* @param basePath A path that will be prepended on to the source parameter of all items in the queue
	*	before they are loaded. Note that a basePath provided to any loadFile or loadManifest call will override the
	*	basePath specified on the LoadQueue constructor.
	*/
	public function new(?useXHR:Bool, basePath:String):Void;
}
