package createjs.easeljs;

/**
* Applies a box blur to DisplayObjects. Note that this filter is fairly CPU intensive, particularly if the quality is
*	set higher than 1.
*	
*	<h4>Example</h4>
*	This example creates a red circle, and then applies a 5 pixel blur to it. It uses the {{#crossLink "Filter/getBounds"}}{{/crossLink}}
*	method to account for the spread that the blur causes.
*	
*	     var shape = new createjs.Shape().set({x:100,y:100});
*	     shape.graphics.beginFill("#ff0000").drawCircle(0,0,50);
*	
*	     var blurFilter = new createjs.BlurFilter(5, 5, 1);
*	     shape.filters = [blurFilter];
*	     var bounds = blurFilter.getBounds();
*	
*	     shape.cache(-50+bounds.x, -50+bounds.y, 100+bounds.width, 100+bounds.height);
*	
*	See {{#crossLink "Filter"}}{{/crossLink}} for an more information on applying filters.
*/
@:native("createjs.BlurFilter")
extern class BlurFilter extends Filter
{
	/**
	* Array of multiply values for blur calculations.
	*/
	public static var MUL_TABLE:Array<Dynamic>;
	
	/**
	* Array of shift values for blur calculations.
	*/
	public static var SHG_TABLE:Array<Dynamic>;
	
	/**
	* Horizontal blur radius in pixels
	*/
	public var blurX:Float;
	
	/**
	* Number of blur iterations. For example, a value of 1 will produce a rough blur. A value of 2 will produce a smoother blur, but take twice as long to run.
	*/
	public var quality:Float;
	
	/**
	* Vertical blur radius in pixels
	*/
	public var blurY:Float;
	
	/**
	* Applies a box blur to DisplayObjects. Note that this filter is fairly CPU intensive, particularly if the quality is
	*	set higher than 1.
	*	
	*	<h4>Example</h4>
	*	This example creates a red circle, and then applies a 5 pixel blur to it. It uses the {{#crossLink "Filter/getBounds"}}{{/crossLink}}
	*	method to account for the spread that the blur causes.
	*	
	*	     var shape = new createjs.Shape().set({x:100,y:100});
	*	     shape.graphics.beginFill("#ff0000").drawCircle(0,0,50);
	*	
	*	     var blurFilter = new createjs.BlurFilter(5, 5, 1);
	*	     shape.filters = [blurFilter];
	*	     var bounds = blurFilter.getBounds();
	*	
	*	     shape.cache(-50+bounds.x, -50+bounds.y, 100+bounds.width, 100+bounds.height);
	*	
	*	See {{#crossLink "Filter"}}{{/crossLink}} for an more information on applying filters.
	* @param blurX The horizontal blur radius in pixels.
	* @param blurY The vertical blur radius in pixels.
	* @param quality The number of blur iterations.
	*/
	public function new(?blurX:Float, ?blurY:Float, ?quality:Float):Void;
	
}
