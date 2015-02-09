package createjs.preloadjs;

import js.html.Element;

/**
* An {{#crossLink "AbstractRequest"}}{{/crossLink}} that loads HTML tags, such as images and scripts.
*/
@:native("createjs.TagRequest")
extern class TagRequest
{
	/**
	* A method closure used for handling the tag load event.
	*/
	private var _loadedHandler:Dynamic;
	
	/**
	* Determines if the element was added to the DOM automatically by PreloadJS, so it can be cleaned up after.
	*/
	private var _addedToDOM:Bool;
	
	/**
	* The HTML tag instance that is used to load.
	*/
	private var _tag:Element;
	
	/**
	* The tag attribute that specifies the source, such as "src", "href", etc.
	*/
	private var _tagSrcAttribute:String;
	
	/**
	* Handle a stalled audio event. The main place this happens is with HTMLAudio in Chrome when playing back audio
	*	that is already in a load, but not complete.
	*/
	private function _handleStalled():Dynamic;
	
	/**
	* Handle the readyStateChange event from a tag. We need this in place of the `onload` callback (mainly SCRIPT
	*	and LINK tags), but other cases may exist.
	*/
	private function _handleReadyStateChange():Dynamic;
	
	/**
	* Handle the tag's onload callback.
	*/
	private function _handleTagComplete():Dynamic;
	
	/**
	* Remove event listeners, but don't destroy the request object
	*/
	private function _clean():Dynamic;
	
	/**
	* The tag request has not loaded within the time specified in loadTimeout.
	* @param event The XHR error event.
	*/
	private function _handleError(event:Dynamic):Dynamic;
	
}
