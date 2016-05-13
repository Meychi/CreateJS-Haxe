package createjs.preloadjs;

import js.html.ErrorEvent;
import js.html.Event;
import js.html.ProgressEvent;
import js.html.svg.Number;

/**
* A loader for EaselJS SpriteSheets. Images inside the spritesheet definition are loaded before the loader
*	completes. To load SpriteSheets using JSONP, specify a {{#crossLink "LoadItem/callback:property"}}{{/crossLink}}
*	as part of the {{#crossLink "LoadItem"}}{{/crossLink}}. Note that the {{#crossLink "JSONLoader"}}{{/crossLink}}
*	and {{#crossLink "JSONPLoader"}}{{/crossLink}} are higher priority loaders, so SpriteSheets <strong>must</strong>
*	set the {{#crossLink "LoadItem"}}{{/crossLink}} {{#crossLink "LoadItem/type:property"}}{{/crossLink}} property
*	to {{#crossLink "AbstractLoader/SPRITESHEET:property"}}{{/crossLink}}.
*	
*	The {{#crossLink "LoadItem"}}{{/crossLink}} {{#crossLink "LoadItem/crossOrigin:property"}}{{/crossLink}} as well
*	as the {{#crossLink "LoadQueue's"}}{{/crossLink}} `basePath` argument and {{#crossLink "LoadQueue/_preferXHR"}}{{/crossLink}}
*	property supplied to the {{#crossLink "LoadQueue"}}{{/crossLink}} are passed on to the sub-manifest that loads
*	the SpriteSheet images.
*	
*	Note that the SpriteSheet JSON does not respect the {{#crossLink "LoadQueue/_preferXHR:property"}}{{/crossLink}}
*	property, which should instead be determined by the presence of a {{#crossLink "LoadItem/callback:property"}}{{/crossLink}}
*	property on the SpriteSheet load item. This is because the JSON loaded will have a different format depending on
*	if it is loaded as JSON, so just changing `preferXHR` is not enough to change how it is loaded.
*/
@:native("createjs.SpriteSheetLoader")
extern class SpriteSheetLoader extends AbstractLoader
{
	/**
	* The amount of progress that the manifest itself takes up.
	*/
	public static var SPRITESHEET_PROGRESS:Number;
	
	/**
	* A loader for EaselJS SpriteSheets. Images inside the spritesheet definition are loaded before the loader
	*	completes. To load SpriteSheets using JSONP, specify a {{#crossLink "LoadItem/callback:property"}}{{/crossLink}}
	*	as part of the {{#crossLink "LoadItem"}}{{/crossLink}}. Note that the {{#crossLink "JSONLoader"}}{{/crossLink}}
	*	and {{#crossLink "JSONPLoader"}}{{/crossLink}} are higher priority loaders, so SpriteSheets <strong>must</strong>
	*	set the {{#crossLink "LoadItem"}}{{/crossLink}} {{#crossLink "LoadItem/type:property"}}{{/crossLink}} property
	*	to {{#crossLink "AbstractLoader/SPRITESHEET:property"}}{{/crossLink}}.
	*	
	*	The {{#crossLink "LoadItem"}}{{/crossLink}} {{#crossLink "LoadItem/crossOrigin:property"}}{{/crossLink}} as well
	*	as the {{#crossLink "LoadQueue's"}}{{/crossLink}} `basePath` argument and {{#crossLink "LoadQueue/_preferXHR"}}{{/crossLink}}
	*	property supplied to the {{#crossLink "LoadQueue"}}{{/crossLink}} are passed on to the sub-manifest that loads
	*	the SpriteSheet images.
	*	
	*	Note that the SpriteSheet JSON does not respect the {{#crossLink "LoadQueue/_preferXHR:property"}}{{/crossLink}}
	*	property, which should instead be determined by the presence of a {{#crossLink "LoadItem/callback:property"}}{{/crossLink}}
	*	property on the SpriteSheet load item. This is because the JSON loaded will have a different format depending on
	*	if it is loaded as JSON, so just changing `preferXHR` is not enough to change how it is loaded.
	* @param loadItem 
	*/
	public function new(loadItem:Dynamic):Void;
	
	/**
	* An image has reported an error.
	* @param event 
	*/
	private function _handleManifestError(event:ErrorEvent):Dynamic;
	
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
