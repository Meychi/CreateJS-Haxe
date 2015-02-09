package createjs.preloadjs;

/**
* A loader for Text files.
*/
@:native("createjs.TextLoader")
extern class TextLoader extends AbstractLoader
{
	/**
	* A loader for Text files.
	* @param loadItem 
	*/
	public function new(loadItem:Dynamic):Void;
	
	/**
	* Determines if the loader can load a specific item. This loader loads items that are of type {{#crossLink "AbstractLoader/TEXT:property"}}{{/crossLink}},
	*	but is also the default loader if a file type can not be determined.
	* @param item The LoadItem that a LoadQueue is trying to load.
	*/
	public static function canLoadItem(item:Dynamic):Bool;
	
}
