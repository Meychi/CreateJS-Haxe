package createjs.easeljs;

import js.html.Point;

/**
* Represents a point on a 2 dimensional x / y coordinate system.
*	
*	<h4>Example</h4>
*	     var point = new Point(0, 100);
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
	* Initialization method.
	*/
	private function initialize():Dynamic;
	
	/**
	* Represents a point on a 2 dimensional x / y coordinate system.
	*	
	*	<h4>Example</h4>
	*	     var point = new Point(0, 100);
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
	
}
