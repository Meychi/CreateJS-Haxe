package createjs.preloadjs;

/**
* A loader for binary files. This is useful for loading web audio, or content that requires an ArrayBuffer.
*/
@:native("createjs.BinaryLoader")
extern class BinaryLoader extends AbstractLoader
{
	/**
	* Before the item loads, set the response type to "arraybuffer"
	*/
	private var _updateXHR:Dynamic;
	
	/**
	* A loader for binary files. This is useful for loading web audio, or content that requires an ArrayBuffer.
	* @param loadItem 
	*/
	public function new(loadItem:Dynamic):Void;
	
	/**
	* Determines if the loader can load a specific item. This loader can only load items that are of type
	*	{{#crossLink "AbstractLoader/BINARY:property"}}{{/crossLink}}
	* @param item The LoadItem that a LoadQueue is trying to load.
	*/
	public static function canLoadItem(item:Dynamic):Bool;
	
}
