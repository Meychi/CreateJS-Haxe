package createjs.easeljs.graphics;

import js.html.CanvasRenderingContext2D;

/**
* Graphics command object. See {{#crossLink "Graphics/beginStroke"}}{{/crossLink}} and {{#crossLink "Graphics/append"}}{{/crossLink}} for more information.
*/
@:native("createjs.Graphics.Stroke")
extern class Stroke
{
	/**
	* A valid Context2D strokeStyle.
	*/
	public var style:Dynamic;
	
	public var ignoreScale:Bool;
	
	/**
	* Creates a bitmap fill style and assigns it to {{#crossLink "Stroke/style:property"}}{{/crossLink}}.
	*	See {{#crossLink "Graphics/beginBitmapStroke"}}{{/crossLink}} for more information.
	* @param image 
	* @param repetition One of: repeat, repeat-x, repeat-y, or no-repeat.
	*/
	public function bitmap(image:Dynamic, ?repetition:String):Fill;
	
	/**
	* Creates a linear gradient style and assigns it to {{#crossLink "Stroke/style:property"}}{{/crossLink}}.
	*	See {{#crossLink "Graphics/beginLinearGradientStroke"}}{{/crossLink}} for more information.
	* @param colors 
	* @param ratios 
	* @param x0 
	* @param y0 
	* @param x1 
	* @param y1 
	*/
	public function linearGradient(colors:Array<Dynamic>, ratios:Array<Dynamic>, x0:Float, y0:Float, x1:Float, y1:Float):Fill;
	
	/**
	* Creates a radial gradient style and assigns it to {{#crossLink "Stroke/style:property"}}{{/crossLink}}.
	*	See {{#crossLink "Graphics/beginRadialGradientStroke"}}{{/crossLink}} for more information.
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
	* Graphics command object. See {{#crossLink "Graphics/beginStroke"}}{{/crossLink}} and {{#crossLink "Graphics/append"}}{{/crossLink}} for more information.
	* @param style A valid Context2D fillStyle.
	* @param ignoreScale 
	*/
	public function new(style:Dynamic, ignoreScale:Bool):Void;
	
}
