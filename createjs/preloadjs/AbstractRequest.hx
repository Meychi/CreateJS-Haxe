package createjs.preloadjs;

/**
* A base class for actual data requests, such as {{#crossLink "XHRRequest"}}{{/crossLink}}, {{#crossLink "TagRequest"}}{{/crossLink}},
*	and {{#crossLink "MediaRequest"}}{{/crossLink}}. PreloadJS loaders will typically use a data loader under the
*	hood to get data.
*/
@:native("createjs.AbstractRequest")
extern class AbstractRequest
{
	/**
	* A base class for actual data requests, such as {{#crossLink "XHRRequest"}}{{/crossLink}}, {{#crossLink "TagRequest"}}{{/crossLink}},
	*	and {{#crossLink "MediaRequest"}}{{/crossLink}}. PreloadJS loaders will typically use a data loader under the
	*	hood to get data.
	* @param item 
	*/
	public function new(item:LoadItem):Void;
	
	/**
	* Begin a load.
	*/
	public function load():Dynamic;
	
	/**
	* Cancel an in-progress request.
	*/
	public function cancel():Dynamic;
	
	/**
	* Clean up a request.
	*/
	public function destroy():Dynamic;
	
}
