package createjs.easeljs.graphics;

import js.html.CanvasRenderingContext2D;

/**
* Graphics command object. See {{#crossLink "Graphics/rect"}}{{/crossLink}} and {{#crossLink "Graphics/append"}}{{/crossLink}} for more information.
*/
@:native("createjs.Graphics.Rect")
extern class Rect
{
	public var h:Float;
	
	public var w:Float;
	
	public var x:Float;
	
	public var y:Float;
	
	/**
	* Graphics command object. See {{#crossLink "Graphics/rect"}}{{/crossLink}} and {{#crossLink "Graphics/append"}}{{/crossLink}} for more information.
	* @param x 
	* @param y 
	* @param w 
	* @param h 
	*/
	public function new(x:Float, y:Float, w:Float, h:Float):Void;
	
	public function exec(ctx:CanvasRenderingContext2D):Dynamic;
	
}
