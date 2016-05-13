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
	* Indicates whether display objects should be rendered on whole pixels. You can set the {{#crossLink "DisplayObject/snapToPixel"}}{{/crossLink}} property of display objects to false to enable/disable this behaviour on a per instance basis.
	*/
	public var snapToPixelEnabled:Bool;
	
	/**
	* Indicates whether the mouse is currently within the bounds of the canvas.
	*/
	public var mouseInBounds:Bool;
	
	/**
	* Indicates whether the stage should automatically clear the canvas before each render. You can set this to <code>false</code> to manually control clearing (for generative art, or when pointing multiple stages at the same canvas for example).  <h4>Example</h4>       var stage = new createjs.Stage("canvasId");      stage.autoClear = false;
	*/
	public var autoClear:Bool;
	
	/**
	* Number of active pointers.
	*/
	private var _pointerCount:Dynamic;
	
	/**
	* Prevents selection of other elements in the html page if the user clicks and drags, or double clicks on the canvas. This works by calling `preventDefault()` on any mousedown events (or touch equivalent) originating on the canvas.
	*/
	public var preventSelection:Bool;
	
	/**
	* Specifies a target stage that will have mouse / touch interactions relayed to it after this stage handles them. This can be useful in cases where you have multiple layered canvases and want user interactions events to pass through. For example, this would relay mouse events from topStage to bottomStage:       topStage.nextStage = bottomStage;  To disable relaying, set nextStage to null.  MouseOver, MouseOut, RollOver, and RollOut interactions are also passed through using the mouse over settings of the top-most stage, but are only processed if the target stage has mouse over interactions enabled. Considerations when using roll over in relay targets:<OL> <LI> The top-most (first) stage must have mouse over interactions enabled (via enableMouseOver)</LI> <LI> All stages that wish to participate in mouse over interaction must enable them via enableMouseOver</LI> <LI> All relay targets will share the frequency value of the top-most stage</LI> </OL> To illustrate, in this example the targetStage would process mouse over interactions at 10hz (despite passing 30 as it's desired frequency): 	topStage.nextStage = targetStage; 	topStage.enableMouseOver(10); 	targetStage.enableMouseOver(30);  If the target stage's canvas is completely covered by this stage's canvas, you may also want to disable its DOM events using:  	targetStage.enableDOMEvents(false);
	*/
	public var nextStage:Stage;
	
	/**
	* Specifies the area of the stage to affect when calling update. This can be use to selectively re-draw specific regions of the canvas. If null, the whole canvas area is drawn.
	*/
	public var drawRect:Rectangle;
	
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
	
	private var _nextStage:Stage;
	
	private var _prevStage:Stage;
	
	/**
	* <strong>REMOVED</strong>. Removed in favor of using `MySuperClass_constructor`.
	*	See {{#crossLink "Utility Methods/extend"}}{{/crossLink}} and {{#crossLink "Utility Methods/promote"}}{{/crossLink}}
	*	for details.
	*	
	*	There is an inheritance tutorial distributed with EaselJS in /tutorials/Inheritance.
	*/
	//private function initialize():Dynamic;
	
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
	* Each time the update method is called, the stage will call {{#crossLink "Stage/tick"}}{{/crossLink}}
	*	unless {{#crossLink "Stage/tickOnUpdate:property"}}{{/crossLink}} is set to false,
	*	and then render the display list to the canvas.
	* @param props Props object to pass to `tick()`. Should usually be a {{#crossLink "Ticker"}}{{/crossLink}} event object, or similar object with a delta property.
	*/
	public function update(?props:Dynamic):Dynamic;
	
	/**
	* Enables or disables (by passing a frequency of 0) mouse over ({{#crossLink "DisplayObject/mouseover:event"}}{{/crossLink}}
	*	and {{#crossLink "DisplayObject/mouseout:event"}}{{/crossLink}}) and roll over events ({{#crossLink "DisplayObject/rollover:event"}}{{/crossLink}}
	*	and {{#crossLink "DisplayObject/rollout:event"}}{{/crossLink}}) for this stage's display list. These events can
	*	be expensive to generate, so they are disabled by default. The frequency of the events can be controlled
	*	independently of mouse move events via the optional `frequency` parameter.
	*	
	*	<h4>Example</h4>
	*	
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
	* Propagates a tick event through the display list. This is automatically called by {{#crossLink "Stage/update"}}{{/crossLink}}
	*	unless {{#crossLink "Stage/tickOnUpdate:property"}}{{/crossLink}} is set to false.
	*	
	*	If a props object is passed to `tick()`, then all of its properties will be copied to the event object that is
	*	propagated to listeners.
	*	
	*	Some time-based features in EaselJS (for example {{#crossLink "Sprite/framerate"}}{{/crossLink}} require that
	*	a {{#crossLink "Ticker/tick:event"}}{{/crossLink}} event object (or equivalent object with a delta property) be
	*	passed as the `props` parameter to `tick()`. For example:
	*	
	*		Ticker.on("tick", handleTick);
	*		function handleTick(evtObj) {
	*			// clone the event object from Ticker, and add some custom data to it:
	*			var evt = evtObj.clone().set({greeting:"hello", name:"world"});
	*			
	*			// pass it to stage.update():
	*			myStage.update(evt); // subsequently calls tick() with the same param
	*		}
	*		
	*		// ...
	*		myDisplayObject.on("tick", handleDisplayObjectTick);
	*		function handleDisplayObjectTick(evt) {
	*			console.log(evt.delta); // the delta property from the Ticker tick event object
	*			console.log(evt.greeting, evt.name); // custom data: "hello world"
	*		}
	* @param props An object with properties that should be copied to the event object. Should usually be a Ticker event object, or similar object with a delta property.
	*/
	public function tick(?props:Dynamic):Dynamic;
	
	/**
	* Returns a data url that contains a Base64-encoded image of the contents of the stage. The returned data url can
	*	be specified as the src value of an image element.
	* @param backgroundColor The background color to be used for the generated image. Any valid CSS color
	*	value is allowed. The default value is a transparent background.
	* @param mimeType The MIME type of the image format to be create. The default is "image/png". If an unknown MIME type
	*	is passed in, or if the browser does not support the specified MIME type, the default value will be used.
	*/
	public function toDataURL(?backgroundColor:String, ?mimeType:String):String;
	
	/**
	* Returns a string representation of this object.
	*/
	//public function toString():String;
	
	/**
	* Stage instances cannot be cloned.
	*/
	//public function clone():Dynamic;
	
	private function _dispatchMouseEvent(target:DisplayObject, type:String, bubbles:Bool, pointerId:Float, o:Dynamic, ?nativeEvent:MouseEvent, ?relatedTarget:DisplayObject):Dynamic;
	
	private function _getElementRect(e:Element):Dynamic;
	
	private function _getPointerData(id:Float):Dynamic;
	
	private function _handleDoubleClick(e:MouseEvent, owner:Stage):Dynamic;
	
	private function _handleMouseDown(e:MouseEvent):Dynamic;
	
	private function _handleMouseMove(e:MouseEvent):Dynamic;
	
	private function _handleMouseUp(e:MouseEvent):Dynamic;
	
	private function _handlePointerDown(id:Float, e:Event, pageX:Float, pageY:Float, owner:Stage):Dynamic;
	
	private function _handlePointerMove(id:Float, e:Event, pageX:Float, pageY:Float, owner:Stage):Dynamic;
	
	private function _handlePointerUp(id:Float, e:Event, clear:Bool, owner:Stage):Dynamic;
	
	private function _testMouseOver(clear:Bool, owner:Stage, eventTarget:Stage):Dynamic;
	
	private function _updatePointerPosition(id:Float, e:Event, pageX:Float, pageY:Float):Dynamic;
	
}
