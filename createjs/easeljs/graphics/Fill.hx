package createjs.easeljs.graphics;

import js.html.CanvasRenderingContext2D;

/**
* Graphics command object. See {{#crossLink "Graphics/beginFill"}}{{/crossLink}} and {{#crossLink "Graphics/append"}}{{/crossLink}} for more information.
*/
@:native("createjs.Graphics.Fill")
extern class Fill
{
	/**
	* A valid Context2D fillStyle.
	*/
	public var style:Dynamic;
	
	public var matrix:Matrix2D;
	
	/**
	* Creates a bitmap fill style and assigns it to the {{#crossLink "Fill/style:property"}}{{/crossLink}}.
	*	See {{#crossLink "Graphics/beginBitmapFill"}}{{/crossLink}} for more information.
	* @param image Must be loaded prior to creating a bitmap fill, or the fill will be empty.
	* @param repetition One of: repeat, repeat-x, repeat-y, or no-repeat.
	*/
	public function bitmap(image:Dynamic, ?repetition:String):Fill;
	
	/**
	* Creates a linear gradient style and assigns it to {{#crossLink "Fill/style:property"}}{{/crossLink}}.
	*	See {{#crossLink "Graphics/beginLinearGradientFill"}}{{/crossLink}} for more information.
	* @param colors 
	* @param ratios 
	* @param x0 
	* @param y0 
	* @param x1 
	* @param y1 
	*/
	public function linearGradient(colors:Array<Dynamic>, ratios:Array<Dynamic>, x0:Float, y0:Float, x1:Float, y1:Float):Fill;
	
	/**
	* Creates a radial gradient style and assigns it to {{#crossLink "Fill/style:property"}}{{/crossLink}}.
	*	See {{#crossLink "Graphics/beginRadialGradientFill"}}{{/crossLink}} for more information.
	* @param colors 
	* @param ratios 
	* @param x0 
	* @param y0 
	* @param r0 
	* @param x1 
	* @param y1 
	* @param r1 
	*/
	public function radialGradient(colors:Array<Dynamic>, ratios:Array<Dynamic>, x0:Float, y0:Float, r0:Float, x1:Float, y1:Float, r1:Float):Fill;
	
	/**
	* Execute the Graphics command in the provided Canvas context.
	* @param ctx The canvas rendering context
	*/
	public function exec(ctx:CanvasRenderingContext2D):Dynamic;
	
	/**
	* Graphics command object. See {{#crossLink "Graphics/beginFill"}}{{/crossLink}} and {{#crossLink "Graphics/append"}}{{/crossLink}} for more information.
	* @param style A valid Context2D fillStyle.
	* @param matrix 
	*/
	public function new(style:Dynamic, matrix:Matrix2D):Void;
	
}
