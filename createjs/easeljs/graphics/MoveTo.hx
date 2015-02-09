package createjs.easeljs.graphics;

import js.html.CanvasRenderingContext2D;

/**
* Graphics command object. See {{#crossLink "Graphics/moveTo"}}{{/crossLink}} and {{#crossLink "Graphics/append"}}{{/crossLink}} for more information.
*/
@:native("createjs.Graphics.MoveTo")
extern class MoveTo
{
	public var x:Float;
	
	public var y:Float;
	
	/**
	* Graphics command object. See {{#crossLink "Graphics/moveTo"}}{{/crossLink}} and {{#crossLink "Graphics/append"}}{{/crossLink}} for more information.
	* @param x 
	* @param y 
	*/
	public function new(x:Float, y:Float):Void;
	
	public function exec(ctx:CanvasRenderingContext2D):Dynamic;
	
}
