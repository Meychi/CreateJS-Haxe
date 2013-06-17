package createjs.easeljs;

/**
* Represents a rectangle as defined by the points (x, y) and (x+width, y+height).
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
	* Initialization method.
	*/
	private function initialize():Dynamic;
	
	/**
	* Represents a rectangle as defined by the points (x, y) and (x+width, y+height).
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
	* Returns a string representation of this object.
	*/
	public function toString():String;
}
