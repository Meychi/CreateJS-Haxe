package createjs.preloadjs;

import js.html.XMLDocument;

/**
* A loader for CSS files.
*/
@:native("createjs.XMLLoader")
extern class XMLLoader extends AbstractLoader
{
	/**
	* A loader for CSS files.
	* @param loadItem 
	*/
	public function new(loadItem:Dynamic):Void;
	
	/**
	* Determines if the loader can load a specific item. This loader can only load items that are of type
	*	{{#crossLink "AbstractLoader/XML:property"}}{{/crossLink}}.
	* @param item The LoadItem that a LoadQueue is trying to load.
	*/
	public static function canLoadItem(item:Dynamic):Bool;
	
	/**
	* The result formatter for XML files.
	* @param loader 
	*/
	private function _formatResult(loader:AbstractLoader):XMLDocument;
	
}
