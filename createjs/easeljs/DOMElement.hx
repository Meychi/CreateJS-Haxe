package createjs.easeljs;

import js.html.CanvasRenderingContext2D;
import js.html.Element;
import js.html.Event;

/**
* <b>This class is still experimental, and more advanced use is likely to be buggy. Please report bugs.</b>
*	
*	A DOMElement allows you to associate a HTMLElement with the display list. It will be transformed
*	within the DOM as though it is child of the {{#crossLink "Container"}}{{/crossLink}} it is added to. However, it is
*	not rendered to canvas, and as such will retain whatever z-index it has relative to the canvas (ie. it will be
*	drawn in front of or behind the canvas).
*	
*	The position of a DOMElement is relative to their parent node in the DOM. It is recommended that
*	the DOM Object be added to a div that also contains the canvas so that they share the same position
*	on the page.
*	
*	DOMElement is useful for positioning HTML elements over top of canvas content, and for elements
*	that you want to display outside the bounds of the canvas. For example, a tooltip with rich HTML
*	content.
*	
*	<h4>Mouse Interaction</h4>
*	
*	DOMElement instances are not full EaselJS display objects, and do not participate in EaselJS mouse
*	events or support methods like hitTest. To get mouse events from a DOMElement, you must instead add handlers to
*	the htmlElement (note, this does not support EventDispatcher)
*	
*	     var domElement = new createjs.DOMElement(htmlElement);
*	     domElement.htmlElement.onclick = function() {
*	         console.log("clicked");
*	     }
*/
@:native("createjs.DOMElement")
extern class DOMElement extends DisplayObject
{
	/**
	* The DOM object to manage.
	*/
	public var htmlElement:Element;
	
	private var _oldMtx:Matrix2D;
	
	/**
	* <b>This class is still experimental, and more advanced use is likely to be buggy. Please report bugs.</b>
	*	
	*	A DOMElement allows you to associate a HTMLElement with the display list. It will be transformed
	*	within the DOM as though it is child of the {{#crossLink "Container"}}{{/crossLink}} it is added to. However, it is
	*	not rendered to canvas, and as such will retain whatever z-index it has relative to the canvas (ie. it will be
	*	drawn in front of or behind the canvas).
	*	
	*	The position of a DOMElement is relative to their parent node in the DOM. It is recommended that
	*	the DOM Object be added to a div that also contains the canvas so that they share the same position
	*	on the page.
	*	
	*	DOMElement is useful for positioning HTML elements over top of canvas content, and for elements
	*	that you want to display outside the bounds of the canvas. For example, a tooltip with rich HTML
	*	content.
	*	
	*	<h4>Mouse Interaction</h4>
	*	
	*	DOMElement instances are not full EaselJS display objects, and do not participate in EaselJS mouse
	*	events or support methods like hitTest. To get mouse events from a DOMElement, you must instead add handlers to
	*	the htmlElement (note, this does not support EventDispatcher)
	*	
	*	     var domElement = new createjs.DOMElement(htmlElement);
	*	     domElement.htmlElement.onclick = function() {
	*	         console.log("clicked");
	*	     }
	* @param htmlElement A reference or id for the DOM element to manage.
	*/
	public function new(htmlElement:Element):Void;
	
	/**
	* DOMElement cannot be cloned. Throws an error.
	*/
	//public function clone():Dynamic;
	
	/**
	* Draws the display object into the specified context ignoring its visible, alpha, shadow, and transform.
	*	Returns true if the draw was handled (useful for overriding functionality).
	*	NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
	* @param ctx The canvas 2D context object to draw into.
	* @param ignoreCache Indicates whether the draw operation should ignore any current cache.
	*	For example, used for drawing the cache (to prevent it from simply drawing an existing cache back
	*	into itself).
	*/
	//public function draw(ctx:CanvasRenderingContext2D, ignoreCache:Bool):Bool;
	
	/**
	* Not applicable to DOMElement.
	*/
	//public function cache():Dynamic;
	
	/**
	* Not applicable to DOMElement.
	*/
	//public function globalToLocal():Dynamic;
	
	/**
	* Not applicable to DOMElement.
	*/
	//public function hitTest():Dynamic;
	
	/**
	* Not applicable to DOMElement.
	*/
	//public function localToGlobal():Dynamic;
	
	/**
	* Not applicable to DOMElement.
	*/
	//public function localToLocal():Dynamic;
	
	/**
	* Not applicable to DOMElement.
	*/
	//public function uncache():Dynamic;
	
	/**
	* Not applicable to DOMElement.
	*/
	//public function updateCache():Dynamic;
	
	/**
	* Returns a string representation of this object.
	*/
	//public function toString():String;
	
	/**
	* Returns true or false indicating whether the display object would be visible if drawn to a canvas.
	*	This does not account for whether it would be visible within the boundaries of the stage.
	*	NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
	*/
	//public function isVisible():Bool;
	
	//private function _tick(evtObj:Dynamic):Dynamic;
	
	private function _handleDrawEnd(evt:Event):Dynamic;
	
}
