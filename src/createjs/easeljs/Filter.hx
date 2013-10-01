package createjs.easeljs;

import js.html.CanvasRenderingContext2D;

/**
* Base class that all filters should inherit from. Filters need to be applied to objects that have been cached using
*	the {{#crossLink "DisplayObject/cache"}}{{/crossLink}} method. If an object changes, please cache it again, or use
*	{{#crossLink "DisplayObject/updateCache"}}{{/crossLink}}. Note that the filters must be applied before caching.
*	
*	<h4>Example</h4>
*	     myInstance.filters = [
*	         new createjs.ColorFilter(0, 0, 0, 1, 255, 0, 0),
*	         new createjs.BlurFilter(5, 5, 10)
*	     ];
*	     myInstance.cache(0,0, 100, 100);
*	
*	Note that each filter can implement a {{#crossLink "Filter/getBounds"}}{{/crossLink}} method, which returns the
*	margins that need to be applied in order to fully display the filter. For example, the {{#crossLink "BlurFilter"}}{{/crossLink}}
*	will cause an object to feather outwards, resulting in a margin around the shape.
*	
*	<h4>EaselJS Filters</h4>
*	EaselJS comes with a number of pre-built filters. Note that individual filters are not compiled into the minified
*	version of EaselJS. To use them, you must include them manually in the HTML.
*	<ul><li>{{#crossLink "AlphaMapFilter"}}{{/crossLink}} : Map a greyscale image to the alpha channel of a display object</li>
*	     <li>{{#crossLink "AlphaMaskFilter"}}{{/crossLink}}: Map an image's alpha channel to the alpha channel of a display object</li>
*	     <li>{{#crossLink "BlurFilter"}}{{/crossLink}}: Apply vertical and horizontal blur to a display object</li>
*	     <li>{{#crossLink "ColorFilter"}}{{/crossLink}}: Color transform a display object</li>
*	     <li>{{#crossLink "ColorMatrixFilter"}}{{/crossLink}}: Transform an image using a {{#crossLink "ColorMatrix"}}{{/crossLink}}</li>
*	</ul>
*/
@:native("createjs.Filter")
extern class Filter
{
	/**
	* Applies the filter to the specified context.
	* @param ctx The 2D context to use as the source.
	* @param x The x position to use for the source rect.
	* @param y The y position to use for the source rect.
	* @param width The width to use for the source rect.
	* @param height The height to use for the source rect.
	* @param targetCtx The 2D context to draw the result to. Defaults to the context passed to ctx.
	* @param targetX The x position to draw the result to. Defaults to the value passed to x.
	* @param targetY The y position to draw the result to. Defaults to the value passed to y.
	*/
	public function applyFilter(ctx:CanvasRenderingContext2D, x:Float, y:Float, width:Float, height:Float, ?targetCtx:CanvasRenderingContext2D, ?targetX:Float, ?targetY:Float):Bool;
	
	/**
	* Base class that all filters should inherit from. Filters need to be applied to objects that have been cached using
	*	the {{#crossLink "DisplayObject/cache"}}{{/crossLink}} method. If an object changes, please cache it again, or use
	*	{{#crossLink "DisplayObject/updateCache"}}{{/crossLink}}. Note that the filters must be applied before caching.
	*	
	*	<h4>Example</h4>
	*	     myInstance.filters = [
	*	         new createjs.ColorFilter(0, 0, 0, 1, 255, 0, 0),
	*	         new createjs.BlurFilter(5, 5, 10)
	*	     ];
	*	     myInstance.cache(0,0, 100, 100);
	*	
	*	Note that each filter can implement a {{#crossLink "Filter/getBounds"}}{{/crossLink}} method, which returns the
	*	margins that need to be applied in order to fully display the filter. For example, the {{#crossLink "BlurFilter"}}{{/crossLink}}
	*	will cause an object to feather outwards, resulting in a margin around the shape.
	*	
	*	<h4>EaselJS Filters</h4>
	*	EaselJS comes with a number of pre-built filters. Note that individual filters are not compiled into the minified
	*	version of EaselJS. To use them, you must include them manually in the HTML.
	*	<ul><li>{{#crossLink "AlphaMapFilter"}}{{/crossLink}} : Map a greyscale image to the alpha channel of a display object</li>
	*	     <li>{{#crossLink "AlphaMaskFilter"}}{{/crossLink}}: Map an image's alpha channel to the alpha channel of a display object</li>
	*	     <li>{{#crossLink "BlurFilter"}}{{/crossLink}}: Apply vertical and horizontal blur to a display object</li>
	*	     <li>{{#crossLink "ColorFilter"}}{{/crossLink}}: Color transform a display object</li>
	*	     <li>{{#crossLink "ColorMatrixFilter"}}{{/crossLink}}: Transform an image using a {{#crossLink "ColorMatrix"}}{{/crossLink}}</li>
	*	</ul>
	*/
	public function new():Void;
	
	/**
	* Initialization method.
	*/
	private function initialize():Dynamic;
	
	/**
	* Returns a clone of this Filter instance.
	*/
	public function clone():Filter;
	
	/**
	* Returns a rectangle with values indicating the margins required to draw the filter or null.
	*	For example, a filter that will extend the drawing area 4 pixels to the left, and 7 pixels to the right
	*	(but no pixels up or down) would return a rectangle with (x=-4, y=0, width=11, height=0).
	*/
	public function getBounds():Rectangle;
	
	/**
	* Returns a string representation of this object.
	*/
	public function toString():String;
	
}
