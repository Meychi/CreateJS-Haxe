package createjs.easeljs.graphics;

import js.html.CanvasRenderingContext2D;

/**
* Graphics command object. See {{#crossLink "Graphics/setStrokeStyle"}}{{/crossLink}} and {{#crossLink "Graphics/append"}}{{/crossLink}} for more information.
*/
@:native("createjs.Graphics.StrokeStyle")
extern class StrokeStyle
{
	/**
	* One of: butt, round, square
	*/
	public var caps:String;
	
	/**
	* One of: round, bevel, miter
	*/
	public var joints:String;
	
	public var miterLimit:Float;
	
	public var width:Float;
	
	/**
	* Execute the Graphics command in the provided Canvas context.
	* @param ctx The canvas rendering context
	*/
	public function exec(ctx:CanvasRenderingContext2D):Dynamic;
	
	/**
	* Graphics command object. See {{#crossLink "Graphics/setStrokeStyle"}}{{/crossLink}} and {{#crossLink "Graphics/append"}}{{/crossLink}} for more information.
	* @param width 
	* @param caps 
	* @param joints 
	* @param miterLimit 
	* @param ignoreScale 
	*/
	public function new(width:Float, ?caps:String, ?joints:String, ?miterLimit:Float, ?ignoreScale:Bool):Void;
	
}
