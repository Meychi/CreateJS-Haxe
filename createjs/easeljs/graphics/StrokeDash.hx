package createjs.easeljs.graphics;

import js.html.CanvasRenderingContext2D;

/**
* Graphics command object. See {{#crossLink "Graphics/setStrokeDash"}}{{/crossLink}} and {{#crossLink "Graphics/append"}}{{/crossLink}} for more information.
*/
@:native("createjs.Graphics.StrokeDash")
extern class StrokeDash
{
	/**
	* The default value for segments (ie. no dash).
	*/
	public static var EMPTY_SEGMENTS:Array<Dynamic>;
	
	public var offset:Float;
	
	public var segments:Array<Dynamic>;
	
	/**
	* Execute the Graphics command in the provided Canvas context.
	* @param ctx The canvas rendering context
	*/
	public function exec(ctx:CanvasRenderingContext2D):Dynamic;
	
	/**
	* Graphics command object. See {{#crossLink "Graphics/setStrokeDash"}}{{/crossLink}} and {{#crossLink "Graphics/append"}}{{/crossLink}} for more information.
	* @param segments 
	* @param offset 
	*/
	public function new(?segments:Array<Dynamic>, ?offset:Float):Void;
	
}
