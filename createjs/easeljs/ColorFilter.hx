package createjs.easeljs;

/**
* Applies a color transform to DisplayObjects.
*	
*	<h4>Example</h4>
*	This example draws a red circle, and then transforms it to Blue. This is accomplished by multiplying all the channels
*	to 0 (except alpha, which is set to 1), and then adding 255 to the blue channel.
*	
*	     var shape = new createjs.Shape().set({x:100,y:100});
*	     shape.graphics.beginFill("#ff0000").drawCircle(0,0,50);
*	
*	     shape.filters = [
*	         new createjs.ColorFilter(0,0,0,1, 0,0,255,0)
*	     ];
*	     shape.cache(-50, -50, 100, 100);
*	
*	See {{#crossLink "Filter"}}{{/crossLink}} for an more information on applying filters.
*/
@:native("createjs.ColorFilter")
extern class ColorFilter extends Filter
{
	/**
	* Alpha channel multiplier.
	*/
	public var alphaMultiplier:Float;
	
	/**
	* Alpha channel offset (added to value).
	*/
	public var alphaOffset:Float;
	
	/**
	* Blue channel multiplier.
	*/
	public var blueMultiplier:Float;
	
	/**
	* Blue channel offset (added to value).
	*/
	public var blueOffset:Float;
	
	/**
	* Green channel multiplier.
	*/
	public var greenMultiplier:Float;
	
	/**
	* Green channel offset (added to value).
	*/
	public var greenOffset:Float;
	
	/**
	* Red channel multiplier.
	*/
	public var redMultiplier:Float;
	
	/**
	* Red channel offset (added to value).
	*/
	public var redOffset:Float;
	
	/**
	* Applies a color transform to DisplayObjects.
	*	
	*	<h4>Example</h4>
	*	This example draws a red circle, and then transforms it to Blue. This is accomplished by multiplying all the channels
	*	to 0 (except alpha, which is set to 1), and then adding 255 to the blue channel.
	*	
	*	     var shape = new createjs.Shape().set({x:100,y:100});
	*	     shape.graphics.beginFill("#ff0000").drawCircle(0,0,50);
	*	
	*	     shape.filters = [
	*	         new createjs.ColorFilter(0,0,0,1, 0,0,255,0)
	*	     ];
	*	     shape.cache(-50, -50, 100, 100);
	*	
	*	See {{#crossLink "Filter"}}{{/crossLink}} for an more information on applying filters.
	* @param redMultiplier The amount to multiply against the red channel. This is a range between 0 and 1.
	* @param greenMultiplier The amount to multiply against the green channel. This is a range between 0 and 1.
	* @param blueMultiplier The amount to multiply against the blue channel. This is a range between 0 and 1.
	* @param alphaMultiplier The amount to multiply against the alpha channel. This is a range between 0 and 1.
	* @param redOffset The amount to add to the red channel after it has been multiplied. This is a range
	*	between -255 and 255.
	* @param greenOffset The amount to add to the green channel after it has been multiplied. This is a range
	*	between -255 and 255.
	* @param blueOffset The amount to add to the blue channel after it has been multiplied. This is a range
	*	between -255 and 255.
	* @param alphaOffset The amount to add to the alpha channel after it has been multiplied. This is a range
	*	between -255 and 255.
	*/
	public function new(?redMultiplier:Float, ?greenMultiplier:Float, ?blueMultiplier:Float, ?alphaMultiplier:Float, ?redOffset:Float, ?greenOffset:Float, ?blueOffset:Float, ?alphaOffset:Float):Void;
	
}
