package createjs.easeljs.graphics;

import js.html.CanvasRenderingContext2D;

/**
* Graphics command object. See {{#crossLink "Graphics/drawPolyStar"}}{{/crossLink}} and {{#crossLink "Graphics/append"}}{{/crossLink}} for more information.
*/
@:native("createjs.Graphics.PolyStar")
extern class PolyStar
{
	public var angle:Float;
	
	public var pointSize:Float;
	
	public var radius:Float;
	
	public var sides:Float;
	
	public var x:Float;
	
	public var y:Float;
	
	/**
	* Execute the Graphics command in the provided Canvas context.
	* @param ctx The canvas rendering context
	*/
	public function exec(ctx:CanvasRenderingContext2D):Dynamic;
	
	/**
	* Graphics command object. See {{#crossLink "Graphics/drawPolyStar"}}{{/crossLink}} and {{#crossLink "Graphics/append"}}{{/crossLink}} for more information.
	* @param x 
	* @param y 
	* @param radius 
	* @param sides 
	* @param pointSize 
	* @param angle 
	*/
	public function new(x:Float, y:Float, radius:Float, sides:Float, pointSize:Float, angle:Float):Void;
	
}
