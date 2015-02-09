package createjs.easeljs;

import js.html.CanvasRenderingContext2D;

/**
* Applies the alpha from the mask image (or canvas) to the target, such that the alpha channel of the result will
*	be derived from the mask, and the RGB channels will be copied from the target. This can be used, for example, to
*	apply an alpha mask to a display object. This can also be used to combine a JPG compressed RGB image with a PNG32
*	alpha mask, which can result in a much smaller file size than a single PNG32 containing ARGB.
*	
*	<b>IMPORTANT NOTE: This filter currently does not support the targetCtx, or targetX/Y parameters correctly.</b>
*	
*	<h4>Example</h4>
*	This example draws a gradient box, then caches it and uses the "cacheCanvas" as the alpha mask on a 100x100 image.
*	
*	     var box = new createjs.Shape();
*	     box.graphics.beginLinearGradientFill(["#000000", "rgba(0, 0, 0, 0)"], [0, 1], 0, 0, 100, 100)
*	     box.graphics.drawRect(0, 0, 100, 100);
*	     box.cache(0, 0, 100, 100);
*	
*	     var bmp = new createjs.Bitmap("path/to/image.jpg");
*	     bmp.filters = [
*	         new createjs.AlphaMaskFilter(box.cacheCanvas)
*	     ];
*	     bmp.cache(0, 0, 100, 100);
*	
*	See {{#crossLink "Filter"}}{{/crossLink}} for more information on applying filters.
*/
@:native("createjs.AlphaMaskFilter")
extern class AlphaMaskFilter extends Filter
{
	/**
	* The image (or canvas) to use as the mask.
	*/
	public var mask:Dynamic;
	
	/**
	* Applies the alpha from the mask image (or canvas) to the target, such that the alpha channel of the result will
	*	be derived from the mask, and the RGB channels will be copied from the target. This can be used, for example, to
	*	apply an alpha mask to a display object. This can also be used to combine a JPG compressed RGB image with a PNG32
	*	alpha mask, which can result in a much smaller file size than a single PNG32 containing ARGB.
	*	
	*	<b>IMPORTANT NOTE: This filter currently does not support the targetCtx, or targetX/Y parameters correctly.</b>
	*	
	*	<h4>Example</h4>
	*	This example draws a gradient box, then caches it and uses the "cacheCanvas" as the alpha mask on a 100x100 image.
	*	
	*	     var box = new createjs.Shape();
	*	     box.graphics.beginLinearGradientFill(["#000000", "rgba(0, 0, 0, 0)"], [0, 1], 0, 0, 100, 100)
	*	     box.graphics.drawRect(0, 0, 100, 100);
	*	     box.cache(0, 0, 100, 100);
	*	
	*	     var bmp = new createjs.Bitmap("path/to/image.jpg");
	*	     bmp.filters = [
	*	         new createjs.AlphaMaskFilter(box.cacheCanvas)
	*	     ];
	*	     bmp.cache(0, 0, 100, 100);
	*	
	*	See {{#crossLink "Filter"}}{{/crossLink}} for more information on applying filters.
	* @param mask 
	*/
	public function new(mask:Dynamic):Void;
	
	/**
	* Applies the filter to the specified context.
	*	
	*	<strong>IMPORTANT NOTE: This filter currently does not support the targetCtx, or targetX/Y parameters
	*	correctly.</strong>
	* @param ctx The 2D context to use as the source.
	* @param x The x position to use for the source rect.
	* @param y The y position to use for the source rect.
	* @param width The width to use for the source rect.
	* @param height The height to use for the source rect.
	* @param targetCtx NOT SUPPORTED IN THIS FILTER. The 2D context to draw the result to. Defaults to the context passed to ctx.
	* @param targetX NOT SUPPORTED IN THIS FILTER. The x position to draw the result to. Defaults to the value passed to x.
	* @param targetY NOT SUPPORTED IN THIS FILTER. The y position to draw the result to. Defaults to the value passed to y.
	*/
	//public function applyFilter(ctx:CanvasRenderingContext2D, x:Float, y:Float, width:Float, height:Float, ?targetCtx:CanvasRenderingContext2D, ?targetX:Float, ?targetY:Float):Bool;
	
}
