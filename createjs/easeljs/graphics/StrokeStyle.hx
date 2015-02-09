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
	* Graphics command object. See {{#crossLink "Graphics/setStrokeStyle"}}{{/crossLink}} and {{#crossLink "Graphics/append"}}{{/crossLink}} for more information.
	* @param width 
	* @param caps 
	* @param joints 
	* @param miterLimit 
	*/
	public function new(width:Float, ?caps:String, ?joints:String, ?miterLimit:Float):Void;
	
	public function exec(ctx:CanvasRenderingContext2D):Dynamic;
	
}
