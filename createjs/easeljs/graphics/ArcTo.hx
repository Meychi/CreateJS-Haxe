package createjs.easeljs.graphics;

import js.html.CanvasRenderingContext2D;

/**
* Graphics command object. See {{#crossLink "Graphics/arcTo"}}{{/crossLink}} and {{#crossLink "Graphics/append"}}{{/crossLink}} for more information.
*/
@:native("createjs.Graphics.ArcTo")
extern class ArcTo
{
	public var radius:Float;
	
	public var x1:Float;
	
	public var x2:Float;
	
	public var y1:Float;
	
	public var y2:Float;
	
	/**
	* Execute the Graphics command in the provided Canvas context.
	* @param ctx The canvas rendering context
	*/
	public function exec(ctx:CanvasRenderingContext2D):Dynamic;
	
	/**
	* Graphics command object. See {{#crossLink "Graphics/arcTo"}}{{/crossLink}} and {{#crossLink "Graphics/append"}}{{/crossLink}} for more information.
	* @param x1 
	* @param y1 
	* @param x2 
	* @param y2 
	* @param radius 
	*/
	public function new(x1:Float, y1:Float, x2:Float, y2:Float, radius:Float):Void;
	
}
