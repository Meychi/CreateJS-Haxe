package createjs.easeljs;

import js.html.CanvasRenderingContext2D;

/**
* A Shape allows you to display vector art in the display list. It composites a {{#crossLink "Graphics"}}{{/crossLink}}
*	instance which exposes all of the vector drawing methods. The Graphics instance can be shared between multiple Shape
*	instances to display the same vector graphics with different positions or transforms.
*	
*	If the vector art will not
*	change between draws, you may want to use the {{#crossLink "DisplayObject/cache"}}{{/crossLink}} method to reduce the
*	rendering cost.
*	
*	<h4>Example</h4>
*	
*	     var graphics = new createjs.Graphics().beginFill("#ff0000").drawRect(0, 0, 100, 100);
*	     var shape = new createjs.Shape(graphics);
*	
*	     //Alternatively use can also use the graphics property of the Shape class to renderer the same as above.
*	     var shape = new createjs.Shape();
*	     shape.graphics.beginFill("#ff0000").drawRect(0, 0, 100, 100);
*/
@:native("createjs.Shape")
extern class Shape extends DisplayObject
{
	/**
	* The graphics instance to display.
	*/
	public var graphics:Graphics;
	
	/**
	* A Shape allows you to display vector art in the display list. It composites a {{#crossLink "Graphics"}}{{/crossLink}}
	*	instance which exposes all of the vector drawing methods. The Graphics instance can be shared between multiple Shape
	*	instances to display the same vector graphics with different positions or transforms.
	*	
	*	If the vector art will not
	*	change between draws, you may want to use the {{#crossLink "DisplayObject/cache"}}{{/crossLink}} method to reduce the
	*	rendering cost.
	*	
	*	<h4>Example</h4>
	*	
	*	     var graphics = new createjs.Graphics().beginFill("#ff0000").drawRect(0, 0, 100, 100);
	*	     var shape = new createjs.Shape(graphics);
	*	
	*	     //Alternatively use can also use the graphics property of the Shape class to renderer the same as above.
	*	     var shape = new createjs.Shape();
	*	     shape.graphics.beginFill("#ff0000").drawRect(0, 0, 100, 100);
	* @param graphics Optional. The graphics instance to display. If null, a new Graphics instance will be created.
	*/
	public function new(?graphics:Graphics):Void;
	
	/**
	* Draws the Shape into the specified context ignoring its visible, alpha, shadow, and transform. Returns true if
	*	the draw was handled (useful for overriding functionality).
	*	
	*	<i>NOTE: This method is mainly for internal use, though it may be useful for advanced uses.</i>
	* @param ctx The canvas 2D context object to draw into.
	* @param ignoreCache Indicates whether the draw operation should ignore any current cache. For example,
	*	used for drawing the cache (to prevent it from simply drawing an existing cache back into itself).
	*/
	//public function draw(ctx:CanvasRenderingContext2D, ?ignoreCache:Bool):Bool;
	
	/**
	* Returns a clone of this Shape. Some properties that are specific to this instance's current context are reverted to
	*	their defaults (for example .parent).
	* @param recursive If true, this Shape's {{#crossLink "Graphics"}}{{/crossLink}} instance will also be
	*	cloned. If false, the Graphics instance will be shared with the new Shape.
	*/
	//public function clone(recursive:Bool):Dynamic;
	
	/**
	* Returns a string representation of this object.
	*/
	//public function toString():String;
	
	/**
	* Returns true or false indicating whether the Shape would be visible if drawn to a canvas.
	*	This does not account for whether it would be visible within the boundaries of the stage.
	*	NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
	*/
	//public function isVisible():Bool;
	
}
