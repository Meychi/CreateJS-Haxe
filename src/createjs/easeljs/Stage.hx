package createjs.easeljs;

import js.html.Element;
import js.html.Event;
import js.html.MouseEvent;

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
	* Default event handler that calls the Stage {{#crossLink "Stage/update"}}{{/crossLink}} method when a {{#crossLink "DisplayObject/tick:event"}}{{/crossLink}} event is received. This allows you to register a Stage instance as a event listener on {{#crossLink "Ticker"}}{{/crossLink}} directly, using:       Ticker.addEventListener("tick", myStage");  Note that if you subscribe to ticks using this pattern, then the tick event object will be passed through to display object tick handlers, instead of <code>delta</code> and <code>paused</code> parameters.
	*/
	public var handleEvent:Dynamic;
	
	/**
	* Holds objects with data for each active pointer id. Each object has the following properties: x, y, event, target, overTarget, overX, overY, inBounds, posEvtObj (native event that last updated position)
	*/
	private var _pointerData:Dynamic;
	
	/**
	* If true, mouse move events will continue to be called when the mouse leaves the target canvas. See {{#crossLink "Stage/mouseInBounds:property"}}{{/crossLink}}, and {{#crossLink "MouseEvent"}}{{/crossLink}} x/y/rawX/rawY.
	*/
	public var mouseMoveOutside:Bool;
	
	/**
	* If true, tick callbacks will be called on all display objects on the stage prior to rendering to the canvas.
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
	* Indicates whether this stage should use the {{#crossLink "DisplayObject/snapToPixel"}}{{/crossLink}} property of display objects when rendering them.
	*/
	public var snapToPixelEnabled:Bool;
	
	/**
	* NOTE: this name is not final. Feedback is appreciated.  The stage assigned to this property will have mouse interactions relayed to it after this stage handles them. This can be useful in cases where you have multiple canvases layered on top of one another and want your mouse events to pass through. For example, this would relay mouse events from topStage to bottomStage:       topStage.nextStage = bottomStage;  Note that each stage handles the interactions independently. As such, you could have a click register on an object in the top stage, and another click register in the bottom stage. Consider using a single canvas with cached {{#crossLink "Container"}}{{/crossLink}} instances instead of multiple canvases.  MouseOver, MouseOut, RollOver, and RollOut interactions will not be passed through. They must be enabled using {{#crossLink "Stage/enableMouseOver"}}{{/crossLink}} for each stage individually.  In most instances, you will also want to disable DOM events for the next stage to avoid duplicate interactions. myNextStage.enableDOMEvents(false);
	*/
	public var nextStage:Stage;
	
	/**
	* Number of active pointers.
	*/
	private var _pointerCount:Dynamic;
	
	/**
	* The canvas the stage will render to. Multiple stages can share a single canvas, but you must disable autoClear for all but the first stage that will be ticked (or they will clear each other's render).  When changing the canvas property you must disable the events on the old canvas, and enable events on the new canvas or mouse events will not work as expected. For example:       myStage.enableDOMEvents(false);      myStage.canvas = anotherCanvas;      myStage.enableDOMEvents(true);
	*/
	public var canvas:Dynamic;
	
	/**
	* The current mouse X position on the canvas. If the mouse leaves the canvas, this will indicate the most recent position over the canvas, and mouseInBounds will be set to false.
	*/
	public var mouseX:Float;
	
	/**
	* The current mouse Y position on the canvas. If the mouse leaves the canvas, this will indicate the most recent position over the canvas, and mouseInBounds will be set to false.
	*/
	public var mouseY:Float;
	
	/**
	* The ID of the primary pointer.
	*/
	private var _primaryPointerID:Dynamic;
	
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
	* Clears the target canvas. Useful if {{#crossLink "Stage/autoClear:property"}}{{/crossLink}} is set to `false`.
	*/
	public function clear():Dynamic;
	
	/**
	* Each time the update method is called, the stage will tick all descendants (see: {{#crossLink "DisplayObject/tick"}}{{/crossLink}})
	*	and then render the display list to the canvas. Any parameters passed to `update()` will be passed on to any
	*	{{#crossLink "DisplayObject/tick:event"}}{{/crossLink}} event handlers.
	*	
	*	Some time-based features in EaselJS (for example {{#crossLink "Sprite/framerate"}}{{/crossLink}} require that
	*	a tick event object (or equivalent) be passed as the first parameter to update(). For example:
	*	
	*	     Ticker.addEventListener("tick", handleTick);
	*		    function handleTick(evtObj) {
	*		     	// do some work here, then update the stage, passing through the event object:
	*		    	myStage.update(evtObj);
	*		    }
	* @param params Params to include when ticking descendants. The first param should usually be a tick event.
	*/
	public function update(?params:Dynamic):Dynamic;
	
	/**
	* Enables or disables (by passing a frequency of 0) mouse over ({{#crossLink "DisplayObject/mouseover:event"}}{{/crossLink}}
	*	and {{#crossLink "DisplayObject/mouseout:event"}}{{/crossLink}}) and roll over events ({{#crossLink "DisplayObject/rollover:event"}}{{/crossLink}}
	*	and {{#crossLink "DisplayObject/rollout:event"}}{{/crossLink}}) for this stage's display list. These events can
	*	be expensive to generate, so they are disabled by default. The frequency of the events can be controlled
	*	independently of mouse move events via the optional `frequency` parameter.
	*	
	*	<h4>Example</h4>
	*	     var stage = new createjs.Stage("canvasId");
	*	     stage.enableMouseOver(10); // 10 updates per second
	* @param frequency Optional param specifying the maximum number of times per second to broadcast
	*	mouse over/out events. Set to 0 to disable mouse over events completely. Maximum is 50. A lower frequency is less
	*	responsive, but uses less CPU.
	*/
	public function enableMouseOver(?frequency:Float):Dynamic;
	
	/**
	* Enables or disables the event listeners that stage adds to DOM elements (window, document and canvas). It is good
	*	practice to disable events when disposing of a Stage instance, otherwise the stage will continue to receive
	*	events from the page.
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
	* Returns a clone of this Stage.
	*/
	//public function clone():Stage;
	
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
	
	private function _dispatchMouseEvent(target:DisplayObject, type:String, bubbles:Bool, pointerId:Float, o:Dynamic, ?nativeEvent:MouseEvent):Dynamic;
	
	private function _getElementRect(e:Element):Dynamic;
	
	private function _getPointerData(id:Float):Dynamic;
	
	private function _handleDoubleClick(e:MouseEvent):Dynamic;
	
	private function _handleMouseDown(e:MouseEvent):Dynamic;
	
	private function _handleMouseMove(e:MouseEvent):Dynamic;
	
	private function _handleMouseUp(e:MouseEvent):Dynamic;
	
	private function _handlePointerDown(id:Float, e:Event, pageX:Float, pageY:Float):Dynamic;
	
	private function _handlePointerMove(id:Float, e:Event, pageX:Float, pageY:Float):Dynamic;
	
	private function _handlePointerUp(id:Float, e:Event, clear:Bool):Dynamic;
	
	private function _testMouseOver(clear:Bool):Dynamic;
	
	private function _updatePointerPosition(id:Float, e:Event, pageX:Float, pageY:Float):Dynamic;
	
}
