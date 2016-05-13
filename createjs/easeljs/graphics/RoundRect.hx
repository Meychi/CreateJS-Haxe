package createjs.easeljs.graphics;

import js.html.CanvasRenderingContext2D;

/**
* Graphics command object. See {{#crossLink "Graphics/drawRoundRectComplex"}}{{/crossLink}} and {{#crossLink "Graphics/append"}}{{/crossLink}} for more information.
*/
@:native("createjs.Graphics.RoundRect")
extern class RoundRect
{
	public var h:Float;
	
	public var radiusBL:Float;
	
	public var radiusBR:Float;
	
	public var radiusTL:Float;
	
	public var radiusTR:Float;
	
	public var w:Float;
	
	public var x:Float;
	
	public var y:Float;
	
	/**
	* Execute the Graphics command in the provided Canvas context.
	* @param ctx The canvas rendering context
	*/
	public function exec(ctx:CanvasRenderingContext2D):Dynamic;
	
	/**
	* Graphics command object. See {{#crossLink "Graphics/drawRoundRectComplex"}}{{/crossLink}} and {{#crossLink "Graphics/append"}}{{/crossLink}} for more information.
	* @param x 
	* @param y 
	* @param w 
	* @param h 
	* @param radiusTL 
	* @param radiusTR 
	* @param radiusBR 
	* @param radiusBL 
	*/
	public function new(x:Float, y:Float, w:Float, h:Float, radiusTL:Float, radiusTR:Float, radiusBR:Float, radiusBL:Float):Void;
	
}
