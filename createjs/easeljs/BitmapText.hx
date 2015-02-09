package createjs.easeljs;

/**
* Displays text using bitmap glyphs defined in a sprite sheet. Multi-line text is supported
*	using new line characters, but automatic wrapping is not supported. See the 
*	{{#crossLink "BitmapText/spriteSheet:property"}}{{/crossLink}}
*	property for more information on defining glyphs.
*	
*	<strong>Important:</strong> BitmapText extends Container, but is not designed to be used as one.
*	As such, methods like addChild and removeChild are disabled.
*/
@:native("createjs.BitmapText")
extern class BitmapText extends DisplayObject
{
	/**
	* A SpriteSheet instance that defines the glyphs for this bitmap text. Each glyph/character should have a single frame animation defined in the sprite sheet named the same as corresponding character. For example, the following animation definition:  		"A": {frames: [0]}  would indicate that the frame at index 0 of the spritesheet should be drawn for the "A" character. The short form is also acceptable:  		"A": 0  Note that if a character in the text is not found in the sprite sheet, it will also try to use the alternate case (upper or lower).  See SpriteSheet for more information on defining sprite sheet data.
	*/
	public var spriteSheet:SpriteSheet;
	
	/**
	* BitmapText uses Sprite instances to draw text. To reduce the creation and destruction of instances (and thus garbage collection), it maintains an internal object pool of sprite instances to reuse. Increasing this value can cause more sprites to be retained, slightly increasing memory use, but reducing instantiation.
	*/
	public static var maxPoolSize:Float;
	
	/**
	* If a space character is not defined in the sprite sheet, then empty pixels equal to spaceWidth will be inserted instead. If 0, then it will use a value calculated by checking for the width of the "1", "l", "E", or "A" character (in that order). If those characters are not defined, it will use the width of the first frame of the sprite sheet.
	*/
	public var spaceWidth:Float;
	
	/**
	* The height of each line of text. If 0, then it will use a line height calculated by checking for the height of the "1", "T", or "L" character (in that order). If those characters are not defined, it will use the height of the first frame of the sprite sheet.
	*/
	public var lineHeight:Float;
	
	/**
	* The text to display.
	*/
	public var text:String;
	
	/**
	* This spacing (in pixels) will be added after each character in the output.
	*/
	public var letterSpacing:Float;
	
	private var _oldProps:Dynamic;
	
	/**
	* <strong>Disabled in BitmapText.</strong>
	*/
	public function addChild():Dynamic;
	
	/**
	* <strong>Disabled in BitmapText.</strong>
	*/
	public function addChildAt():Dynamic;
	
	/**
	* <strong>Disabled in BitmapText.</strong>
	*/
	public function removeAllChildren():Dynamic;
	
	/**
	* <strong>Disabled in BitmapText.</strong>
	*/
	public function removeChild():Dynamic;
	
	/**
	* <strong>Disabled in BitmapText.</strong>
	*/
	public function removeChildAt():Dynamic;
	
	/**
	* <strong>REMOVED</strong>. Removed in favor of using `MySuperClass_constructor`.
	*	See {{#crossLink "Utility Methods/extend"}}{{/crossLink}} and {{#crossLink "Utility Methods/promote"}}{{/crossLink}}
	*	for details.
	*	
	*	There is an inheritance tutorial distributed with EaselJS in /tutorials/Inheritance.
	*/
	private function initialize():Dynamic;
	
	/**
	* Displays text using bitmap glyphs defined in a sprite sheet. Multi-line text is supported
	*	using new line characters, but automatic wrapping is not supported. See the 
	*	{{#crossLink "BitmapText/spriteSheet:property"}}{{/crossLink}}
	*	property for more information on defining glyphs.
	*	
	*	<strong>Important:</strong> BitmapText extends Container, but is not designed to be used as one.
	*	As such, methods like addChild and removeChild are disabled.
	* @param text The text to display.
	* @param spriteSheet The spritesheet that defines the character glyphs.
	*/
	public function new(?text:String, ?spriteSheet:SpriteSheet):Void;
	
	/**
	* Returns true or false indicating whether the display object would be visible if drawn to a canvas.
	*	This does not account for whether it would be visible within the boundaries of the stage.
	*	NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
	*/
	//public function isVisible():Bool;
	
	//private function _cloneProps(o:BitmapText):BitmapText;
	
	private function _drawText():Dynamic;
	
	private function _getFrame(character:String, spriteSheet:SpriteSheet):Dynamic;
	
	private function _getFrameIndex(character:String, spriteSheet:SpriteSheet):Float;
	
	private function _getLineHeight(ss:SpriteSheet):Float;
	
	private function _getSpaceWidth(ss:SpriteSheet):Float;
	
}
