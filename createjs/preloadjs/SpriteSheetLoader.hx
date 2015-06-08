package createjs.preloadjs;

/**
* A loader for EaselJS SpriteSheets. Images inside the spritesheet definition are loaded before the loader
*	completes. To load SpriteSheets using JSONP, specify a {{#crossLink "LoadItem/callback:property"}}{{/crossLink}}
*	as part of the {{#crossLink "LoadItem"}}{{/crossLink}}. Note that the {{#crossLink "JSONLoader"}}{{/crossLink}}
*	and {{#crossLink "JSONPLoader"}}{{/crossLink}} are higher priority loaders, so SpriteSheets <strong>must</strong>
*	set the {{#crossLink "LoadItem"}}{{/crossLink}} {{#crossLink "LoadItem/type:property"}}{{/crossLink}} property
*	to {{#crossLink "AbstractLoader/SPRITESHEET:property"}}{{/crossLink}}.
*/
@:native("createjs.SpriteSheetLoader")
extern class SpriteSheetLoader extends AbstractLoader
{
	/**
	* The amount of progress that the manifest itself takes up.
	*/
	public static var SPRITESHEET_PROGRESS:Float;
	
	/**
	* A loader for EaselJS SpriteSheets. Images inside the spritesheet definition are loaded before the loader
	*	completes. To load SpriteSheets using JSONP, specify a {{#crossLink "LoadItem/callback:property"}}{{/crossLink}}
	*	as part of the {{#crossLink "LoadItem"}}{{/crossLink}}. Note that the {{#crossLink "JSONLoader"}}{{/crossLink}}
	*	and {{#crossLink "JSONPLoader"}}{{/crossLink}} are higher priority loaders, so SpriteSheets <strong>must</strong>
	*	set the {{#crossLink "LoadItem"}}{{/crossLink}} {{#crossLink "LoadItem/type:property"}}{{/crossLink}} property
	*	to {{#crossLink "AbstractLoader/SPRITESHEET:property"}}{{/crossLink}}.
	* @param loadItem 
	*/
	public function new(loadItem:Dynamic):Void;
	
	/**
	* An image has reported an error.
	* @param event 
	*/
	private function _handleManifestError(event:Event):Dynamic;
	
	/**
	* An internal queue which loads the SpriteSheet's images.
	*/
	private function _manifestQueue():Dynamic;
	
	/**
	* An item from the {{#crossLink "_manifestQueue:property"}}{{/crossLink}} has completed.
	* @param event 
	*/
	private function _handleManifestFileLoad(event:Event):Dynamic;
	
	/**
	* Create and load the images once the SpriteSheet JSON has been loaded.
	* @param json 
	*/
	private function _loadManifest(json:Dynamic):Dynamic;
	
	/**
	* Determines if the loader can load a specific item. This loader can only load items that are of type
	*	{{#crossLink "AbstractLoader/SPRITESHEET:property"}}{{/crossLink}}
	* @param item The LoadItem that a LoadQueue is trying to load.
	*/
	public static function canLoadItem(item:Dynamic):Bool;
	
	/**
	* The images have completed loading. This triggers the {{#crossLink "AbstractLoader/complete:event"}}{{/crossLink}}
	*	{{#crossLink "Event"}}{{/crossLink}} from the SpriteSheetLoader.
	* @param event 
	*/
	private function _handleManifestComplete(event:Event):Dynamic;
	
	/**
	* The images {{#crossLink "LoadQueue"}}{{/crossLink}} has reported progress.
	* @param event 
	*/
	private function _handleManifestProgress(event:ProgressEvent):Dynamic;
	
}
