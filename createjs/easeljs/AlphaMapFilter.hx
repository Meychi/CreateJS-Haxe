package createjs.easeljs;

import js.html.Uint8ClampedArray;

/**
* Applies a greyscale alpha map image (or canvas) to the target, such that the alpha channel of the result will
*	be copied from the red channel of the map, and the RGB channels will be copied from the target.
*	
*	Generally, it is recommended that you use {{#crossLink "AlphaMaskFilter"}}{{/crossLink}}, because it has much
*	better performance.
*	
*	<h4>Example</h4>
*	This example draws a red->blue box, caches it, and then uses the cache canvas as an alpha map on a 100x100 image.
*	
*	      var box = new createjs.Shape();
*	      box.graphics.beginLinearGradientFill(["#ff0000", "#0000ff"], [0, 1], 0, 0, 0, 100)
*	      box.graphics.drawRect(0, 0, 100, 100);
*	      box.cache(0, 0, 100, 100);
*	
*	      var bmp = new createjs.Bitmap("path/to/image.jpg");
*	      bmp.filters = [
*	          new createjs.AlphaMapFilter(box.cacheCanvas)
*	      ];
*	      bmp.cache(0, 0, 100, 100);
*	      stage.addChild(bmp);
*	
*	See {{#crossLink "Filter"}}{{/crossLink}} for more information on applying filters.
*/
@:native("createjs.AlphaMapFilter")
extern class AlphaMapFilter extends Filter
{
	/**
	* The greyscale image (or canvas) to use as the alpha value for the result. This should be exactly the same dimensions as the target.
	*/
	public var alphaMap:Dynamic;
	
	private var _alphaMap:Dynamic;
	
	private var _mapData:Uint8ClampedArray;
	
	/**
	* Applies a greyscale alpha map image (or canvas) to the target, such that the alpha channel of the result will
	*	be copied from the red channel of the map, and the RGB channels will be copied from the target.
	*	
	*	Generally, it is recommended that you use {{#crossLink "AlphaMaskFilter"}}{{/crossLink}}, because it has much
	*	better performance.
	*	
	*	<h4>Example</h4>
	*	This example draws a red->blue box, caches it, and then uses the cache canvas as an alpha map on a 100x100 image.
	*	
	*	      var box = new createjs.Shape();
	*	      box.graphics.beginLinearGradientFill(["#ff0000", "#0000ff"], [0, 1], 0, 0, 0, 100)
	*	      box.graphics.drawRect(0, 0, 100, 100);
	*	      box.cache(0, 0, 100, 100);
	*	
	*	      var bmp = new createjs.Bitmap("path/to/image.jpg");
	*	      bmp.filters = [
	*	          new createjs.AlphaMapFilter(box.cacheCanvas)
	*	      ];
	*	      bmp.cache(0, 0, 100, 100);
	*	      stage.addChild(bmp);
	*	
	*	See {{#crossLink "Filter"}}{{/crossLink}} for more information on applying filters.
	* @param alphaMap The greyscale image (or canvas) to use as the alpha value for the
	*	result. This should be exactly the same dimensions as the target.
	*/
	public function new(alphaMap:Dynamic):Void;
	
	private function _prepAlphaMap():Dynamic;
	
}
