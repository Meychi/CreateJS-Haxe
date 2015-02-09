package createjs.preloadjs;

/**
* An {{#crossLink "TagRequest"}}{{/crossLink}} that loads HTML tags for video and audio.
*/
@:native("createjs.MediaTagRequest")
extern class MediaTagRequest
{
	/**
	* An XHR request has reported progress.
	* @param event The XHR progress event.
	*/
	private function _handleProgress(event:Dynamic):Dynamic;
	
	/**
	* An {{#crossLink "TagRequest"}}{{/crossLink}} that loads HTML tags for video and audio.
	* @param loadItem 
	* @param tag 
	* @param srcAttribute The tag attribute that specifies the source, such as "src", "href", etc.
	*/
	public function new(loadItem:LoadItem, tag:Dynamic, srcAttribute:String):Void;
	
}
