package createjs.easeljs;

/**
* Represents a point on a 2 dimensional x / y coordinate system.
*	
*	<h4>Example</h4>
*	
*	     var point = new createjs.Point(0, 100);
*/
@:native("createjs.Point")
extern class Point
{
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
	* Copies all properties from the specified point to this point.
	* @param point The point to copy properties from.
	*/
	public function copy(point:Point):Point;
	
	/**
	* Represents a point on a 2 dimensional x / y coordinate system.
	*	
	*	<h4>Example</h4>
	*	
	*	     var point = new createjs.Point(0, 100);
	* @param x X position.
	* @param y Y position.
	*/
	public function new(?x:Float, ?y:Float):Void;
	
	/**
	* Returns a clone of the Point instance.
	*/
	public function clone():Point;
	
	/**
	* Returns a string representation of this object.
	*/
	public function toString():String;
	
	/**
	* Sets the specified values on this instance.
	* @param x X position.
	* @param y Y position.
	*/
	public function setValues(?x:Float, ?y:Float):Point;
	
}
