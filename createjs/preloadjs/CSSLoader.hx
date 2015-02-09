package createjs.preloadjs;

/**
* A loader for CSS files.
*/
@:native("createjs.CSSLoader")
extern class CSSLoader extends AbstractLoader
{
	/**
	* A loader for CSS files.
	* @param loadItem 
	* @param preferXHR 
	*/
	public function new(loadItem:Dynamic, preferXHR:Bool):Void;
	
	/**
	* Determines if the loader can load a specific item. This loader can only load items that are of type
	*	{{#crossLink "AbstractLoader/CSS:property"}}{{/crossLink}}.
	* @param item The LoadItem that a LoadQueue is trying to load.
	*/
	public static function canLoadItem(item:Dynamic):Bool;
	
	/**
	* The result formatter for CSS files.
	* @param loader 
	*/
	private function _formatResult(loader:AbstractLoader):Dynamic;
	
}
