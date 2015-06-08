package createjs.easeljs;

/**
* This class encapsulates the properties required to define a shadow to apply to a {{#crossLink "DisplayObject"}}{{/crossLink}}
*	via its <code>shadow</code> property.
*	
*	<h4>Example</h4>
*	
*	     myImage.shadow = new createjs.Shadow("#000000", 5, 5, 10);
*/
@:native("createjs.Shadow")
extern class Shadow
{
	/**
	* An identity shadow object (all properties are set to 0).
	*/
	public static var identity:Shadow;
	
	/**
	* The color of the shadow. This can be any valid CSS color value.
	*/
	public var color:String;
	
	public var blur:Float;
	
	public var offsetX:Float;
	
	public var offsetY:Float;
	
	/**
	* <strong>REMOVED</strong>. Removed in favor of using `MySuperClass_constructor`.
	*	See {{#crossLink "Utility Methods/extend"}}{{/crossLink}} and {{#crossLink "Utility Methods/promote"}}{{/crossLink}}
	*	for details.
	*	
	*	There is an inheritance tutorial distributed with EaselJS in /tutorials/Inheritance.
	*/
	private function initialize():Dynamic;
	
	/**
	* Returns a clone of this Shadow instance.
	*/
	public function clone():Shadow;
	
	/**
	* Returns a string representation of this object.
	*/
	public function toString():String;
	
	/**
	* This class encapsulates the properties required to define a shadow to apply to a {{#crossLink "DisplayObject"}}{{/crossLink}}
	*	via its <code>shadow</code> property.
	*	
	*	<h4>Example</h4>
	*	
	*	     myImage.shadow = new createjs.Shadow("#000000", 5, 5, 10);
	* @param color The color of the shadow. This can be any valid CSS color value.
	* @param offsetX The x offset of the shadow in pixels.
	* @param offsetY The y offset of the shadow in pixels.
	* @param blur The size of the blurring effect.
	*/
	public function new(color:String, offsetX:Float, offsetY:Float, blur:Float):Void;
	
}
