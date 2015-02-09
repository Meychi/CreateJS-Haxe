package createjs.easeljs.graphics;

import js.html.CanvasRenderingContext2D;

/**
* Graphics command object. See {{#crossLink "Graphics/drawCircle"}}{{/crossLink}} and {{#crossLink "Graphics/append"}}{{/crossLink}} for more information.
*/
@:native("createjs.Graphics.Circle")
extern class Circle
{
	public var radius:Float;
	
	public var x:Float;
	
	public var y:Float;
	
	/**
	* Graphics command object. See {{#crossLink "Graphics/drawCircle"}}{{/crossLink}} and {{#crossLink "Graphics/append"}}{{/crossLink}} for more information.
	* @param x 
	* @param y 
	* @param radius 
	*/
	public function new(x:Float, y:Float, radius:Float):Void;
	
	public function exec(ctx:CanvasRenderingContext2D):Dynamic;
	
}
