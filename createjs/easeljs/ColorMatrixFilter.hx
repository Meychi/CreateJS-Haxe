package createjs.easeljs;

/**
* Allows you to carry out complex color operations such as modifying saturation, brightness, or inverting. See the
*	{{#crossLink "ColorMatrix"}}{{/crossLink}} for more information on changing colors. For an easier color transform,
*	consider the {{#crossLink "ColorFilter"}}{{/crossLink}}.
*	
*	<h4>Example</h4>
*	This example creates a red circle, inverts its hue, and then saturates it to brighten it up.
*	
*	     var shape = new createjs.Shape().set({x:100,y:100});
*	     shape.graphics.beginFill("#ff0000").drawCircle(0,0,50);
*	
*	     var matrix = new createjs.ColorMatrix().adjustHue(180).adjustSaturation(100);
*	     shape.filters = [
*	         new createjs.ColorMatrixFilter(matrix)
*	     ];
*	
*	     shape.cache(-50, -50, 100, 100);
*	
*	See {{#crossLink "Filter"}}{{/crossLink}} for an more information on applying filters.
*/
@:native("createjs.ColorMatrixFilter")
extern class ColorMatrixFilter extends Filter
{
	/**
	* A 4x5 matrix describing the color operation to perform. See also the {{#crossLink "ColorMatrix"}}{{/crossLink}}
	*/
	public var matrix:Dynamic;
	
	/**
	* Allows you to carry out complex color operations such as modifying saturation, brightness, or inverting. See the
	*	{{#crossLink "ColorMatrix"}}{{/crossLink}} for more information on changing colors. For an easier color transform,
	*	consider the {{#crossLink "ColorFilter"}}{{/crossLink}}.
	*	
	*	<h4>Example</h4>
	*	This example creates a red circle, inverts its hue, and then saturates it to brighten it up.
	*	
	*	     var shape = new createjs.Shape().set({x:100,y:100});
	*	     shape.graphics.beginFill("#ff0000").drawCircle(0,0,50);
	*	
	*	     var matrix = new createjs.ColorMatrix().adjustHue(180).adjustSaturation(100);
	*	     shape.filters = [
	*	         new createjs.ColorMatrixFilter(matrix)
	*	     ];
	*	
	*	     shape.cache(-50, -50, 100, 100);
	*	
	*	See {{#crossLink "Filter"}}{{/crossLink}} for an more information on applying filters.
	* @param matrix A 4x5 matrix describing the color operation to perform. See also the {{#crossLink "ColorMatrix"}}{{/crossLink}}
	*	class.
	*/
	public function new(matrix:Dynamic):Void;
	
}
