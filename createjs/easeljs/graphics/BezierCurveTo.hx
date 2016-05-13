package createjs.easeljs.graphics;

import js.html.CanvasRenderingContext2D;

/**
* Graphics command object. See {{#crossLink "Graphics/bezierCurveTo"}}{{/crossLink}} and {{#crossLink "Graphics/append"}}{{/crossLink}} for more information.
*/
@:native("createjs.Graphics.BezierCurveTo")
extern class BezierCurveTo
{
	public var cp1x:Float;
	
	public var cp1y:Float;
	
	public var cp2x:Float;
	
	public var cp2y:Float;
	
	public var x:Float;
	
	public var y:Float;
	
	/**
	* Execute the Graphics command in the provided Canvas context.
	* @param ctx The canvas rendering context
	*/
	public function exec(ctx:CanvasRenderingContext2D):Dynamic;
	
	/**
	* Graphics command object. See {{#crossLink "Graphics/bezierCurveTo"}}{{/crossLink}} and {{#crossLink "Graphics/append"}}{{/crossLink}} for more information.
	* @param cp1x 
	* @param cp1y 
	* @param cp2x 
	* @param cp2y 
	* @param x 
	* @param y 
	*/
	public function new(cp1x:Float, cp1y:Float, cp2x:Float, cp2y:Float, x:Float, y:Float):Void;
	
}
