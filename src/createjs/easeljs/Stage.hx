package createjs.easeljs;

import js.html.Element;
import js.html.Event;

/**
* A stage is the root level {{#crossLink "Container"}}{{/crossLink}} for a display list. Each time its {{#crossLink "Stage/tick"}}{{/crossLink}}
*	method is called, it will render its display list to its target canvas.
*	
*	<h4>Example</h4>
*	This example creates a stage, adds a child to it, then uses {{#crossLink "Ticker"}}{{/crossLink}} to update the child
*	and redraw the stage using {{#crossLink "Stage/update"}}{{/crossLink}}.
*	
*	     var stage = new createjs.Stage("canvasElementId");
*	     var image = new createjs.Bitmap("imagePath.png");
*	     stage.addChild(image);
*	     createjs.Ticker.addEventListener("tick", handleTick);
*	     function handleTick(event) {
*	         image.x += 10;
*	         stage.update();
*	     }
*/
@:native("createjs.Stage")
extern class Stage extends Container
{	
	/**
	* Calls the {{#crossLink "Stage/update"}}{{/crossLink}} method. Useful for adding stage as a listener to {{#crossLink "Ticker"}}{{/crossLink}} directly.
	*/
	public var tick:Dynamic;
	
	/**
	* Default event handler that calls the Stage {{#crossLink "Stage/update"}}{{/crossLink}} method when a "tick" event is received. This allows you to register a Stage instance as a event listener on {{#crossLink "Ticker"}}{{/crossLink}} directly, using:       Ticker.addEventListener("tick", myStage");  Note that if you subscribe to ticks using this pattern, then the tick event object will be passed through to display object tick handlers, instead of <code>delta</code> and <code>paused</code> parameters.
	*/
	public var handleEvent:Dynamic;
	
	/**
	* Holds objects with data for each active pointer id. Each object has the following properties: x, y, event, target, overTarget, overX, overY, inBounds
	*/
	private var _pointerData:Dynamic;
	
	/**
	* If true, mouse move events will continue to be called when the mouse leaves the target canvas. See mouseInBounds, and MouseEvent.x/y/rawX/rawY.
	*/
	public var mouseMoveOutside:Bool;
	
	/**
	* If true, tick callbacks will be called on all display objects on the stage prior to rendering to the canvas. You can call
	*/
	public var tickOnUpdate:Bool;
	
	/**
	* Indicates whether the mouse is currently within the bounds of the canvas.
	*/
	public var mouseInBounds:Bool;
	
	/**
	* Indicates whether the stage should automatically clear the canvas before each render. You can set this to <code>false</code> to manually control clearing (for generative art, or when pointing multiple stages at the same canvas for example).  <h4>Example</h4>       var stage = new createjs.Stage("canvasId");      stage.autoClear = false;
	*/
	public var autoClear:Bool;
	
	/**
	* Indicates whether this stage should use the snapToPixel property of display objects when rendering them. See DisplayObject.snapToPixel for more information.
	*/
	public var snapToPixelEnabled:Bool;
	
	/**
	* Number of active pointers.
	*/
	private var _pointerCount:Dynamic;
	
	/**
	* READ-ONLY. The current mouse X position on the canvas. If the mouse leaves the canvas, this will indicate the most recent position over the canvas, and mouseInBounds will be set to false.
	*/
	public var mouseX:Float;
	
	/**
	* READ-ONLY. The current mouse Y position on the canvas. If the mouse leaves the canvas, this will indicate the most recent position over the canvas, and mouseInBounds will be set to false.
	*/
	public var mouseY:Float;
	
	/**
	* The canvas the stage will render to. Multiple stages can share a single canvas, but you must disable autoClear for all but the first stage that will be ticked (or they will clear each other's render).  When changing the canvas property you must disable the events on the old canvas, and enable events on the new canvas or mouse events will not work as expected. For example:       myStage.enableDOMEvents(false);      myStage.canvas = anotherCanvas;      myStage.enableDOMEvents(true);
	*/
	public var canvas:Dynamic;
	
	/**
	* The onMouseDown callback is called when the user presses the mouse button over the canvas.  The handler is passed a single param containing the corresponding MouseEvent instance.
	*/
	public var onMouseDown:Dynamic;
	
	/**
	* The onMouseMove callback is called when the user moves the mouse over the canvas.  The handler is passed a single param containing the corresponding MouseEvent instance.
	*/
	public var onMouseMove:Dynamic;
	
	/**
	* The onMouseUp callback is called when the user releases the mouse button anywhere that the page can detect it.  The handler is passed a single param containing the corresponding MouseEvent instance.
	*/
	public var onMouseUp:Dynamic;
	private var _mouseOverIntervalID:Float;
	public static var _snapToPixelEnabled:Bool;
	
	/**
	* A stage is the root level {{#crossLink "Container"}}{{/crossLink}} for a display list. Each time its {{#crossLink "Stage/tick"}}{{/crossLink}}
	*	method is called, it will render its display list to its target canvas.
	*	
	*	<h4>Example</h4>
	*	This example creates a stage, adds a child to it, then uses {{#crossLink "Ticker"}}{{/crossLink}} to update the child
	*	and redraw the stage using {{#crossLink "Stage/update"}}{{/crossLink}}.
	*	
	*	     var stage = new createjs.Stage("canvasElementId");
	*	     var image = new createjs.Bitmap("imagePath.png");
	*	     stage.addChild(image);
	*	     createjs.Ticker.addEventListener("tick", handleTick);
	*	     function handleTick(event) {
	*	         image.x += 10;
	*	         stage.update();
	*	     }
	* @param canvas A canvas object that the Stage will render to, or the string id
	*	of a canvas object in the current document.
	*/
	public function new(canvas:Dynamic):Void;
	
	/**
	* Clears the target canvas. Useful if <code>autoClear</code> is set to false.
	*/
	public function clear():Dynamic;
	
	/**
	* Each time the update method is called, the stage will tick any descendants exposing a tick method (ex. {{#crossLink "BitmapAnimation"}}{{/crossLink}})
	*	and render its entire display list to the canvas. Any parameters passed to update will be passed on to any
	*	<code>tick</code> event handlers.
	*/
	public function update():Dynamic;
	
	/**
	* Enables or disables (by passing a frequency of 0) mouse over events (mouseover and mouseout) for this stage's
	*	display list. These events can be expensive to generate, so they are disabled by default. The frequency of
	*	the events can be controlled independently of mouse move events via the optional <code>frequency</code> parameter.
	*	
	*	<h4>Example</h4>
	*	     var stage = new createjs.Stage("canvasId");
	*	     stage.enableMouseOver(10);
	* @param frequency Optional param specifying the maximum number of times per second to broadcast
	*	mouse over/out events. Set to 0 to disable mouse over events completely. Maximum is 50. A lower frequency is less
	*	responsive, but uses less CPU.
	*/
	public function enableMouseOver(?frequency:Float):Dynamic;
	
	/**
	* Enables or disables the event listeners that stage adds to DOM elements (window, document and canvas).
	*	It is good practice to disable events when disposing of a Stage instance, otherwise the stage will
	*	continue to receive events from the page.
	*	
	*	When changing the canvas property you must disable the events on the old canvas, and enable events on the
	*	new canvas or mouse events will not work as expected. For example:
	*	
	*	     myStage.enableDOMEvents(false);
	*	     myStage.canvas = anotherCanvas;
	*	     myStage.enableDOMEvents(true);
	* @param enable Indicates whether to enable or disable the events. Default is true.
	*/
	public function enableDOMEvents(?enable:Bool):Dynamic;
	
	/**
	* Initialization method.
	* @param canvas A canvas object, or the string id of a canvas object in the current document.
	*/
	//private function initialize(canvas:Dynamic):Dynamic;
	
	/**
	* Returns a data url that contains a Base64-encoded image of the contents of the stage. The returned data url can
	*	be specified as the src value of an image element.
	* @param backgroundColor The background color to be used for the generated image. The value can be any value HTML color
	*	value, including HEX colors, rgb and rgba. The default value is a transparent background.
	* @param mimeType The MIME type of the image format to be create. The default is "image/png". If an unknown MIME type
	*	is passed in, or if the browser does not support the specified MIME type, the default value will be used.
	*/
	public function toDataURL(backgroundColor:String, mimeType:String):String;
	
	/**
	* Returns a string representation of this object.
	*/
	//public function toString():String;
	private function _getElementRect(e:Element):Dynamic;
	private function _getPointerData(id:Float):Dynamic;
	private function _handleDoubleClick(e:MouseEvent):Dynamic;
	private function _handleMouseDown(e:MouseEvent):Dynamic;
	private function _handleMouseMove(e:MouseEvent):Dynamic;
	private function _handleMouseUp(e:MouseEvent):Dynamic;
	private function _handlePointerDown(id:Float, e:Event, x:Float, y:Float):Dynamic;
	private function _handlePointerMove(id:Float, e:Event, pageX:Float, pageY:Float):Dynamic;
	private function _handlePointerUp(id:Float, e:Event, clear:Bool):Dynamic;
	private function _testMouseOver():Dynamic;
	private function _updatePointerPosition(id:Float, pageX:Float, pageY:Float):Dynamic;
}
