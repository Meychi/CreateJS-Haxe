package createjs.preloadjs;

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
	* Clean up the ObjectURL, the tag is done with it. Note that this function is run
	*	as an event listener without a proxy/closure, as it doesn't require it - so do not
	*	include any functionality that requires scope without changing it.
	* @param event 
	*/
	private function _cleanUpURL(event:Dynamic):Dynamic;
	
	/**
	* Determines if the loader can load a specific item. This loader can only load items that are of type
	*	{{#crossLink "AbstractLoader/IMAGE:property"}}{{/crossLink}}.
	* @param item The LoadItem that a LoadQueue is trying to load.
	*/
	public static function canLoadItem(item:Dynamic):Bool;
	
	/**
	* The asynchronous image formatter function. This is required because images have
	*	a short delay before they are ready.
	* @param successCallback The method to call when the result has finished formatting
	* @param errorCallback The method to call if an error occurs during formatting
	*/
	private function _formatImage(successCallback:Dynamic, errorCallback:Dynamic):Dynamic;
	
	/**
	* The result formatter for Image files.
	* @param loader 
	*/
	private function _formatResult(loader:AbstractLoader):HTMLImageElement;
	
}
