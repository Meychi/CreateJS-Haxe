package createjs.preloadjs;

/**
* All loaders accept an item containing the properties defined in this class. If a raw object is passed instead,
*	it will not be affected, but it must contain at least a {{#crossLink "src:property"}}{{/crossLink}} property. A
*	string path or HTML tag is also acceptable, but it will be automatically converted to a LoadItem using the
*	{{#crossLink "create"}}{{/crossLink}} method by {{#crossLink "AbstractLoader"}}{{/crossLink}}
*/
@:native("createjs.LoadItem")
extern class LoadItem
{
	/**
	* A callback used by JSONP requests that defines what global method to call when the JSONP content is loaded.
	*/
	//public var callback:String;
	
	/**
	* A string identifier which can be used to reference the loaded object. If none is provided, this will be automatically set to the {{#crossLink "src:property"}}{{/crossLink}}.
	*/
	public var id:String;
	
	/**
	* An arbitrary data object, which is included with the loaded object.
	*/
	public var data:Dynamic;
	
	/**
	* An object hash of headers to attach to an XHR request. PreloadJS will automatically attach some default headers when required, including "Origin", "Content-Type", and "X-Requested-With". You may override the default headers by including them in your headers object.
	*/
	public var headers:Dynamic;
	
	/**
	* An object hash of name/value pairs to send to the server.
	*/
	public var values:Dynamic;
	
	/**
	* Default duration in milliseconds to wait before a request times out. This only applies to tag-based and and XHR (level one) loading, as XHR (level 2) provides its own timeout event.
	*/
	public static var LOAD_TIMEOUT_DEFAULT:Float;
	
	/**
	* Determines if a manifest will maintain the order of this item, in relation to other items in the manifest that have also set the `maintainOrder` property to `true`. This only applies when the max connections has been set above 1 (using {{#crossLink "LoadQueue/setMaxConnections"}}{{/crossLink}}). Everything with this property set to `false` will finish as it is loaded. Ordered items are combined with script tags loading in order when {{#crossLink "LoadQueue/maintainScriptOrder:property"}}{{/crossLink}} is set to `true`.
	*/
	public var maintainOrder:Bool;
	
	/**
	* Enable credentials for XHR requests.
	*/
	public var withCredentials:Bool;
	
	/**
	* Set the mime type of XHR-based requests. This is automatically set to "text/plain; charset=utf-8" for text based files (json, xml, text, css, js).
	*/
	public var mimeType:String;
	
	/**
	* Sets the crossOrigin attribute for CORS-enabled images loading cross-domain.
	*/
	public var crossOrigin:Bool;
	
	/**
	* The duration in milliseconds to wait before a request times out. This only applies to tag-based and and XHR (level one) loading, as XHR (level 2) provides its own timeout event.
	*/
	public var loadTimeout:Float;
	
	/**
	* The request method used for HTTP calls. Both {{#crossLink "AbstractLoader/GET:property"}}{{/crossLink}} or {{#crossLink "AbstractLoader/POST:property"}}{{/crossLink}} request types are supported, and are defined as constants on {{#crossLink "AbstractLoader"}}{{/crossLink}}.
	*/
	public var method:String;
	
	/**
	* The source of the file that is being loaded. This property is <b>required</b>. The source can either be a string (recommended), or an HTML tag. This can also be an object, but in that case it has to include a type and be handled by a plugin.
	*/
	public var src:String;
	
	/**
	* The type file that is being loaded. The type of the file is usually inferred by the extension, but can also be set manually. This is helpful in cases where a file does not have an extension.
	*/
	public var type:String;
	
	/**
	* All loaders accept an item containing the properties defined in this class. If a raw object is passed instead,
	*	it will not be affected, but it must contain at least a {{#crossLink "src:property"}}{{/crossLink}} property. A
	*	string path or HTML tag is also acceptable, but it will be automatically converted to a LoadItem using the
	*	{{#crossLink "create"}}{{/crossLink}} method by {{#crossLink "AbstractLoader"}}{{/crossLink}}
	*/
	public function new():Void;
	
	/**
	* Create a LoadItem.
	*	<ul>
	*	    <li>String-based items are converted to a LoadItem with a populated {{#crossLink "src:property"}}{{/crossLink}}.</li>
	*	    <li>LoadItem instances are returned as-is</li>
	*	    <li>Objects are returned with any needed properties added</li>
	*	</ul>
	* @param value The load item value
	*/
	public static function create(value:Dynamic):Dynamic;
	
	/**
	* Provides a chainable shortcut method for setting a number of properties on the instance.
	*	
	*	<h4>Example</h4>
	*	
	*	     var loadItem = new createjs.LoadItem().set({src:"image.png", maintainOrder:true});
	* @param props A generic object containing properties to copy to the LoadItem instance.
	*/
	public function set(props:Dynamic):LoadItem;
	
}
