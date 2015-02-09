package createjs.easeljs;

import js.html.CanvasRenderingContext2D;
import js.html.Text;

/**
* Display one or more lines of dynamic text (not user editable) in the display list. Line wrapping support (using the
*	lineWidth) is very basic, wrapping on spaces and tabs only. Note that as an alternative to Text, you can position HTML
*	text above or below the canvas relative to items in the display list using the {{#crossLink "DisplayObject/localToGlobal"}}{{/crossLink}}
*	method, or using {{#crossLink "DOMElement"}}{{/crossLink}}.
*	
*	<b>Please note that Text does not support HTML text, and can only display one font style at a time.</b> To use
*	multiple font styles, you will need to create multiple text instances, and position them manually.
*	
*	<h4>Example</h4>
*	
*	     var text = new createjs.Text("Hello World", "20px Arial", "#ff7700");
*	     text.x = 100;
*	     text.textBaseline = "alphabetic";
*	
*	CreateJS Text supports web fonts (the same rules as Canvas). The font must be loaded and supported by the browser
*	before it can be displayed.
*	
*	<strong>Note:</strong> Text can be expensive to generate, so cache instances where possible. Be aware that not all
*	browsers will render Text exactly the same.
*/
@:native("createjs.Text")
extern class Text extends DisplayObject
{
	/**
	* If greater than 0, the text will be drawn as a stroke (outline) of the specified width.
	*/
	public var outline:Float;
	
	/**
	* Indicates the line height (vertical distance between baselines) for multi-line text. If null or 0, the value of getMeasuredLineHeight is used.
	*/
	public var lineHeight:Float;
	
	/**
	* Indicates the maximum width for a line of text before it is wrapped to multiple lines. If null, the text will not be wrapped.
	*/
	public var lineWidth:Float;
	
	/**
	* Lookup table for the ratio to offset bounds y calculations based on the textBaseline property.
	*/
	public static var H_OFFSETS:Dynamic;
	
	/**
	* The color to draw the text in. Any valid value for the CSS color attribute is acceptable (ex. "#F00"). Default is "#000". It will also accept valid canvas fillStyle values.
	*/
	public var color:String;
	
	/**
	* The font style to use. Any valid value for the CSS font attribute is acceptable (ex. "bold 36px Arial").
	*/
	public var font:String;
	
	/**
	* The horizontal text alignment. Any of "start", "end", "left", "right", and "center". For detailed information view the <a href="http://www.whatwg.org/specs/web-apps/current-work/multipage/the-canvas-element.html#text-styles"> whatwg spec</a>. Default is "left".
	*/
	public var textAlign:String;
	
	/**
	* The maximum width to draw the text. If maxWidth is specified (not null), the text will be condensed or shrunk to make it fit in this width. For detailed information view the <a href="http://www.whatwg.org/specs/web-apps/current-work/multipage/the-canvas-element.html#text-styles"> whatwg spec</a>.
	*/
	public var maxWidth:Float;
	
	/**
	* The text to display.
	*/
	public var text:String;
	
	/**
	* The vertical alignment point on the font. Any of "top", "hanging", "middle", "alphabetic", "ideographic", or "bottom". For detailed information view the <a href="http://www.whatwg.org/specs/web-apps/current-work/multipage/the-canvas-element.html#text-styles"> whatwg spec</a>. Default is "top".
	*/
	public var textBaseline:String;
	
	private var _workingContext:CanvasRenderingContext2D;
	
	/**
	* Display one or more lines of dynamic text (not user editable) in the display list. Line wrapping support (using the
	*	lineWidth) is very basic, wrapping on spaces and tabs only. Note that as an alternative to Text, you can position HTML
	*	text above or below the canvas relative to items in the display list using the {{#crossLink "DisplayObject/localToGlobal"}}{{/crossLink}}
	*	method, or using {{#crossLink "DOMElement"}}{{/crossLink}}.
	*	
	*	<b>Please note that Text does not support HTML text, and can only display one font style at a time.</b> To use
	*	multiple font styles, you will need to create multiple text instances, and position them manually.
	*	
	*	<h4>Example</h4>
	*	
	*	     var text = new createjs.Text("Hello World", "20px Arial", "#ff7700");
	*	     text.x = 100;
	*	     text.textBaseline = "alphabetic";
	*	
	*	CreateJS Text supports web fonts (the same rules as Canvas). The font must be loaded and supported by the browser
	*	before it can be displayed.
	*	
	*	<strong>Note:</strong> Text can be expensive to generate, so cache instances where possible. Be aware that not all
	*	browsers will render Text exactly the same.
	* @param text The text to display.
	* @param font The font style to use. Any valid value for the CSS font attribute is acceptable (ex. "bold
	*	36px Arial").
	* @param color The color to draw the text in. Any valid value for the CSS color attribute is acceptable (ex.
	*	"#F00", "red", or "#FF0000").
	*/
	public function new(?text:String, ?font:String, ?color:String):Void;
	
	/**
	* Draws multiline text.
	* @param ctx 
	* @param o 
	* @param lines 
	*/
	private function _drawText(ctx:CanvasRenderingContext2D, o:Dynamic, lines:Array<Dynamic>):Dynamic;
	
	/**
	* Draws the Text into the specified context ignoring its visible, alpha, shadow, and transform.
	*	Returns true if the draw was handled (useful for overriding functionality).
	*	NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
	* @param ctx The canvas 2D context object to draw into.
	* @param ignoreCache Indicates whether the draw operation should ignore any current cache.
	*	For example, used for drawing the cache (to prevent it from simply drawing an existing cache back
	*	into itself).
	*/
	//public function draw(ctx:CanvasRenderingContext2D, ignoreCache:Bool):Dynamic;
	
	/**
	* Returns a clone of the Text instance.
	*/
	//public function clone():Text;
	
	/**
	* Returns a string representation of this object.
	*/
	//public function toString():String;
	
	/**
	* Returns an approximate line height of the text, ignoring the lineHeight property. This is based on the measured
	*	width of a "M" character multiplied by 1.2, which provides an approximate line height for most fonts.
	*/
	public function getMeasuredLineHeight():Float;
	
	/**
	* Returns an object with width, height, and lines properties. The width and height are the visual width and height
	*	of the drawn text. The lines property contains an array of strings, one for
	*	each line of text that will be drawn, accounting for line breaks and wrapping. These strings have trailing
	*	whitespace removed.
	*/
	public function getMetrics():Dynamic;
	
	/**
	* Returns the approximate height of multi-line text by multiplying the number of lines against either the
	*	<code>lineHeight</code> (if specified) or {{#crossLink "Text/getMeasuredLineHeight"}}{{/crossLink}}. Note that
	*	this operation requires the text flowing logic to run, which has an associated CPU cost.
	*/
	public function getMeasuredHeight():Float;
	
	/**
	* Returns the measured, untransformed width of the text without wrapping. Use getBounds for a more robust value.
	*/
	public function getMeasuredWidth():Float;
	
	/**
	* Returns true or false indicating whether the display object would be visible if drawn to a canvas.
	*	This does not account for whether it would be visible within the boundaries of the stage.
	*	NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
	*/
	//public function isVisible():Bool;
	
	//private function _cloneProps(o:Text):Text;
	
	private function _drawTextLine(ctx:CanvasRenderingContext2D, text:String, y:Float):Dynamic;
	
	private function _getMeasuredWidth(text:String):Dynamic;
	
	private function _getWorkingContext(ctx:CanvasRenderingContext2D):CanvasRenderingContext2D;
	
}
