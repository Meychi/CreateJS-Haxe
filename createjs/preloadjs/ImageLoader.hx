package createjs.preloadjs;
import js.html.ImageElement;

/**
* A loader for image files.
*/
@:native("createjs.ImageLoader")
extern class ImageLoader extends AbstractLoader
{
	/**
	* Before the item loads, set its mimeType and responseType.
	*/
	private var _updateXHR:Dynamic;
	
	/**
	* A loader for image files.
	* @param loadItem 
	* @param preferXHR 
	*/
	public function new(loadItem:Dynamic, preferXHR:Bool):Void;
	
	/**
	* Determines if the loader can load a specific item. This loader can only load items that are of type
	*	{{#crossLink "AbstractLoader/IMAGE:property"}}{{/crossLink}}.
	* @param item The LoadItem that a LoadQueue is trying to load.
	*/
	public static function canLoadItem(item:Dynamic):Bool;
	
	/**
	* The result formatter for Image files.
	* @param loader 
	*/
	private function _formatResult(loader:AbstractLoader):ImageElement;
	
}
