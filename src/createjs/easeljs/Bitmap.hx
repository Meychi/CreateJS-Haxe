package createjs.easeljs;

import js.html.CanvasRenderingContext2D;

/**
* A Bitmap represents an Image, Canvas, or Video in the display list. A Bitmap can be instantiated using an existing
*	HTML element, or a string.
*	
*	<h4>Example</h4>
*	     var bitmap = new createjs.Bitmap("imagePath.jpg");
*	
*	Note: When a string path or image tag that is not yet loaded is used, the stage may need to be redrawn before it
*	will be displayed.
*/
@:native("createjs.Bitmap")
extern class Bitmap extends DisplayObject
{
	
	/**
	* Specifies an area of the source image to draw. If omitted, the whole image will be drawn.
	*/
	public var sourceRect:Rectangle;
	
	/**
	* The image to render. This can be an Image, a Canvas, or a Video.
	*/
	public var image:Dynamic;
	private var DisplayObject_draw:Dynamic;
	private var DisplayObject_initialize:Dynamic;
	
	/**
	* A Bitmap represents an Image, Canvas, or Video in the display list. A Bitmap can be instantiated using an existing
	*	HTML element, or a string.
	*	
	*	<h4>Example</h4>
	*	     var bitmap = new createjs.Bitmap("imagePath.jpg");
	*	
	*	Note: When a string path or image tag that is not yet loaded is used, the stage may need to be redrawn before it
	*	will be displayed.
	* @param imageOrUri The source object or URI to an image to display. This can be either an Image, Canvas, or Video object, or a string URI to an image file to load and use. If it is a URI, a new Image object will be constructed and assigned to the .image property.
	*/
	public function new(imageOrUri:Dynamic):Void;
	
	/**
	* Because the content of a Bitmap is already in a simple format, cache is unnecessary for Bitmap instances.
	*	You should <b>not</b> cache Bitmap instances as it can degrade performance.
	*	
	*	<strong>However: If you want to use a filter on a Bitmap, you <em>MUST</em> cache it, or it will not work.</strong>
	*	To see the API for caching, please visit the DisplayObject {{#crossLink "DisplayObject/cache"}}{{/crossLink}}
	*	method.
	*/
	//public function cache():Dynamic;
	
	/**
	* Because the content of a Bitmap is already in a simple format, cache is unnecessary for Bitmap instances.
	*	You should <b>not</b> cache Bitmap instances as it can degrade performance.
	*	
	*	<strong>However: If you want to use a filter on a Bitmap, you <em>MUST</em> cache it, or it will not work.</strong>
	*	To see the API for caching, please visit the DisplayObject {{#crossLink "DisplayObject/cache"}}{{/crossLink}}
	*	method.
	*/
	//public function uncache():Dynamic;
	
	/**
	* Because the content of a Bitmap is already in a simple format, cache is unnecessary for Bitmap instances.
	*	You should <b>not</b> cache Bitmap instances as it can degrade performance.
	*	
	*	<strong>However: If you want to use a filter on a Bitmap, you <em>MUST</em> cache it, or it will not work.</strong>
	*	To see the API for caching, please visit the DisplayObject {{#crossLink "DisplayObject/cache"}}{{/crossLink}}
	*	method.
	*/
	//public function updateCache():Dynamic;
	
	/**
	* Draws the display object into the specified context ignoring it's visible, alpha, shadow, and transform.
	*	Returns true if the draw was handled (useful for overriding functionality).
	*	
	*	NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
	* @param ctx The canvas 2D context object to draw into.
	* @param ignoreCache Indicates whether the draw operation should ignore any current cache.
	*	For example, used for drawing the cache (to prevent it from simply drawing an existing cache back
	*	into itself).
	*/
	//public function draw(ctx:CanvasRenderingContext2D, ignoreCache:Bool):Dynamic;
	
	/**
	* Initialization method.
	*/
	//private function initialize():Dynamic;
	
	/**
	* Returns a clone of the Bitmap instance.
	*/
	//public function clone():Bitmap;
	
	/**
	* Returns a string representation of this object.
	*/
	//public function toString():String;
	
	/**
	* Returns true or false indicating whether the display object would be visible if drawn to a canvas.
	*	This does not account for whether it would be visible within the boundaries of the stage.
	*	
	*	NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
	*/
	//public function isVisible():Bool;
}
