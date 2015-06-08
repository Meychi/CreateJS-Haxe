package createjs.preloadjs;

import js.html.ErrorEvent;
import js.html.Event;
import js.html.ProgressEvent;
import js.html.svg.Number;

/**
* A loader for JSON manifests. Items inside the manifest are loaded before the loader completes. To load manifests
*	using JSONP, specify a {{#crossLink "LoadItem/callback:property"}}{{/crossLink}} as part of the
*	{{#crossLink "LoadItem"}}{{/crossLink}}.
*	
*	The list of files in the manifest must be defined on the top-level JSON object in a `manifest` property. This
*	example shows a sample manifest definition, as well as how to to include a sub-manifest.
*	
*			{
*				"path": "assets/",
*		 	    "manifest": [
*					"image.png",
*					{"src": "image2.png", "id":"image2"},
*					{"src": "sub-manifest.json", "type":"manifest", "callback":"jsonCallback"}
*		 	    ]
*		 	}
*	
*	When a ManifestLoader has completed loading, the parent loader (usually a {{#crossLink "LoadQueue"}}{{/crossLink}},
*	but could also be another ManifestLoader) will inherit all the loaded items, so you can access them directly.
*	
*	Note that the {{#crossLink "JSONLoader"}}{{/crossLink}} and {{#crossLink "JSONPLoader"}}{{/crossLink}} are
*	higher priority loaders, so manifests <strong>must</strong> set the {{#crossLink "LoadItem"}}{{/crossLink}}
*	{{#crossLink "LoadItem/type:property"}}{{/crossLink}} property to {{#crossLink "AbstractLoader/MANIFEST:property"}}{{/crossLink}}.
*/
@:native("createjs.ManifestLoader")
extern class ManifestLoader extends AbstractLoader
{
	/**
	* An array of the plugins registered using {{#crossLink "LoadQueue/installPlugin"}}{{/crossLink}}, used to pass plugins to new LoadQueues that may be created.
	*/
	private var _plugins:Array<Dynamic>;
	
	/**
	* An internal {{#crossLink "LoadQueue"}}{{/crossLink}} that loads the contents of the manifest.
	*/
	private var _manifestQueue:LoadQueue;
	
	/**
	* The amount of progress that the manifest itself takes up.
	*/
	public static var MANIFEST_PROGRESS:Number;
	
	/**
	* A loader for JSON manifests. Items inside the manifest are loaded before the loader completes. To load manifests
	*	using JSONP, specify a {{#crossLink "LoadItem/callback:property"}}{{/crossLink}} as part of the
	*	{{#crossLink "LoadItem"}}{{/crossLink}}.
	*	
	*	The list of files in the manifest must be defined on the top-level JSON object in a `manifest` property. This
	*	example shows a sample manifest definition, as well as how to to include a sub-manifest.
	*	
	*			{
	*				"path": "assets/",
	*		 	    "manifest": [
	*					"image.png",
	*					{"src": "image2.png", "id":"image2"},
	*					{"src": "sub-manifest.json", "type":"manifest", "callback":"jsonCallback"}
	*		 	    ]
	*		 	}
	*	
	*	When a ManifestLoader has completed loading, the parent loader (usually a {{#crossLink "LoadQueue"}}{{/crossLink}},
	*	but could also be another ManifestLoader) will inherit all the loaded items, so you can access them directly.
	*	
	*	Note that the {{#crossLink "JSONLoader"}}{{/crossLink}} and {{#crossLink "JSONPLoader"}}{{/crossLink}} are
	*	higher priority loaders, so manifests <strong>must</strong> set the {{#crossLink "LoadItem"}}{{/crossLink}}
	*	{{#crossLink "LoadItem/type:property"}}{{/crossLink}} property to {{#crossLink "AbstractLoader/MANIFEST:property"}}{{/crossLink}}.
	* @param loadItem 
	*/
	public function new(loadItem:Dynamic):Void;
	
	/**
	* An item from the {{#crossLink "_manifestQueue:property"}}{{/crossLink}} has completed.
	* @param event 
	*/
	private function _handleManifestFileLoad(event:Event):Dynamic;
	
	/**
	* Create and load the manifest items once the actual manifest has been loaded.
	* @param json 
	*/
	private function _loadManifest(json:Dynamic):Dynamic;
	
	/**
	* Determines if the loader can load a specific item. This loader can only load items that are of type
	*	{{#crossLink "AbstractLoader/MANIFEST:property"}}{{/crossLink}}
	* @param item The LoadItem that a LoadQueue is trying to load.
	*/
	public static function canLoadItem(item:Dynamic):Bool;
	
	/**
	* The manifest has completed loading. This triggers the {{#crossLink "AbstractLoader/complete:event"}}{{/crossLink}}
	*	{{#crossLink "Event"}}{{/crossLink}} from the ManifestLoader.
	* @param event 
	*/
	private function _handleManifestComplete(event:Event):Dynamic;
	
	/**
	* The manifest has reported an error with one of the files.
	* @param event 
	*/
	private function _handleManifestError(event:ErrorEvent):Dynamic;
	
	/**
	* The manifest has reported progress.
	* @param event 
	*/
	private function _handleManifestProgress(event:ProgressEvent):Dynamic;
	
}
