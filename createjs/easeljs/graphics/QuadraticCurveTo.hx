package createjs.easeljs.graphics;

import js.html.CanvasRenderingContext2D;

/**
* Graphics command object. See {{#crossLink "Graphics/quadraticCurveTo"}}{{/crossLink}} and {{#crossLink "Graphics/append"}}{{/crossLink}} for more information.
*/
@:native("createjs.Graphics.QuadraticCurveTo")
extern class QuadraticCurveTo
{
	public var cpx:Float;
	
	public var cpy:Float;
	
	public var x:Float;
	
	public var y:Float;
	
	/**
	* Execute the Graphics command in the provided Canvas context.
	* @param ctx The canvas rendering context
	*/
	public function exec(ctx:CanvasRenderingContext2D):Dynamic;
	
	/**
	* Graphics command object. See {{#crossLink "Graphics/quadraticCurveTo"}}{{/crossLink}} and {{#crossLink "Graphics/append"}}{{/crossLink}} for more information.
	* @param cpx 
	* @param cpy 
	* @param x 
	* @param y 
	*/
	public function new(cpx:Float, cpy:Float, x:Float, y:Float):Void;
	
}
