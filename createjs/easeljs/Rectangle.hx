package createjs.easeljs;

/**
* Represents a rectangle as defined by the points (x, y) and (x+width, y+height).
*	
*	<h4>Example</h4>
*	
*	     var rect = new createjs.Rectangle(0, 0, 100, 100);
*/
@:native("createjs.Rectangle")
extern class Rectangle
{
	/**
	* Height.
	*/
	public var height:Float;
	
	/**
	* Width.
	*/
	public var width:Float;
	
	/**
	* X position.
	*/
	public var x:Float;
	
	/**
	* Y position.
	*/
	public var y:Float;
	
	/**
	* <strong>REMOVED</strong>. Removed in favor of using `MySuperClass_constructor`.
	*	See {{#crossLink "Utility Methods/extend"}}{{/crossLink}} and {{#crossLink "Utility Methods/promote"}}{{/crossLink}}
	*	for details.
	*	
	*	There is an inheritance tutorial distributed with EaselJS in /tutorials/Inheritance.
	*/
	private function initialize():Dynamic;
	
	/**
	* Adds the specified padding to the rectangle's bounds.
	* @param top 
	* @param left 
	* @param bottom 
	* @param right 
	*/
	public function pad(top:Float, left:Float, bottom:Float, right:Float):Rectangle;
	
	/**
	* Copies all properties from the specified rectangle to this rectangle.
	* @param rectangle The rectangle to copy properties from.
	*/
	public function copy(rectangle:Rectangle):Rectangle;
	
	/**
	* Extends the rectangle's bounds to include the described point or rectangle.
	* @param x X position of the point or rectangle.
	* @param y Y position of the point or rectangle.
	* @param width The width of the rectangle.
	* @param height The height of the rectangle.
	*/
	public function extend(x:Float, y:Float, ?width:Float, ?height:Float):Rectangle;
	
	/**
	* Represents a rectangle as defined by the points (x, y) and (x+width, y+height).
	*	
	*	<h4>Example</h4>
	*	
	*	     var rect = new createjs.Rectangle(0, 0, 100, 100);
	* @param x X position.
	* @param y Y position.
	* @param width The width of the Rectangle.
	* @param height The height of the Rectangle.
	*/
	public function new(?x:Float, ?y:Float, ?width:Float, ?height:Float):Void;
	
	/**
	* Returns a clone of the Rectangle instance.
	*/
	public function clone():Rectangle;
	
	/**
	* Returns a new rectangle which contains this rectangle and the specified rectangle.
	* @param rect The rectangle to calculate a union with.
	*/
	public function union(rect:Rectangle):Rectangle;
	
	/**
	* Returns a new rectangle which describes the intersection (overlap) of this rectangle and the specified rectangle,
	*	or null if they do not intersect.
	* @param rect The rectangle to calculate an intersection with.
	*/
	public function intersection(rect:Rectangle):Rectangle;
	
	/**
	* Returns a string representation of this object.
	*/
	public function toString():String;
	
	/**
	* Returns true if the specified rectangle intersects (has any overlap) with this rectangle.
	* @param rect The rectangle to compare.
	*/
	public function intersects(rect:Rectangle):Bool;
	
	/**
	* Returns true if the width or height are equal or less than 0.
	*/
	public function isEmpty():Bool;
	
	/**
	* Returns true if this rectangle fully encloses the described point or rectangle.
	* @param x X position of the point or rectangle.
	* @param y Y position of the point or rectangle.
	* @param width The width of the rectangle.
	* @param height The height of the rectangle.
	*/
	public function contains(x:Float, y:Float, ?width:Float, ?height:Float):Bool;
	
	/**
	* Sets the specified values on this instance.
	* @param x X position.
	* @param y Y position.
	* @param width The width of the Rectangle.
	* @param height The height of the Rectangle.
	*/
	public function setValues(?x:Float, ?y:Float, ?width:Float, ?height:Float):Rectangle;
	
}
