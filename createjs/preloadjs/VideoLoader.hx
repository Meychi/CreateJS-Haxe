package createjs.preloadjs;

/**
* A loader for video files.
*/
@:native("createjs.VideoLoader")
extern class VideoLoader extends AbstractMediaLoader
{
	/**
	* A loader for video files.
	* @param loadItem 
	* @param preferXHR 
	*/
	public function new(loadItem:Dynamic, preferXHR:Bool):Void;
	
	/**
	* Determines if the loader can load a specific item. This loader can only load items that are of type
	*	{{#crossLink "AbstractLoader/VIDEO:property"}}{{/crossLink}}.
	* @param item The LoadItem that a LoadQueue is trying to load.
	*/
	public static function canLoadItem(item:Dynamic):Bool;
	
}
