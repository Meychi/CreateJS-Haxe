package createjs.easeljs;

import createjs.easeljs.graphics.BeginPath;
import createjs.easeljs.graphics.Fill;
import createjs.easeljs.graphics.Stroke;
import createjs.easeljs.graphics.StrokeDash;
import createjs.easeljs.graphics.StrokeStyle;
import js.html.CanvasRenderingContext2D;

/**
* The Graphics class exposes an easy to use API for generating vector drawing instructions and drawing them to a
*	specified context. Note that you can use Graphics without any dependency on the EaselJS framework by calling {{#crossLink "Graphics/draw"}}{{/crossLink}}
*	directly, or it can be used with the {{#crossLink "Shape"}}{{/crossLink}} object to draw vector graphics within the
*	context of an EaselJS display list.
*	
*	There are two approaches to working with Graphics object: calling methods on a Graphics instance (the "Graphics API"), or
*	instantiating Graphics command objects and adding them to the graphics queue via {{#crossLink "Graphics/append"}}{{/crossLink}}.
*	The former abstracts the latter, simplifying beginning and ending paths, fills, and strokes.
*	
*	     var g = new createjs.Graphics();
*	     g.setStrokeStyle(1);
*	     g.beginStroke("#000000");
*	     g.beginFill("red");
*	     g.drawCircle(0,0,30);
*	
*	All drawing methods in Graphics return the Graphics instance, so they can be chained together. For example,
*	the following line of code would generate the instructions to draw a rectangle with a red stroke and blue fill:
*	
*	     myGraphics.beginStroke("red").beginFill("blue").drawRect(20, 20, 100, 50);
*	
*	Each graphics API call generates a command object (see below). The last command to be created can be accessed via
*	{{#crossLink "Graphics/command:property"}}{{/crossLink}}:
*	
*	     var fillCommand = myGraphics.beginFill("red").command;
*	     // ... later, update the fill style/color:
*	     fillCommand.style = "blue";
*	     // or change it to a bitmap fill:
*	     fillCommand.bitmap(myImage);
*	
*	For more direct control of rendering, you can instantiate and append command objects to the graphics queue directly. In this case, you
*	need to manage path creation manually, and ensure that fill/stroke is applied to a defined path:
*	
*	     // start a new path. Graphics.beginCmd is a reusable BeginPath instance:
*	     myGraphics.append(createjs.Graphics.beginCmd);
*	     // we need to define the path before applying the fill:
*	     var circle = new createjs.Graphics.Circle(0,0,30);
*	     myGraphics.append(circle);
*	     // fill the path we just defined:
*	     var fill = new createjs.Graphics.Fill("red");
*	     myGraphics.append(fill);
*	
*	These approaches can be used together, for example to insert a custom command:
*	
*	     myGraphics.beginFill("red");
*	     var customCommand = new CustomSpiralCommand(etc);
*	     myGraphics.append(customCommand);
*	     myGraphics.beginFill("blue");
*	     myGraphics.drawCircle(0, 0, 30);
*	
*	See {{#crossLink "Graphics/append"}}{{/crossLink}} for more info on creating custom commands.
*	
*	<h4>Tiny API</h4>
*	The Graphics class also includes a "tiny API", which is one or two-letter methods that are shortcuts for all of the
*	Graphics methods. These methods are great for creating compact instructions, and is used by the Toolkit for CreateJS
*	to generate readable code. All tiny methods are marked as protected, so you can view them by enabling protected
*	descriptions in the docs.
*	
*	<table>
*	    <tr><td><b>Tiny</b></td><td><b>Method</b></td><td><b>Tiny</b></td><td><b>Method</b></td></tr>
*	    <tr><td>mt</td><td>{{#crossLink "Graphics/moveTo"}}{{/crossLink}} </td>
*	    <td>lt</td> <td>{{#crossLink "Graphics/lineTo"}}{{/crossLink}}</td></tr>
*	    <tr><td>a/at</td><td>{{#crossLink "Graphics/arc"}}{{/crossLink}} / {{#crossLink "Graphics/arcTo"}}{{/crossLink}} </td>
*	    <td>bt</td><td>{{#crossLink "Graphics/bezierCurveTo"}}{{/crossLink}} </td></tr>
*	    <tr><td>qt</td><td>{{#crossLink "Graphics/quadraticCurveTo"}}{{/crossLink}} (also curveTo)</td>
*	    <td>r</td><td>{{#crossLink "Graphics/rect"}}{{/crossLink}} </td></tr>
*	    <tr><td>cp</td><td>{{#crossLink "Graphics/closePath"}}{{/crossLink}} </td>
*	    <td>c</td><td>{{#crossLink "Graphics/clear"}}{{/crossLink}} </td></tr>
*	    <tr><td>f</td><td>{{#crossLink "Graphics/beginFill"}}{{/crossLink}} </td>
*	    <td>lf</td><td>{{#crossLink "Graphics/beginLinearGradientFill"}}{{/crossLink}} </td></tr>
*	    <tr><td>rf</td><td>{{#crossLink "Graphics/beginRadialGradientFill"}}{{/crossLink}} </td>
*	    <td>bf</td><td>{{#crossLink "Graphics/beginBitmapFill"}}{{/crossLink}} </td></tr>
*	    <tr><td>ef</td><td>{{#crossLink "Graphics/endFill"}}{{/crossLink}} </td>
*	    <td>ss / sd</td><td>{{#crossLink "Graphics/setStrokeStyle"}}{{/crossLink}} / {{#crossLink "Graphics/setStrokeDash"}}{{/crossLink}} </td></tr>
*	    <tr><td>s</td><td>{{#crossLink "Graphics/beginStroke"}}{{/crossLink}} </td>
*	    <td>ls</td><td>{{#crossLink "Graphics/beginLinearGradientStroke"}}{{/crossLink}} </td></tr>
*	    <tr><td>rs</td><td>{{#crossLink "Graphics/beginRadialGradientStroke"}}{{/crossLink}} </td>
*	    <td>bs</td><td>{{#crossLink "Graphics/beginBitmapStroke"}}{{/crossLink}} </td></tr>
*	    <tr><td>es</td><td>{{#crossLink "Graphics/endStroke"}}{{/crossLink}} </td>
*	    <td>dr</td><td>{{#crossLink "Graphics/drawRect"}}{{/crossLink}} </td></tr>
*	    <tr><td>rr</td><td>{{#crossLink "Graphics/drawRoundRect"}}{{/crossLink}} </td>
*	    <td>rc</td><td>{{#crossLink "Graphics/drawRoundRectComplex"}}{{/crossLink}} </td></tr>
*	    <tr><td>dc</td><td>{{#crossLink "Graphics/drawCircle"}}{{/crossLink}} </td>
*	    <td>de</td><td>{{#crossLink "Graphics/drawEllipse"}}{{/crossLink}} </td></tr>
*	    <tr><td>dp</td><td>{{#crossLink "Graphics/drawPolyStar"}}{{/crossLink}} </td>
*	    <td>p</td><td>{{#crossLink "Graphics/decodePath"}}{{/crossLink}} </td></tr>
*	</table>
*	
*	Here is the above example, using the tiny API instead.
*	
*	     myGraphics.s("red").f("blue").r(20, 20, 100, 50);
*/
@:native("createjs.Graphics")
extern class Graphics
{
	/**
	* A reusable instance of {{#crossLink "Graphics/BeginPath"}}{{/crossLink}} to avoid unnecessary instantiation.
	*/
	public static var beginCmd:BeginPath;
	
	/**
	* Holds a reference to the last command that was created or appended. For example, you could retain a reference to a Fill command in order to dynamically update the color later by using:  		var myFill = myGraphics.beginFill("red").command; 		// update color later: 		myFill.style = "yellow";
	*/
	public var command:Dynamic;
	
	/**
	* Index to draw from if a store operation has happened.
	*/
	private var _storeIndex:Float;
	
	/**
	* Indicates the last instruction index that was committed.
	*/
	private var _commitIndex:Float;
	
	/**
	* Map of Base64 characters to values. Used by {{#crossLink "Graphics/decodePath"}}{{/crossLink}}.
	*/
	public static var BASE_64:Dynamic;
	
	/**
	* Maps numeric values for the caps parameter of {{#crossLink "Graphics/setStrokeStyle"}}{{/crossLink}} to corresponding string values. This is primarily for use with the tiny API. The mappings are as follows: 0 to "butt", 1 to "round", and 2 to "square". For example, to set the line caps to "square":       myGraphics.ss(16, 2);
	*/
	public static var STROKE_CAPS_MAP:Array<Dynamic>;
	
	/**
	* Maps numeric values for the joints parameter of {{#crossLink "Graphics/setStrokeStyle"}}{{/crossLink}} to corresponding string values. This is primarily for use with the tiny API. The mappings are as follows: 0 to "miter", 1 to "round", and 2 to "bevel". For example, to set the line joints to "bevel":       myGraphics.ss(16, 0, 2);
	*/
	public static var STROKE_JOINTS_MAP:Array<Dynamic>;
	
	/**
	* Returns the graphics instructions array. Each entry is a graphics command object (ex. Graphics.Fill, Graphics.Rect) Modifying the returned array directly is not recommended, and is likely to result in unexpected behaviour.  This property is mainly intended for introspection of the instructions (ex. for graphics export).
	*/
	public var instructions:Array<Dynamic>;
	
	/**
	* This indicates that there have been changes to the activeInstruction list since the last updateInstructions call.
	*/
	private var _dirty:Bool;
	
	/**
	* Uncommitted instructions.
	*/
	private var _activeInstructions:Array<Dynamic>;
	
	private var _fill:Fill;
	
	private var _instructions:Array<Dynamic>;
	
	private var _oldStrokeDash:StrokeDash;
	
	private var _oldStrokeStyle:StrokeStyle;
	
	private var _stroke:Stroke;
	
	private var _strokeDash:StrokeDash;
	
	private var _strokeIgnoreScale:Bool;
	
	private var _strokeStyle:StrokeStyle;
	
	public static var _ctx:CanvasRenderingContext2D;
	
	/**
	* <strong>REMOVED</strong>. Removed in favor of using `MySuperClass_constructor`.
	*	See {{#crossLink "Utility Methods/extend"}}{{/crossLink}} and {{#crossLink "Utility Methods/promote"}}{{/crossLink}}
	*	for details.
	*	
	*	There is an inheritance tutorial distributed with EaselJS in /tutorials/Inheritance.
	*/
	private function initialize():Dynamic;
	
	/**
	* Appends a graphics command object to the graphics queue. Command objects expose an "exec" method
	*	that accepts two parameters: the Context2D to operate on, and an arbitrary data object passed into
	*	{{#crossLink "Graphics/draw"}}{{/crossLink}}. The latter will usually be the Shape instance that called draw.
	*	
	*	This method is used internally by Graphics methods, such as drawCircle, but can also be used directly to insert
	*	built-in or custom graphics commands. For example:
	*	
	*			// attach data to our shape, so we can access it during the draw:
	*			myShape.color = "red";
	*	
	*			// append a Circle command object:
	*			myShape.graphics.append(new createjs.Graphics.Circle(50, 50, 30));
	*	
	*			// append a custom command object with an exec method that sets the fill style
	*			// based on the shape's data, and then fills the circle.
	*			myShape.graphics.append({exec:function(ctx, shape) {
	*				ctx.fillStyle = shape.color;
	*				ctx.fill();
	*			}});
	* @param command A graphics command object exposing an "exec" method.
	* @param clean The clean param is primarily for internal use. A value of true indicates that a command does not generate a path that should be stroked or filled.
	*/
	public function append(command:Dynamic, clean:Bool):Graphics;
	
	/**
	* Begins a fill with the specified color. This ends the current sub-path. A tiny API method "f" also exists.
	* @param color A CSS compatible color value (ex. "red", "#FF0000", or "rgba(255,0,0,0.5)"). Setting to
	*	null will result in no fill.
	*/
	public function beginFill(color:String):Graphics;
	
	/**
	* Begins a linear gradient fill defined by the line (x0, y0) to (x1, y1). This ends the current sub-path. For
	*	example, the following code defines a black to white vertical gradient ranging from 20px to 120px, and draws a
	*	square to display it:
	*	
	*	     myGraphics.beginLinearGradientFill(["#000","#FFF"], [0, 1], 0, 20, 0, 120).drawRect(20, 20, 120, 120);
	*	
	*	A tiny API method "lf" also exists.
	* @param colors An array of CSS compatible color values. For example, ["#F00","#00F"] would define a gradient
	*	drawing from red to blue.
	* @param ratios An array of gradient positions which correspond to the colors. For example, [0.1, 0.9] would draw
	*	the first color to 10% then interpolating to the second color at 90%.
	* @param x0 The position of the first point defining the line that defines the gradient direction and size.
	* @param y0 The position of the first point defining the line that defines the gradient direction and size.
	* @param x1 The position of the second point defining the line that defines the gradient direction and size.
	* @param y1 The position of the second point defining the line that defines the gradient direction and size.
	*/
	public function beginLinearGradientFill(colors:Array<Dynamic>, ratios:Array<Dynamic>, x0:Float, y0:Float, x1:Float, y1:Float):Graphics;
	
	/**
	* Begins a linear gradient stroke defined by the line (x0, y0) to (x1, y1). This ends the current sub-path. For
	*	example, the following code defines a black to white vertical gradient ranging from 20px to 120px, and draws a
	*	square to display it:
	*	
	*	     myGraphics.setStrokeStyle(10).
	*	         beginLinearGradientStroke(["#000","#FFF"], [0, 1], 0, 20, 0, 120).drawRect(20, 20, 120, 120);
	*	
	*	A tiny API method "ls" also exists.
	* @param colors An array of CSS compatible color values. For example, ["#F00","#00F"] would define
	*	a gradient drawing from red to blue.
	* @param ratios An array of gradient positions which correspond to the colors. For example, [0.1,
	*	0.9] would draw the first color to 10% then interpolating to the second color at 90%.
	* @param x0 The position of the first point defining the line that defines the gradient direction and size.
	* @param y0 The position of the first point defining the line that defines the gradient direction and size.
	* @param x1 The position of the second point defining the line that defines the gradient direction and size.
	* @param y1 The position of the second point defining the line that defines the gradient direction and size.
	*/
	public function beginLinearGradientStroke(colors:Array<Dynamic>, ratios:Array<Dynamic>, x0:Float, y0:Float, x1:Float, y1:Float):Graphics;
	
	/**
	* Begins a pattern fill using the specified image. This ends the current sub-path. A tiny API method "bf" also
	*	exists.
	* @param image The Image, Canvas, or Video object to use
	*	as the pattern. Must be loaded prior to creating a bitmap fill, or the fill will be empty.
	* @param repetition Optional. Indicates whether to repeat the image in the fill area. One of "repeat",
	*	"repeat-x", "repeat-y", or "no-repeat". Defaults to "repeat". Note that Firefox does not support "repeat-x" or
	*	"repeat-y" (latest tests were in FF 20.0), and will default to "repeat".
	* @param matrix Optional. Specifies a transformation matrix for the bitmap fill. This transformation
	*	will be applied relative to the parent transform.
	*/
	public function beginBitmapFill(image:Dynamic, ?repetition:String, ?matrix:Matrix2D):Graphics;
	
	/**
	* Begins a pattern fill using the specified image. This ends the current sub-path. Note that unlike bitmap fills,
	*	strokes do not currently support a matrix parameter due to limitations in the canvas API. A tiny API method "bs"
	*	also exists.
	* @param image The Image, Canvas, or Video object to use
	*	as the pattern. Must be loaded prior to creating a bitmap fill, or the fill will be empty.
	* @param repetition Optional. Indicates whether to repeat the image in the fill area. One of
	*	"repeat", "repeat-x", "repeat-y", or "no-repeat". Defaults to "repeat".
	*/
	public function beginBitmapStroke(image:Dynamic, ?repetition:String):Graphics;
	
	/**
	* Begins a radial gradient fill. This ends the current sub-path. For example, the following code defines a red to
	*	blue radial gradient centered at (100, 100), with a radius of 50, and draws a circle to display it:
	*	
	*	     myGraphics.beginRadialGradientFill(["#F00","#00F"], [0, 1], 100, 100, 0, 100, 100, 50).drawCircle(100, 100, 50);
	*	
	*	A tiny API method "rf" also exists.
	* @param colors An array of CSS compatible color values. For example, ["#F00","#00F"] would define
	*	a gradient drawing from red to blue.
	* @param ratios An array of gradient positions which correspond to the colors. For example, [0.1,
	*	0.9] would draw the first color to 10% then interpolating to the second color at 90%.
	* @param x0 Center position of the inner circle that defines the gradient.
	* @param y0 Center position of the inner circle that defines the gradient.
	* @param r0 Radius of the inner circle that defines the gradient.
	* @param x1 Center position of the outer circle that defines the gradient.
	* @param y1 Center position of the outer circle that defines the gradient.
	* @param r1 Radius of the outer circle that defines the gradient.
	*/
	public function beginRadialGradientFill(colors:Array<Dynamic>, ratios:Array<Dynamic>, x0:Float, y0:Float, r0:Float, x1:Float, y1:Float, r1:Float):Graphics;
	
	/**
	* Begins a radial gradient stroke. This ends the current sub-path. For example, the following code defines a red to
	*	blue radial gradient centered at (100, 100), with a radius of 50, and draws a rectangle to display it:
	*	
	*	     myGraphics.setStrokeStyle(10)
	*	         .beginRadialGradientStroke(["#F00","#00F"], [0, 1], 100, 100, 0, 100, 100, 50)
	*	         .drawRect(50, 90, 150, 110);
	*	
	*	A tiny API method "rs" also exists.
	* @param colors An array of CSS compatible color values. For example, ["#F00","#00F"] would define
	*	a gradient drawing from red to blue.
	* @param ratios An array of gradient positions which correspond to the colors. For example, [0.1,
	*	0.9] would draw the first color to 10% then interpolating to the second color at 90%, then draw the second color
	*	to 100%.
	* @param x0 Center position of the inner circle that defines the gradient.
	* @param y0 Center position of the inner circle that defines the gradient.
	* @param r0 Radius of the inner circle that defines the gradient.
	* @param x1 Center position of the outer circle that defines the gradient.
	* @param y1 Center position of the outer circle that defines the gradient.
	* @param r1 Radius of the outer circle that defines the gradient.
	*/
	public function beginRadialGradientStroke(colors:Array<Dynamic>, ratios:Array<Dynamic>, x0:Float, y0:Float, r0:Float, x1:Float, y1:Float, r1:Float):Graphics;
	
	/**
	* Begins a stroke with the specified color. This ends the current sub-path. A tiny API method "s" also exists.
	* @param color A CSS compatible color value (ex. "#FF0000", "red", or "rgba(255,0,0,0.5)"). Setting to
	*	null will result in no stroke.
	*/
	public function beginStroke(color:String):Graphics;
	
	/**
	* Clears all drawing instructions, effectively resetting this Graphics instance. Any line and fill styles will need
	*	to be redefined to draw shapes following a clear call. A tiny API method "c" also exists.
	*/
	public function clear():Graphics;
	
	/**
	* Closes the current path, effectively drawing a line from the current drawing point to the first drawing point specified
	*	since the fill or stroke was last set. A tiny API method "cp" also exists.
	*/
	public function closePath():Graphics;
	
	/**
	* Decodes a compact encoded path string into a series of draw instructions.
	*	This format is not intended to be human readable, and is meant for use by authoring tools.
	*	The format uses a base64 character set, with each character representing 6 bits, to define a series of draw
	*	commands.
	*	
	*	Each command is comprised of a single "header" character followed by a variable number of alternating x and y
	*	position values. Reading the header bits from left to right (most to least significant): bits 1 to 3 specify the
	*	type of operation (0-moveTo, 1-lineTo, 2-quadraticCurveTo, 3-bezierCurveTo, 4-closePath, 5-7 unused). Bit 4
	*	indicates whether position values use 12 bits (2 characters) or 18 bits (3 characters), with a one indicating the
	*	latter. Bits 5 and 6 are currently unused.
	*	
	*	Following the header is a series of 0 (closePath), 2 (moveTo, lineTo), 4 (quadraticCurveTo), or 6 (bezierCurveTo)
	*	parameters. These parameters are alternating x/y positions represented by 2 or 3 characters (as indicated by the
	*	4th bit in the command char). These characters consist of a 1 bit sign (1 is negative, 0 is positive), followed
	*	by an 11 (2 char) or 17 (3 char) bit integer value. All position values are in tenths of a pixel. Except in the
	*	case of move operations which are absolute, this value is a delta from the previous x or y position (as
	*	appropriate).
	*	
	*	For example, the string "A3cAAMAu4AAA" represents a line starting at -150,0 and ending at 150,0.
	*	<br />A - bits 000000. First 3 bits (000) indicate a moveTo operation. 4th bit (0) indicates 2 chars per
	*	parameter.
	*	<br />n0 - 110111011100. Absolute x position of -150.0px. First bit indicates a negative value, remaining bits
	*	indicate 1500 tenths of a pixel.
	*	<br />AA - 000000000000. Absolute y position of 0.
	*	<br />I - 001100. First 3 bits (001) indicate a lineTo operation. 4th bit (1) indicates 3 chars per parameter.
	*	<br />Au4 - 000000101110111000. An x delta of 300.0px, which is added to the previous x value of -150.0px to
	*	provide an absolute position of +150.0px.
	*	<br />AAA - 000000000000000000. A y delta value of 0.
	*	
	*	A tiny API method "p" also exists.
	* @param str The path string to decode.
	*/
	public function decodePath(str:String):Graphics;
	
	/**
	* Draws a bezier curve from the current drawing point to (x, y) using the control points (cp1x, cp1y) and (cp2x,
	*	cp2y). For detailed information, read the
	*	<a href="http://www.whatwg.org/specs/web-apps/current-work/multipage/the-canvas-element.html#dom-context-2d-beziercurveto">
	*	whatwg spec</a>. A tiny API method "bt" also exists.
	* @param cp1x 
	* @param cp1y 
	* @param cp2x 
	* @param cp2y 
	* @param x 
	* @param y 
	*/
	public function bezierCurveTo(cp1x:Float, cp1y:Float, cp2x:Float, cp2y:Float, x:Float, y:Float):Graphics;
	
	/**
	* Draws a circle with the specified radius at (x, y).
	*	
	*	     var g = new createjs.Graphics();
	*		    g.setStrokeStyle(1);
	*		    g.beginStroke(createjs.Graphics.getRGB(0,0,0));
	*		    g.beginFill(createjs.Graphics.getRGB(255,0,0));
	*		    g.drawCircle(0,0,3);
	*	
	*		    var s = new createjs.Shape(g);
	*			s.x = 100;
	*			s.y = 100;
	*	
	*		    stage.addChild(s);
	*		    stage.update();
	*	
	*	A tiny API method "dc" also exists.
	* @param x x coordinate center point of circle.
	* @param y y coordinate center point of circle.
	* @param radius Radius of circle.
	*/
	public function drawCircle(x:Float, y:Float, radius:Float):Graphics;
	
	/**
	* Draws a line from the current drawing point to the specified position, which become the new current drawing
	*	point. Note that you *must* call {{#crossLink "Graphics/moveTo"}}{{/crossLink}} before the first `lineTo()`.
	*	A tiny API method "lt" also exists.
	*	
	*	For detailed information, read the
	*	<a href="http://www.whatwg.org/specs/web-apps/current-work/multipage/the-canvas-element.html#complex-shapes-(paths)">
	*	whatwg spec</a>.
	* @param x The x coordinate the drawing point should draw to.
	* @param y The y coordinate the drawing point should draw to.
	*/
	public function lineTo(x:Float, y:Float):Graphics;
	
	/**
	* Draws a quadratic curve from the current drawing point to (x, y) using the control point (cpx, cpy). For detailed
	*	information, read the <a href="http://www.whatwg.org/specs/web-apps/current-work/multipage/the-canvas-element.html#dom-context-2d-quadraticcurveto">
	*	whatwg spec</a>. A tiny API method "qt" also exists.
	* @param cpx 
	* @param cpy 
	* @param x 
	* @param y 
	*/
	public function quadraticCurveTo(cpx:Float, cpy:Float, x:Float, y:Float):Graphics;
	
	/**
	* Draws a rectangle at (x, y) with the specified width and height using the current fill and/or stroke.
	*	For detailed information, read the
	*	<a href="http://www.whatwg.org/specs/web-apps/current-work/multipage/the-canvas-element.html#dom-context-2d-rect">
	*	whatwg spec</a>. A tiny API method "r" also exists.
	* @param x 
	* @param y 
	* @param w Width of the rectangle
	* @param h Height of the rectangle
	*/
	public function rect(x:Float, y:Float, w:Float, h:Float):Graphics;
	
	/**
	* Draws a rounded rectangle with all corners with the specified radius.
	* @param x 
	* @param y 
	* @param w 
	* @param h 
	* @param radius Corner radius.
	*/
	public function drawRoundRect(x:Float, y:Float, w:Float, h:Float, radius:Float):Graphics;
	
	/**
	* Draws a rounded rectangle with different corner radii. Supports positive and negative corner radii. A tiny API
	*	method "rc" also exists.
	* @param x The horizontal coordinate to draw the round rect.
	* @param y The vertical coordinate to draw the round rect.
	* @param w The width of the round rect.
	* @param h The height of the round rect.
	* @param radiusTL Top left corner radius.
	* @param radiusTR Top right corner radius.
	* @param radiusBR Bottom right corner radius.
	* @param radiusBL Bottom left corner radius.
	*/
	public function drawRoundRectComplex(x:Float, y:Float, w:Float, h:Float, radiusTL:Float, radiusTR:Float, radiusBR:Float, radiusBL:Float):Graphics;
	
	/**
	* Draws a star if pointSize is greater than 0, or a regular polygon if pointSize is 0 with the specified number of
	*	points. For example, the following code will draw a familiar 5 pointed star shape centered at 100, 100 and with a
	*	radius of 50:
	*	
	*	     myGraphics.beginFill("#FF0").drawPolyStar(100, 100, 50, 5, 0.6, -90);
	*	     // Note: -90 makes the first point vertical
	*	
	*	A tiny API method "dp" also exists.
	* @param x Position of the center of the shape.
	* @param y Position of the center of the shape.
	* @param radius The outer radius of the shape.
	* @param sides The number of points on the star or sides on the polygon.
	* @param pointSize The depth or "pointy-ness" of the star points. A pointSize of 0 will draw a regular
	*	polygon (no points), a pointSize of 1 will draw nothing because the points are infinitely pointy.
	* @param angle The angle of the first point / corner. For example a value of 0 will draw the first point
	*	directly to the right of the center.
	*/
	public function drawPolyStar(x:Float, y:Float, radius:Float, sides:Float, pointSize:Float, angle:Float):Graphics;
	
	/**
	* Draws an arc defined by the radius, startAngle and endAngle arguments, centered at the position (x, y). For
	*	example, to draw a full circle with a radius of 20 centered at (100, 100):
	*	
	*	     arc(100, 100, 20, 0, Math.PI*2);
	*	
	*	For detailed information, read the
	*	<a href="http://www.whatwg.org/specs/web-apps/current-work/multipage/the-canvas-element.html#dom-context-2d-arc">whatwg spec</a>.
	*	A tiny API method "a" also exists.
	* @param x 
	* @param y 
	* @param radius 
	* @param startAngle Measured in radians.
	* @param endAngle Measured in radians.
	* @param anticlockwise 
	*/
	public function arc(x:Float, y:Float, radius:Float, startAngle:Float, endAngle:Float, anticlockwise:Bool):Graphics;
	
	/**
	* Draws an arc with the specified control points and radius.  For detailed information, read the
	*	<a href="http://www.whatwg.org/specs/web-apps/current-work/multipage/the-canvas-element.html#dom-context-2d-arcto">
	*	whatwg spec</a>. A tiny API method "at" also exists.
	* @param x1 
	* @param y1 
	* @param x2 
	* @param y2 
	* @param radius 
	*/
	public function arcTo(x1:Float, y1:Float, x2:Float, y2:Float, radius:Float):Graphics;
	
	/**
	* Draws an ellipse (oval) with a specified width (w) and height (h). Similar to {{#crossLink "Graphics/drawCircle"}}{{/crossLink}},
	*	except the width and height can be different. A tiny API method "de" also exists.
	* @param x The left coordinate point of the ellipse. Note that this is different from {{#crossLink "Graphics/drawCircle"}}{{/crossLink}}
	*	which draws from center.
	* @param y The top coordinate point of the ellipse. Note that this is different from {{#crossLink "Graphics/drawCircle"}}{{/crossLink}}
	*	which draws from the center.
	* @param w The height (horizontal diameter) of the ellipse. The horizontal radius will be half of this
	*	number.
	* @param h The width (vertical diameter) of the ellipse. The vertical radius will be half of this number.
	*/
	public function drawEllipse(x:Float, y:Float, w:Float, h:Float):Graphics;
	
	/**
	* Draws only the path described for this Graphics instance, skipping any non-path instructions, including fill and
	*	stroke descriptions. Used for <code>DisplayObject.mask</code> to draw the clipping path, for example.
	*	
	*	NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
	* @param ctx The canvas 2D context object to draw into.
	*/
	public function drawAsPath(ctx:CanvasRenderingContext2D):Dynamic;
	
	/**
	* Draws the display object into the specified context ignoring its visible, alpha, shadow, and transform.
	*	Returns true if the draw was handled (useful for overriding functionality).
	*	
	*	NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
	* @param ctx The canvas 2D context object to draw into.
	* @param data Optional data that is passed to graphics command exec methods. When called from a Shape instance, the shape passes itself as the data parameter. This can be used by custom graphic commands to insert contextual data.
	*/
	public function draw(ctx:CanvasRenderingContext2D, data:Dynamic):Dynamic;
	
	/**
	* Ends the current sub-path, and begins a new one with no fill. Functionally identical to <code>beginFill(null)</code>.
	*	A tiny API method "ef" also exists.
	*/
	public function endFill():Graphics;
	
	/**
	* Ends the current sub-path, and begins a new one with no stroke. Functionally identical to <code>beginStroke(null)</code>.
	*	A tiny API method "es" also exists.
	*/
	public function endStroke():Graphics;
	
	/**
	* Maps the familiar ActionScript <code>curveTo()</code> method to the functionally similar {{#crossLink "Graphics/quadraticCurveTo"}}{{/crossLink}}
	*	method.
	* @param cpx 
	* @param cpy 
	* @param x 
	* @param y 
	*/
	public function curveTo(cpx:Float, cpy:Float, x:Float, y:Float):Graphics;
	
	/**
	* Maps the familiar ActionScript <code>drawRect()</code> method to the functionally similar {{#crossLink "Graphics/rect"}}{{/crossLink}}
	*	 method.
	* @param x 
	* @param y 
	* @param w Width of the rectangle
	* @param h Height of the rectangle
	*/
	public function drawRect(x:Float, y:Float, w:Float, h:Float):Graphics;
	
	/**
	* Moves the drawing point to the specified position. A tiny API method "mt" also exists.
	* @param x The x coordinate the drawing point should move to.
	* @param y The y coordinate the drawing point should move to.
	*/
	public function moveTo(x:Float, y:Float):Graphics;
	
	/**
	* Removed in favour of using custom command objects with {{#crossLink "Graphics/append"}}{{/crossLink}}.
	*/
	public function inject():Dynamic;
	
	/**
	* Returns a clone of this Graphics instance. Note that the individual command objects are not cloned.
	*/
	public function clone():Graphics;
	
	/**
	* Returns a CSS compatible color string based on the specified HSL numeric color values in the format "hsla(360,100,100,1.0)",
	*	or if alpha is null then in the format "hsl(360,100,100)".
	*	
	*	     createjs.Graphics.getHSL(150, 100, 70);
	*	     // Returns "hsl(150,100,70)"
	* @param hue The hue component for the color, between 0 and 360.
	* @param saturation The saturation component for the color, between 0 and 100.
	* @param lightness The lightness component for the color, between 0 and 100.
	* @param alpha The alpha component for the color where 0 is fully transparent and 1 is fully opaque.
	*/
	public static function getHSL(hue:Float, saturation:Float, lightness:Float, ?alpha:Float):String;
	
	/**
	* Returns a CSS compatible color string based on the specified RGB numeric color values in the format
	*	"rgba(255,255,255,1.0)", or if alpha is null then in the format "rgb(255,255,255)". For example,
	*	
	*	     createjs.Graphics.getRGB(50, 100, 150, 0.5);
	*	     // Returns "rgba(50,100,150,0.5)"
	*	
	*	It also supports passing a single hex color value as the first param, and an optional alpha value as the second
	*	param. For example,
	*	
	*	     createjs.Graphics.getRGB(0xFF00FF, 0.2);
	*	     // Returns "rgba(255,0,255,0.2)"
	* @param r The red component for the color, between 0 and 0xFF (255).
	* @param g The green component for the color, between 0 and 0xFF (255).
	* @param b The blue component for the color, between 0 and 0xFF (255).
	* @param alpha The alpha component for the color where 0 is fully transparent and 1 is fully opaque.
	*/
	public static function getRGB(r:Float, g:Float, b:Float, ?alpha:Float):String;
	
	/**
	* Returns a string representation of this object.
	*/
	public function toString():String;
	
	/**
	* Returns true if this Graphics instance has no drawing commands.
	*/
	public function isEmpty():Bool;
	
	/**
	* Sets or clears the stroke dash pattern.
	*	
	*		myGraphics.setStrokeDash([20, 10], 0);
	*	
	*	A tiny API method `sd` also exists.
	* @param segments An array specifying the dash pattern, alternating between line and gap.
	*	For example, `[20,10]` would create a pattern of 20 pixel lines with 10 pixel gaps between them.
	*	Passing null or an empty array will clear the existing stroke dash.
	* @param offset The offset of the dash pattern. For example, you could increment this value to create a "marching ants" effect.
	*/
	public function setStrokeDash(?segments:Array<Dynamic>, ?offset:Float):Graphics;
	
	/**
	* Sets the stroke style. Like all drawing methods, this can be chained, so you can define
	*	the stroke style and color in a single line of code like so:
	*	
	*		myGraphics.setStrokeStyle(8,"round").beginStroke("#F00");
	*	
	*	A tiny API method "ss" also exists.
	* @param thickness The width of the stroke.
	* @param caps Indicates the type of caps to use at the end of lines. One of butt,
	*	round, or square. Defaults to "butt". Also accepts the values 0 (butt), 1 (round), and 2 (square) for use with
	*	the tiny API.
	* @param joints Specifies the type of joints that should be used where two lines meet.
	*	One of bevel, round, or miter. Defaults to "miter". Also accepts the values 0 (miter), 1 (round), and 2 (bevel)
	*	for use with the tiny API.
	* @param miterLimit If joints is set to "miter", then you can specify a miter limit ratio which
	*	controls at what point a mitered joint will be clipped.
	* @param ignoreScale If true, the stroke will be drawn at the specified thickness regardless
	*	of active transformations.
	*/
	public function setStrokeStyle(thickness:Float, ?caps:Dynamic, ?joints:Dynamic, ?miterLimit:Float, ?ignoreScale:Bool):Graphics;
	
	/**
	* Shortcut to arc.
	* @param x 
	* @param y 
	* @param radius 
	* @param startAngle Measured in radians.
	* @param endAngle Measured in radians.
	* @param anticlockwise 
	*/
	private function a(x:Float, y:Float, radius:Float, startAngle:Float, endAngle:Float, anticlockwise:Bool):Graphics;
	
	/**
	* Shortcut to arcTo.
	* @param x1 
	* @param y1 
	* @param x2 
	* @param y2 
	* @param radius 
	*/
	private function at(x1:Float, y1:Float, x2:Float, y2:Float, radius:Float):Graphics;
	
	/**
	* Shortcut to beginBitmapFill.
	* @param image The Image, Canvas, or Video object to use
	*	as the pattern.
	* @param repetition Optional. Indicates whether to repeat the image in the fill area. One of "repeat",
	*	"repeat-x", "repeat-y", or "no-repeat". Defaults to "repeat". Note that Firefox does not support "repeat-x" or
	*	"repeat-y" (latest tests were in FF 20.0), and will default to "repeat".
	* @param matrix Optional. Specifies a transformation matrix for the bitmap fill. This transformation
	*	will be applied relative to the parent transform.
	*/
	private function bf(image:Dynamic, repetition:String, matrix:Matrix2D):Graphics;
	
	/**
	* Shortcut to beginBitmapStroke.
	* @param image The Image, Canvas, or Video object to use
	*	as the pattern.
	* @param repetition Optional. Indicates whether to repeat the image in the fill area. One of
	*	"repeat", "repeat-x", "repeat-y", or "no-repeat". Defaults to "repeat".
	*/
	private function bs(image:Dynamic, ?repetition:String):Graphics;
	
	/**
	* Shortcut to beginFill.
	* @param color A CSS compatible color value (ex. "red", "#FF0000", or "rgba(255,0,0,0.5)"). Setting to
	*	null will result in no fill.
	*/
	private function f(color:String):Graphics;
	
	/**
	* Shortcut to beginLinearGradientFill.
	* @param colors An array of CSS compatible color values. For example, ["#F00","#00F"] would define a gradient
	*	drawing from red to blue.
	* @param ratios An array of gradient positions which correspond to the colors. For example, [0.1, 0.9] would draw
	*	the first color to 10% then interpolating to the second color at 90%.
	* @param x0 The position of the first point defining the line that defines the gradient direction and size.
	* @param y0 The position of the first point defining the line that defines the gradient direction and size.
	* @param x1 The position of the second point defining the line that defines the gradient direction and size.
	* @param y1 The position of the second point defining the line that defines the gradient direction and size.
	*/
	private function lf(colors:Array<Dynamic>, ratios:Array<Dynamic>, x0:Float, y0:Float, x1:Float, y1:Float):Graphics;
	
	/**
	* Shortcut to beginLinearGradientStroke.
	* @param colors An array of CSS compatible color values. For example, ["#F00","#00F"] would define
	*	a gradient drawing from red to blue.
	* @param ratios An array of gradient positions which correspond to the colors. For example, [0.1,
	*	0.9] would draw the first color to 10% then interpolating to the second color at 90%.
	* @param x0 The position of the first point defining the line that defines the gradient direction and size.
	* @param y0 The position of the first point defining the line that defines the gradient direction and size.
	* @param x1 The position of the second point defining the line that defines the gradient direction and size.
	* @param y1 The position of the second point defining the line that defines the gradient direction and size.
	*/
	private function ls(colors:Array<Dynamic>, ratios:Array<Dynamic>, x0:Float, y0:Float, x1:Float, y1:Float):Graphics;
	
	/**
	* Shortcut to beginRadialGradientFill.
	* @param colors An array of CSS compatible color values. For example, ["#F00","#00F"] would define
	*	a gradient drawing from red to blue.
	* @param ratios An array of gradient positions which correspond to the colors. For example, [0.1,
	*	0.9] would draw the first color to 10% then interpolating to the second color at 90%.
	* @param x0 Center position of the inner circle that defines the gradient.
	* @param y0 Center position of the inner circle that defines the gradient.
	* @param r0 Radius of the inner circle that defines the gradient.
	* @param x1 Center position of the outer circle that defines the gradient.
	* @param y1 Center position of the outer circle that defines the gradient.
	* @param r1 Radius of the outer circle that defines the gradient.
	*/
	private function rf(colors:Array<Dynamic>, ratios:Array<Dynamic>, x0:Float, y0:Float, r0:Float, x1:Float, y1:Float, r1:Float):Graphics;
	
	/**
	* Shortcut to beginRadialGradientStroke.
	* @param colors An array of CSS compatible color values. For example, ["#F00","#00F"] would define
	*	a gradient drawing from red to blue.
	* @param ratios An array of gradient positions which correspond to the colors. For example, [0.1,
	*	0.9] would draw the first color to 10% then interpolating to the second color at 90%, then draw the second color
	*	to 100%.
	* @param x0 Center position of the inner circle that defines the gradient.
	* @param y0 Center position of the inner circle that defines the gradient.
	* @param r0 Radius of the inner circle that defines the gradient.
	* @param x1 Center position of the outer circle that defines the gradient.
	* @param y1 Center position of the outer circle that defines the gradient.
	* @param r1 Radius of the outer circle that defines the gradient.
	*/
	private function rs(colors:Array<Dynamic>, ratios:Array<Dynamic>, x0:Float, y0:Float, r0:Float, x1:Float, y1:Float, r1:Float):Graphics;
	
	/**
	* Shortcut to beginStroke.
	* @param color A CSS compatible color value (ex. "#FF0000", "red", or "rgba(255,0,0,0.5)"). Setting to
	*	null will result in no stroke.
	*/
	private function s(color:String):Graphics;
	
	/**
	* Shortcut to bezierCurveTo.
	* @param cp1x 
	* @param cp1y 
	* @param cp2x 
	* @param cp2y 
	* @param x 
	* @param y 
	*/
	private function bt(cp1x:Float, cp1y:Float, cp2x:Float, cp2y:Float, x:Float, y:Float):Graphics;
	
	/**
	* Shortcut to clear.
	*/
	private function c():Graphics;
	
	/**
	* Shortcut to closePath.
	*/
	private function cp():Graphics;
	
	/**
	* Shortcut to decodePath.
	* @param str The path string to decode.
	*/
	private function p(str:String):Graphics;
	
	/**
	* Shortcut to drawCircle.
	* @param x x coordinate center point of circle.
	* @param y y coordinate center point of circle.
	* @param radius Radius of circle.
	*/
	private function dc(x:Float, y:Float, radius:Float):Graphics;
	
	/**
	* Shortcut to drawEllipse.
	* @param x The left coordinate point of the ellipse. Note that this is different from {{#crossLink "Graphics/drawCircle"}}{{/crossLink}}
	*	which draws from center.
	* @param y The top coordinate point of the ellipse. Note that this is different from {{#crossLink "Graphics/drawCircle"}}{{/crossLink}}
	*	which draws from the center.
	* @param w The height (horizontal diameter) of the ellipse. The horizontal radius will be half of this
	*	number.
	* @param h The width (vertical diameter) of the ellipse. The vertical radius will be half of this number.
	*/
	private function de(x:Float, y:Float, w:Float, h:Float):Graphics;
	
	/**
	* Shortcut to drawPolyStar.
	* @param x Position of the center of the shape.
	* @param y Position of the center of the shape.
	* @param radius The outer radius of the shape.
	* @param sides The number of points on the star or sides on the polygon.
	* @param pointSize The depth or "pointy-ness" of the star points. A pointSize of 0 will draw a regular
	*	polygon (no points), a pointSize of 1 will draw nothing because the points are infinitely pointy.
	* @param angle The angle of the first point / corner. For example a value of 0 will draw the first point
	*	directly to the right of the center.
	*/
	private function dp(x:Float, y:Float, radius:Float, sides:Float, pointSize:Float, angle:Float):Graphics;
	
	/**
	* Shortcut to drawRect.
	* @param x 
	* @param y 
	* @param w Width of the rectangle
	* @param h Height of the rectangle
	*/
	private function dr(x:Float, y:Float, w:Float, h:Float):Graphics;
	
	/**
	* Shortcut to drawRoundRect.
	* @param x 
	* @param y 
	* @param w 
	* @param h 
	* @param radius Corner radius.
	*/
	private function rr(x:Float, y:Float, w:Float, h:Float, radius:Float):Graphics;
	
	/**
	* Shortcut to drawRoundRectComplex.
	* @param x The horizontal coordinate to draw the round rect.
	* @param y The vertical coordinate to draw the round rect.
	* @param w The width of the round rect.
	* @param h The height of the round rect.
	* @param radiusTL Top left corner radius.
	* @param radiusTR Top right corner radius.
	* @param radiusBR Bottom right corner radius.
	* @param radiusBL Bottom left corner radius.
	*/
	private function rc(x:Float, y:Float, w:Float, h:Float, radiusTL:Float, radiusTR:Float, radiusBR:Float, radiusBL:Float):Graphics;
	
	/**
	* Shortcut to endFill.
	*/
	private function ef():Graphics;
	
	/**
	* Shortcut to endStroke.
	*/
	private function es():Graphics;
	
	/**
	* Shortcut to lineTo.
	* @param x The x coordinate the drawing point should draw to.
	* @param y The y coordinate the drawing point should draw to.
	*/
	private function lt(x:Float, y:Float):Graphics;
	
	/**
	* Shortcut to moveTo.
	* @param x The x coordinate the drawing point should move to.
	* @param y The y coordinate the drawing point should move to.
	*/
	private function mt(x:Float, y:Float):Graphics;
	
	/**
	* Shortcut to quadraticCurveTo / curveTo.
	* @param cpx 
	* @param cpy 
	* @param x 
	* @param y 
	*/
	private function qt(cpx:Float, cpy:Float, x:Float, y:Float):Dynamic;
	
	/**
	* Shortcut to rect.
	* @param x 
	* @param y 
	* @param w Width of the rectangle
	* @param h Height of the rectangle
	*/
	private function r(x:Float, y:Float, w:Float, h:Float):Graphics;
	
	/**
	* Shortcut to setStrokeDash.
	* @param segments An array specifying the dash pattern, alternating between line and gap.
	*	For example, [20,10] would create a pattern of 20 pixel lines with 10 pixel gaps between them.
	*	Passing null or an empty array will clear any existing dash.
	* @param offset The offset of the dash pattern. For example, you could increment this value to create a "marching ants" effect.
	*/
	private function sd(?segments:Array<Dynamic>, ?offset:Float):Graphics;
	
	/**
	* Shortcut to setStrokeStyle.
	* @param thickness The width of the stroke.
	* @param caps Indicates the type of caps to use at the end of lines. One of butt,
	*	round, or square. Defaults to "butt". Also accepts the values 0 (butt), 1 (round), and 2 (square) for use with
	*	the tiny API.
	* @param joints Specifies the type of joints that should be used where two lines meet.
	*	One of bevel, round, or miter. Defaults to "miter". Also accepts the values 0 (miter), 1 (round), and 2 (bevel)
	*	for use with the tiny API.
	* @param miterLimit If joints is set to "miter", then you can specify a miter limit ratio which
	*	controls at what point a mitered joint will be clipped.
	* @param ignoreScale If true, the stroke will be drawn at the specified thickness regardless
	*	of active transformations.
	*/
	private function ss(thickness:Float, ?caps:Dynamic, ?joints:Dynamic, ?miterLimit:Float, ?ignoreScale:Bool):Graphics;
	
	/**
	* Stores all graphics commands so they won't be executed in future draws. Calling store() a second time adds to
	*	the existing store. This also affects `drawAsPath()`.
	*	
	*	This is useful in cases where you are creating vector graphics in an iterative manner (ex. generative art), so
	*	that only new graphics need to be drawn (which can provide huge performance benefits), but you wish to retain all
	*	of the vector instructions for later use (ex. scaling, modifying, or exporting).
	*	
	*	Note that calling store() will force the active path (if any) to be ended in a manner similar to changing
	*	the fill or stroke.
	*	
	*	For example, consider a application where the user draws lines with the mouse. As each line segment (or collection of
	*	segments) are added to a Shape, it can be rasterized using {{#crossLink "DisplayObject/updateCache"}}{{/crossLink}},
	*	and then stored, so that it can be redrawn at a different scale when the application is resized, or exported to SVG.
	*	
	*		// set up cache:
	*		myShape.cache(0,0,500,500,scale);
	*	
	*		// when the user drags, draw a new line:
	*		myShape.graphics.moveTo(oldX,oldY).lineTo(newX,newY);
	*		// then draw it into the existing cache:
	*		myShape.updateCache("source-over");
	*		// store the new line, so it isn't redrawn next time:
	*		myShape.store();
	*	
	*		// then, when the window resizes, we can re-render at a different scale:
	*		// first, unstore all our lines:
	*		myShape.unstore();
	*		// then cache using the new scale:
	*		myShape.cache(0,0,500,500,newScale);
	*		// finally, store the existing commands again:
	*		myShape.store();
	*/
	public function store():Graphics;
	
	/**
	* The Graphics class exposes an easy to use API for generating vector drawing instructions and drawing them to a
	*	specified context. Note that you can use Graphics without any dependency on the EaselJS framework by calling {{#crossLink "Graphics/draw"}}{{/crossLink}}
	*	directly, or it can be used with the {{#crossLink "Shape"}}{{/crossLink}} object to draw vector graphics within the
	*	context of an EaselJS display list.
	*	
	*	There are two approaches to working with Graphics object: calling methods on a Graphics instance (the "Graphics API"), or
	*	instantiating Graphics command objects and adding them to the graphics queue via {{#crossLink "Graphics/append"}}{{/crossLink}}.
	*	The former abstracts the latter, simplifying beginning and ending paths, fills, and strokes.
	*	
	*	     var g = new createjs.Graphics();
	*	     g.setStrokeStyle(1);
	*	     g.beginStroke("#000000");
	*	     g.beginFill("red");
	*	     g.drawCircle(0,0,30);
	*	
	*	All drawing methods in Graphics return the Graphics instance, so they can be chained together. For example,
	*	the following line of code would generate the instructions to draw a rectangle with a red stroke and blue fill:
	*	
	*	     myGraphics.beginStroke("red").beginFill("blue").drawRect(20, 20, 100, 50);
	*	
	*	Each graphics API call generates a command object (see below). The last command to be created can be accessed via
	*	{{#crossLink "Graphics/command:property"}}{{/crossLink}}:
	*	
	*	     var fillCommand = myGraphics.beginFill("red").command;
	*	     // ... later, update the fill style/color:
	*	     fillCommand.style = "blue";
	*	     // or change it to a bitmap fill:
	*	     fillCommand.bitmap(myImage);
	*	
	*	For more direct control of rendering, you can instantiate and append command objects to the graphics queue directly. In this case, you
	*	need to manage path creation manually, and ensure that fill/stroke is applied to a defined path:
	*	
	*	     // start a new path. Graphics.beginCmd is a reusable BeginPath instance:
	*	     myGraphics.append(createjs.Graphics.beginCmd);
	*	     // we need to define the path before applying the fill:
	*	     var circle = new createjs.Graphics.Circle(0,0,30);
	*	     myGraphics.append(circle);
	*	     // fill the path we just defined:
	*	     var fill = new createjs.Graphics.Fill("red");
	*	     myGraphics.append(fill);
	*	
	*	These approaches can be used together, for example to insert a custom command:
	*	
	*	     myGraphics.beginFill("red");
	*	     var customCommand = new CustomSpiralCommand(etc);
	*	     myGraphics.append(customCommand);
	*	     myGraphics.beginFill("blue");
	*	     myGraphics.drawCircle(0, 0, 30);
	*	
	*	See {{#crossLink "Graphics/append"}}{{/crossLink}} for more info on creating custom commands.
	*	
	*	<h4>Tiny API</h4>
	*	The Graphics class also includes a "tiny API", which is one or two-letter methods that are shortcuts for all of the
	*	Graphics methods. These methods are great for creating compact instructions, and is used by the Toolkit for CreateJS
	*	to generate readable code. All tiny methods are marked as protected, so you can view them by enabling protected
	*	descriptions in the docs.
	*	
	*	<table>
	*	    <tr><td><b>Tiny</b></td><td><b>Method</b></td><td><b>Tiny</b></td><td><b>Method</b></td></tr>
	*	    <tr><td>mt</td><td>{{#crossLink "Graphics/moveTo"}}{{/crossLink}} </td>
	*	    <td>lt</td> <td>{{#crossLink "Graphics/lineTo"}}{{/crossLink}}</td></tr>
	*	    <tr><td>a/at</td><td>{{#crossLink "Graphics/arc"}}{{/crossLink}} / {{#crossLink "Graphics/arcTo"}}{{/crossLink}} </td>
	*	    <td>bt</td><td>{{#crossLink "Graphics/bezierCurveTo"}}{{/crossLink}} </td></tr>
	*	    <tr><td>qt</td><td>{{#crossLink "Graphics/quadraticCurveTo"}}{{/crossLink}} (also curveTo)</td>
	*	    <td>r</td><td>{{#crossLink "Graphics/rect"}}{{/crossLink}} </td></tr>
	*	    <tr><td>cp</td><td>{{#crossLink "Graphics/closePath"}}{{/crossLink}} </td>
	*	    <td>c</td><td>{{#crossLink "Graphics/clear"}}{{/crossLink}} </td></tr>
	*	    <tr><td>f</td><td>{{#crossLink "Graphics/beginFill"}}{{/crossLink}} </td>
	*	    <td>lf</td><td>{{#crossLink "Graphics/beginLinearGradientFill"}}{{/crossLink}} </td></tr>
	*	    <tr><td>rf</td><td>{{#crossLink "Graphics/beginRadialGradientFill"}}{{/crossLink}} </td>
	*	    <td>bf</td><td>{{#crossLink "Graphics/beginBitmapFill"}}{{/crossLink}} </td></tr>
	*	    <tr><td>ef</td><td>{{#crossLink "Graphics/endFill"}}{{/crossLink}} </td>
	*	    <td>ss / sd</td><td>{{#crossLink "Graphics/setStrokeStyle"}}{{/crossLink}} / {{#crossLink "Graphics/setStrokeDash"}}{{/crossLink}} </td></tr>
	*	    <tr><td>s</td><td>{{#crossLink "Graphics/beginStroke"}}{{/crossLink}} </td>
	*	    <td>ls</td><td>{{#crossLink "Graphics/beginLinearGradientStroke"}}{{/crossLink}} </td></tr>
	*	    <tr><td>rs</td><td>{{#crossLink "Graphics/beginRadialGradientStroke"}}{{/crossLink}} </td>
	*	    <td>bs</td><td>{{#crossLink "Graphics/beginBitmapStroke"}}{{/crossLink}} </td></tr>
	*	    <tr><td>es</td><td>{{#crossLink "Graphics/endStroke"}}{{/crossLink}} </td>
	*	    <td>dr</td><td>{{#crossLink "Graphics/drawRect"}}{{/crossLink}} </td></tr>
	*	    <tr><td>rr</td><td>{{#crossLink "Graphics/drawRoundRect"}}{{/crossLink}} </td>
	*	    <td>rc</td><td>{{#crossLink "Graphics/drawRoundRectComplex"}}{{/crossLink}} </td></tr>
	*	    <tr><td>dc</td><td>{{#crossLink "Graphics/drawCircle"}}{{/crossLink}} </td>
	*	    <td>de</td><td>{{#crossLink "Graphics/drawEllipse"}}{{/crossLink}} </td></tr>
	*	    <tr><td>dp</td><td>{{#crossLink "Graphics/drawPolyStar"}}{{/crossLink}} </td>
	*	    <td>p</td><td>{{#crossLink "Graphics/decodePath"}}{{/crossLink}} </td></tr>
	*	</table>
	*	
	*	Here is the above example, using the tiny API instead.
	*	
	*	     myGraphics.s("red").f("blue").r(20, 20, 100, 50);
	*/
	public function new():Void;
	
	/**
	* Unstores any graphics commands that were previously stored using {{#crossLink "Graphics/store"}}{{/crossLink}}
	*	so that they will be executed in subsequent draw calls.
	*/
	public function unstore():Graphics;
	
	/**
	* Use the {{#crossLink "Graphics/instructions:property"}}{{/crossLink}} property instead.
	*/
	public function getInstructions():Array<Dynamic>;
	
	private function _setFill(fill:Dynamic):Dynamic;
	
	private function _setStroke(stroke:Dynamic):Dynamic;
	
	private function _updateInstructions(commit:Dynamic):Dynamic;
	
}
