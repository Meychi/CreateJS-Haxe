package createjs.preloadjs;

/**
* The AbstractMediaLoader is a base class that handles some of the shared methods and properties of loaders that
*	handle HTML media elements, such as Video and Audio.
*/
@:native("createjs.AbstractMediaLoader")
extern class AbstractMediaLoader extends AbstractLoader
{
	/**
	* Before the item loads, set its mimeType and responseType.
	*/
	private var _updateXHR:Dynamic;
	
	/**
	* Creates a new tag for loading if it doesn't exist yet.
	*/
	//private function _createTag():Dynamic;
	
	/**
	* The AbstractMediaLoader is a base class that handles some of the shared methods and properties of loaders that
	*	handle HTML media elements, such as Video and Audio.
	* @param loadItem 
	* @param preferXHR 
	* @param type The type of media to load. Usually "video" or "audio".
	*/
	public function new(loadItem:Dynamic, preferXHR:Bool, type:String):Void;
	
	/**
	* The result formatter for media files.
	* @param loader 
	*/
	private function _formatResult(loader:AbstractLoader):Dynamic;
	
}
