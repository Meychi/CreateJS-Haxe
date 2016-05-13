package createjs.preloadjs;

/**
* A preloader that loads items using XHR requests, usually XMLHttpRequest. However XDomainRequests will be used
*	for cross-domain requests if possible, and older versions of IE fall back on to ActiveX objects when necessary.
*	XHR requests load the content as text or binary data, provide progress and consistent completion events, and
*	can be canceled during load. Note that XHR is not supported in IE 6 or earlier, and is not recommended for
*	cross-domain loading.
*/
@:native("createjs.XHRRequest")
extern class XHRRequest extends AbstractLoader
{
	/**
	* A list of XMLHTTP object IDs to try when building an ActiveX object for XHR requests in earlier versions of IE.
	*/
	private var ACTIVEX_VERSIONS:Array<Dynamic>;
	
	/**
	* A manual load timeout that is used for browsers that do not support the onTimeout event on XHR (XHR level 1, typically IE9).
	*/
	private var _loadTimeout:Float;
	
	/**
	* A reference to the XHR request used to load the content.
	*/
	private var _request:Dynamic;
	
	/**
	* The browser's XHR (XMLHTTPRequest) version. Supported versions are 1 and 2. There is no official way to detect the version, so we use capabilities to make a best guess.
	*/
	private var _xhrLevel:Float;
	
	/**
	* The response of a loaded file. This is set because it is expensive to look up constantly. This property will be null until the file is loaded.
	*/
	private var _response:Mixed;
	
	/**
	* The response of the loaded file before it is modified. In most cases, content is converted from raw text to an HTML tag or a formatted object which is set to the <code>result</code> property, but the developer may still want to access the raw content as it was loaded.
	*/
	private var _rawResponse:Dynamic;
	
	/**
	* A preloader that loads items using XHR requests, usually XMLHttpRequest. However XDomainRequests will be used
	*	for cross-domain requests if possible, and older versions of IE fall back on to ActiveX objects when necessary.
	*	XHR requests load the content as text or binary data, provide progress and consistent completion events, and
	*	can be canceled during load. Note that XHR is not supported in IE 6 or earlier, and is not recommended for
	*	cross-domain loading.
	* @param item The object that defines the file to load. Please see the {{#crossLink "LoadQueue/loadFile"}}{{/crossLink}}
	*	for an overview of supported file properties.
	*/
	public function new(item:Dynamic):Void;
	
	/**
	* A request has completed (or failed or canceled), and needs to be disposed.
	*/
	private function _clean():Dynamic;
	
	/**
	* Create an XHR request. Depending on a number of factors, we get totally different results.
	*	<ol><li>Some browsers get an <code>XDomainRequest</code> when loading cross-domain.</li>
	*	     <li>XMLHttpRequest are created when available.</li>
	*	     <li>ActiveX.XMLHTTP objects are used in older IE browsers.</li>
	*	     <li>Text requests override the mime type if possible</li>
	*	     <li>Origin headers are sent for crossdomain requests in some browsers.</li>
	*	     <li>Binary loads set the response type to "arraybuffer"</li></ol>
	* @param item The requested item that is being loaded.
	*/
	private function _createXHR(item:Dynamic):Bool;
	
	/**
	* Determine if there is an error in the current load. This checks the status of the request for problem codes. Note
	*	that this does not check for an actual response. Currently, it only checks for error codes between 400 and 599
	*/
	private function _checkError():Int;
	
	/**
	* Get a specific response header from the XmlHttpRequest.
	*	
	*	<strong>From the docs:</strong> Returns the header field value from the response of which the field name matches
	*	header, unless the field name is Set-Cookie or Set-Cookie2.
	* @param header The header name to retrieve.
	*/
	public function getResponseHeader(header:String):String;
	
	/**
	* Get all the response headers from the XmlHttpRequest.
	*	
	*	<strong>From the docs:</strong> Return all the HTTP headers, excluding headers that are a case-insensitive match
	*	for Set-Cookie or Set-Cookie2, as a single string, with each header line separated by a U+000D CR U+000A LF pair,
	*	excluding the status line, and with each header name and header value separated by a U+003A COLON U+0020 SPACE
	*	pair.
	*/
	public function getAllResponseHeaders():String;
	
	/**
	* Look up the loaded result.
	* @param raw Return a raw result instead of a formatted result. This applies to content
	*	loaded via XHR such as scripts, XML, CSS, and Images. If there is no raw result, the formatted result will be
	*	returned instead.
	*/
	//public function getResult(?raw:Bool):Dynamic;
	
	/**
	* The XHR request has completed. This is called by the XHR request directly, or by a readyStateChange that has
	*	<code>request.readyState == 4</code>. Only the first call to this method will be processed.
	* @param event The XHR load event.
	*/
	private function _handleLoad(event:Dynamic):Dynamic;
	
	/**
	* The XHR request has reported a load start.
	* @param event The XHR loadStart event.
	*/
	private function _handleLoadStart(event:Dynamic):Dynamic;
	
	/**
	* The XHR request has reported a readyState change. Note that older browsers (IE 7 & 8) do not provide an onload
	*	event, so we must monitor the readyStateChange to determine if the file is loaded.
	* @param event The XHR readyStateChange event.
	*/
	private function _handleReadyStateChange(event:Dynamic):Dynamic;
	
	/**
	* The XHR request has reported an abort event.
	* @param event The XHR abort event.
	*/
	private function handleAbort(event:Dynamic):Dynamic;
	
	/**
	* The XHR request has reported an error event.
	* @param event The XHR error event.
	*/
	private function _handleError(event:Dynamic):Dynamic;
	
	/**
	* The XHR request has reported progress.
	* @param event The XHR progress event.
	*/
	private function _handleProgress(event:Dynamic):Dynamic;
	
	/**
	* The XHR request has timed out. This is called by the XHR request directly, or via a <code>setTimeout</code>
	*	callback.
	* @param event The XHR timeout event. This is occasionally null when called by the backup setTimeout.
	*/
	private function _handleTimeout(?event:Dynamic):Dynamic;
	
	/**
	* Validate the response. Different browsers have different approaches, some of which throw errors when accessed
	*	in other browsers. If there is no response, the <code>_response</code> property will remain null.
	*/
	private function _getResponse():Dynamic;
	
}
