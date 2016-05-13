package createjs.preloadjs;

/**
* A loader for JSONP files, which are JSON-formatted text files, wrapped in a callback. To load regular JSON
*	without a callback use the {{#crossLink "JSONLoader"}}{{/crossLink}} instead. To load JSON-formatted manifests,
*	use {{#crossLink "ManifestLoader"}}{{/crossLink}}, and to load EaselJS SpriteSheets, use
*	{{#crossLink "SpriteSheetLoader"}}{{/crossLink}}.
*	
*	JSONP is a format that provides a solution for loading JSON files cross-domain <em>without</em> requiring CORS.
*	JSONP files are loaded as JavaScript, and the "callback" is executed once they are loaded. The callback in the
*	JSONP must match the callback passed to the loadItem.
*	
*	<h4>Example JSONP</h4>
*	
*			callbackName({
*				"name": "value",
*		 		"num": 3,
*				"obj": { "bool":true }
*			});
*	
*	<h4>Example</h4>
*	
*			var loadItem = {id:"json", type:"jsonp", src:"http://server.com/text.json", callback:"callbackName"}
*			var queue = new createjs.LoadQueue();
*			queue.on("complete", handleComplete);
*			queue.loadItem(loadItem);
*	
*			function handleComplete(event) }
*				var json = queue.getResult("json");
*				console.log(json.obj.bool); // true
*			}
*	
*	Note that JSONP files loaded concurrently require a <em>unique</em> callback. To ensure JSONP files are loaded
*	in order, either use the {{#crossLink "LoadQueue/setMaxConnections"}}{{/crossLink}} method (set to 1),
*	or set {{#crossLink "LoadItem/maintainOrder:property"}}{{/crossLink}} on items with the same callback.
*/
@:native("createjs.JSONPLoader")
extern class JSONPLoader extends AbstractLoader
{
	/**
	* A loader for JSONP files, which are JSON-formatted text files, wrapped in a callback. To load regular JSON
	*	without a callback use the {{#crossLink "JSONLoader"}}{{/crossLink}} instead. To load JSON-formatted manifests,
	*	use {{#crossLink "ManifestLoader"}}{{/crossLink}}, and to load EaselJS SpriteSheets, use
	*	{{#crossLink "SpriteSheetLoader"}}{{/crossLink}}.
	*	
	*	JSONP is a format that provides a solution for loading JSON files cross-domain <em>without</em> requiring CORS.
	*	JSONP files are loaded as JavaScript, and the "callback" is executed once they are loaded. The callback in the
	*	JSONP must match the callback passed to the loadItem.
	*	
	*	<h4>Example JSONP</h4>
	*	
	*			callbackName({
	*				"name": "value",
	*		 		"num": 3,
	*				"obj": { "bool":true }
	*			});
	*	
	*	<h4>Example</h4>
	*	
	*			var loadItem = {id:"json", type:"jsonp", src:"http://server.com/text.json", callback:"callbackName"}
	*			var queue = new createjs.LoadQueue();
	*			queue.on("complete", handleComplete);
	*			queue.loadItem(loadItem);
	*	
	*			function handleComplete(event) }
	*				var json = queue.getResult("json");
	*				console.log(json.obj.bool); // true
	*			}
	*	
	*	Note that JSONP files loaded concurrently require a <em>unique</em> callback. To ensure JSONP files are loaded
	*	in order, either use the {{#crossLink "LoadQueue/setMaxConnections"}}{{/crossLink}} method (set to 1),
	*	or set {{#crossLink "LoadItem/maintainOrder:property"}}{{/crossLink}} on items with the same callback.
	* @param loadItem 
	*/
	public function new(loadItem:Dynamic):Void;
	
	/**
	* Clean up the JSONP load. This clears out the callback and script tag that this loader creates.
	*/
	private function _dispose():Dynamic;
	
	/**
	* Determines if the loader can load a specific item. This loader can only load items that are of type
	*	{{#crossLink "AbstractLoader/JSONP:property"}}{{/crossLink}}.
	* @param item The LoadItem that a LoadQueue is trying to load.
	*/
	public static function canLoadItem(item:Dynamic):Bool;
	
	/**
	* Handle the JSONP callback, which is a public method defined on `window`.
	* @param data The formatted JSON data.
	*/
	private function _handleLoad(data:Dynamic):Dynamic;
	
	/**
	* Loads the JSONp file.  Because of the unique loading needs of JSONp
	*	we don't use the AbstractLoader.load() method.
	*/
	//public function load():Dynamic;
	
	/**
	* The tag request has not loaded within the time specfied in loadTimeout.
	* @param event The XHR error event.
	*/
	private function _handleError(event:Dynamic):Dynamic;
	
}
