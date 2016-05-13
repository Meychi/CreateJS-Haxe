package createjs.easeljs.graphics;

import js.html.CanvasRenderingContext2D;

/**
* Graphics command object. See {{#crossLink "Graphics/arc"}}{{/crossLink}} and {{#crossLink "Graphics/append"}}{{/crossLink}} for more information.
*/
@:native("createjs.Graphics.Arc")
extern class Arc
{
	public var anticlockwise:Float;
	
	public var endAngle:Float;
	
	public var radius:Float;
	
	public var startAngle:Float;
	
	public var x:Float;
	
	public var y:Float;
	
	/**
	* Execute the Graphics command in the provided Canvas context.
	* @param ctx The canvas rendering context
	*/
	public function exec(ctx:CanvasRenderingContext2D):Dynamic;
	
	/**
	* Graphics command object. See {{#crossLink "Graphics/arc"}}{{/crossLink}} and {{#crossLink "Graphics/append"}}{{/crossLink}} for more information.
	* @param x 
	* @param y 
	* @param radius 
	* @param startAngle 
	* @param endAngle 
	* @param anticlockwise 
	*/
	public function new(x:Float, y:Float, radius:Float, startAngle:Float, endAngle:Float, anticlockwise:Float):Void;
	
}
