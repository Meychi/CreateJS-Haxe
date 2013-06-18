package createjs.preloadjs;

/**
* The base loader, which defines all the generic callbacks and events. All loaders extend this class, including the
*	{{#crossLink "LoadQueue"}}{{/crossLink}}.
*/
@:native("createjs.AbstractLoader")
extern class AbstractLoader
{
	/**
	* A path that will be prepended on to the item's source parameter before it is loaded.
	*/
	private var _basePath:String;
	
	/**
	* Determine if the loader was canceled. Canceled loads will not fire complete events. Note that {{#crossLink "LoadQueue"}}{{/crossLink}} queues should be closed using {{#crossLink "AbstractLoader/close"}}{{/crossLink}} instead of canceled.
	*/
	public var canceled:Bool;
	
	/**
	* If the loader has completed loading. This provides a quick check, but also ensures that the different approaches used for loading do not pile up resulting in more than one <code>complete</code> event.
	*/
	public var loaded:Bool;
	
	/**
	* The callback that is fired when a load starts.
	*/
	public var onLoadStart:Dynamic;
	
	/**
	* The callback that is fired when the loader encounters an error.
	*/
	public var onError:Dynamic;
	
	/**
	* The callback that is fired when the loader's content has been entirely loaded.
	*/
	public var onComplete:Dynamic;
	
	/**
	* The callback that is fired when the overall progress changes.
	*/
	public var onProgress:Dynamic;
	
	/**
	* The current load progress (percentage) for this item. This will be a number between 0 and 1.
	*/
	public var progress:Float;
	
	/**
	* The item this loader represents. Note that this is null in a {{#crossLink "LoadQueue"}}{{/crossLink}}, but will be available on loaders such as {{#crossLink "XHRLoader"}}{{/crossLink}} and {{#crossLink "TagLoader"}}{{/crossLink}}.
	*/
	private var _item:Dynamic;
	
	/**
	* The RegExp pattern to use to parse file URIs. This supports simple file names, as well as full domain URIs with query strings. The resulting match is: protocol:$1 domain:$2 path:$3 file:$4 extension:$5 query:$6.
	*/
	public static var FILE_PATTERN:EReg;
	
	/**
	* A utility method that builds a file path using a source, a basePath, and a data object, and formats it into a new
	*	path. All of the loaders in PreloadJS use this method to compile paths when loading.
	* @param src The source path to add values to.
	* @param basePath A string to prepend to the file path. Sources beginning with http:// or similar will
	*	not receive a base path.
	* @param data Object used to append values to this request as a query string. Existing parameters on the
	*	path will be preserved.
	*/
	public function buildPath(src:String, ?basePath:String, ?data:Dynamic):String;
	
	/**
	* Begin loading the queued items. This method can be called when a {{#crossLink "LoadQueue"}}{{/crossLink}} is set
	*	up but not started immediately.
	*/
	public function load():Dynamic;
	
	/**
	* Close the active queue. Closing a queue completely empties the queue, and prevents any remaining items from
	*	starting to download. Note that currently any active loads will remain open, and events may be processed.
	*	
	*	To stop and restart a queue, use the {{#crossLink "LoadQueue/setPaused"}}{{/crossLink}} method instead.
	*/
	public function close():Dynamic;
	
	/**
	* Determine if the load has been canceled. This is important to ensure that method calls or asynchronous events
	*	do not cause issues after the queue has been cleaned up.
	*/
	private function _isCanceled():Bool;
	
	/**
	* Dispatch a complete event (and onComplete callback). Please see the <code>AbstractLoader.complete</code> event
	*	for details on the event payload.
	*/
	private function _sendComplete():Dynamic;
	
	/**
	* Dispatch a loadstart event (and onLoadStart callback). Please see the <code>AbstractLoader.loadstart</code> event
	*	for details on the event payload.
	*/
	private function _sendLoadStart():Dynamic;
	
	/**
	* Dispatch a progress event (and onProgress callback). Please see the <code>AbstractLoader.progress</code> event
	*	for details on the event payload.
	* @param value The progress of the loaded item, or an object containing <code>loaded</code>
	*	and <code>total</code> properties.
	*/
	private function _sendProgress(value:Dynamic):Dynamic;
	
	/**
	* Dispatch an error event (and onError callback). Please see the <code>AbstractLoader.error</code> event for
	*	details on the event payload.
	* @param event The event object containing specific error properties.
	*/
	private function _sendError(event:Dynamic):Dynamic;
	
	/**
	* Formats an object into a query string for either a POST or GET request.
	* @param data The data to convert to a query string.
	* @param query Existing name/value pairs to append on to this query.
	*/
	private function _formatQueryString(data:Dynamic, ?query:Array<Dynamic>):Dynamic;
	
	/**
	* Initialize the loader. This is called by the constructor.
	*/
	private function init():Dynamic;
	
	/**
	* Parse a file URI using the <code>AbstractLoader.FILE_PATTERN</code> RegExp pattern.
	* @param path The file path to parse.
	*/
	private function _parseURI(path:String):Array<Dynamic>;
	
	public function toString():String;
	
}
