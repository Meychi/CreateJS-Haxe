package createjs;

/**
* EventDispatcher provides methods for managing queues of event listeners and dispatching events.
*	
*	You can either extend EventDispatcher or mix its methods into an existing prototype or instance by using the
*	EventDispatcher {{#crossLink "EventDispatcher/initialize"}}{{/crossLink}} method.
*	
*	Together with the CreateJS Event class, EventDispatcher provides an extended event model that is based on the
*	DOM Level 2 event model, including addEventListener, removeEventListener, and dispatchEvent. It supports
*	bubbling / capture, preventDefault, stopPropagation, stopImmediatePropagation, and handleEvent.
*	
*	EventDispatcher also exposes a {{#crossLink "EventDispatcher/on"}}{{/crossLink}} method, which makes it easier
*	to create scoped listeners, listeners that only run once, and listeners with associated arbitrary data. The 
*	{{#crossLink "EventDispatcher/off"}}{{/crossLink}} method is merely an alias to
*	{{#crossLink "EventDispatcher/removeEventListener"}}{{/crossLink}}.
*	
*	Another addition to the DOM Level 2 model is the {{#crossLink "EventDispatcher/removeAllEventListeners"}}{{/crossLink}}
*	method, which can be used to listeners for all events, or listeners for a specific event. The Event object also 
*	includes a {{#crossLink "Event/remove"}}{{/crossLink}} method which removes the active listener.
*	
*	<h4>Example</h4>
*	Add EventDispatcher capabilities to the "MyClass" class.
*	
*	     EventDispatcher.initialize(MyClass.prototype);
*	
*	Add an event (see {{#crossLink "EventDispatcher/addEventListener"}}{{/crossLink}}).
*	
*	     instance.addEventListener("eventName", handlerMethod);
*	     function handlerMethod(event) {
*	         console.log(event.target + " Was Clicked");
*	     }
*	
*	<b>Maintaining proper scope</b><br />
*	Scope (ie. "this") can be be a challenge with events. Using the {{#crossLink "EventDispatcher/on"}}{{/crossLink}}
*	method to subscribe to events simplifies this.
*	
*	     instance.addEventListener("click", function(event) {
*	         console.log(instance == this); // false, scope is ambiguous.
*	     });
*	     
*	     instance.on("click", function(event) {
*	         console.log(instance == this); // true, "on" uses dispatcher scope by default.
*	     });
*	
*	If you want to use addEventListener instead, you may want to use function.bind() or a similar proxy to manage
*	scope.
*	
*	<b>Browser support</b>
*	The event model in CreateJS can be used separately from the suite in any project, however the inheritance model
*	requires modern browsers (IE9+).
*/
@:native("createjs.EventDispatcher")
extern class EventDispatcher
{
	private var _captureListeners:Dynamic;
	
	private var _listeners:Dynamic;
	
	/**
	* <strong>REMOVED</strong>. Removed in favor of using `MySuperClass_constructor`.
	*	See {{#crossLink "Utility Methods/extend"}}{{/crossLink}} and {{#crossLink "Utility Methods/promote"}}{{/crossLink}}
	*	for details.
	*	
	*	There is an inheritance tutorial distributed with EaselJS in /tutorials/Inheritance.
	*/
	//private function initialize():Dynamic;
	
	/**
	* A shortcut method for using addEventListener that makes it easier to specify an execution scope, have a listener
	*	only run once, associate arbitrary data with the listener, and remove the listener.
	*	
	*	This method works by creating an anonymous wrapper function and subscribing it with addEventListener.
	*	The wrapper function is returned for use with `removeEventListener` (or `off`).
	*	
	*	<b>IMPORTANT:</b> To remove a listener added with `on`, you must pass in the returned wrapper function as the listener, or use
	*	{{#crossLink "Event/remove"}}{{/crossLink}}. Likewise, each time you call `on` a NEW wrapper function is subscribed, so multiple calls
	*	to `on` with the same params will create multiple listeners.
	*	
	*	<h4>Example</h4>
	*	
	*			var listener = myBtn.on("click", handleClick, null, false, {count:3});
	*			function handleClick(evt, data) {
	*				data.count -= 1;
	*				console.log(this == myBtn); // true - scope defaults to the dispatcher
	*				if (data.count == 0) {
	*					alert("clicked 3 times!");
	*					myBtn.off("click", listener);
	*					// alternately: evt.remove();
	*				}
	*			}
	* @param type The string type of the event.
	* @param listener An object with a handleEvent method, or a function that will be called when
	*	the event is dispatched.
	* @param scope The scope to execute the listener in. Defaults to the dispatcher/currentTarget for function listeners, and to the listener itself for object listeners (ie. using handleEvent).
	* @param once If true, the listener will remove itself after the first time it is triggered.
	* @param data Arbitrary data that will be included as the second parameter when the listener is called.
	* @param useCapture For events that bubble, indicates whether to listen for the event in the capture or bubbling/target phase.
	*/
	public function on(type:String, listener:Dynamic, ?scope:Dynamic, ?once:Bool, ?data:Dynamic, ?useCapture:Bool):Dynamic;
	
	/**
	* A shortcut to the removeEventListener method, with the same parameters and return value. This is a companion to the
	*	.on method.
	*	
	*	<b>IMPORTANT:</b> To remove a listener added with `on`, you must pass in the returned wrapper function as the listener. See 
	*	{{#crossLink "EventDispatcher/on"}}{{/crossLink}} for an example.
	* @param type The string type of the event.
	* @param listener The listener function or object.
	* @param useCapture For events that bubble, indicates whether to listen for the event in the capture or bubbling/target phase.
	*/
	public function off(type:String, listener:Dynamic, ?useCapture:Bool):Dynamic;
	
	/**
	* Adds the specified event listener. Note that adding multiple listeners to the same function will result in
	*	multiple callbacks getting fired.
	*	
	*	<h4>Example</h4>
	*	
	*	     displayObject.addEventListener("click", handleClick);
	*	     function handleClick(event) {
	*	        // Click happened.
	*	     }
	* @param type The string type of the event.
	* @param listener An object with a handleEvent method, or a function that will be called when
	*	the event is dispatched.
	* @param useCapture For events that bubble, indicates whether to listen for the event in the capture or bubbling/target phase.
	*/
	public function addEventListener(type:String, listener:Dynamic, ?useCapture:Bool):Dynamic;
	
	/**
	* Dispatches the specified event to all listeners.
	*	
	*	<h4>Example</h4>
	*	
	*	     // Use a string event
	*	     this.dispatchEvent("complete");
	*	
	*	     // Use an Event instance
	*	     var event = new createjs.Event("progress");
	*	     this.dispatchEvent(event);
	* @param eventObj An object with a "type" property, or a string type.
	*	While a generic object will work, it is recommended to use a CreateJS Event instance. If a string is used,
	*	dispatchEvent will construct an Event instance if necessary with the specified type. This latter approach can
	*	be used to avoid event object instantiation for non-bubbling events that may not have any listeners.
	* @param bubbles Specifies the `bubbles` value when a string was passed to eventObj.
	* @param cancelable Specifies the `cancelable` value when a string was passed to eventObj.
	*/
	public function dispatchEvent(eventObj:Dynamic, ?bubbles:Bool, ?cancelable:Bool):Bool;
	
	/**
	* EventDispatcher provides methods for managing queues of event listeners and dispatching events.
	*	
	*	You can either extend EventDispatcher or mix its methods into an existing prototype or instance by using the
	*	EventDispatcher {{#crossLink "EventDispatcher/initialize"}}{{/crossLink}} method.
	*	
	*	Together with the CreateJS Event class, EventDispatcher provides an extended event model that is based on the
	*	DOM Level 2 event model, including addEventListener, removeEventListener, and dispatchEvent. It supports
	*	bubbling / capture, preventDefault, stopPropagation, stopImmediatePropagation, and handleEvent.
	*	
	*	EventDispatcher also exposes a {{#crossLink "EventDispatcher/on"}}{{/crossLink}} method, which makes it easier
	*	to create scoped listeners, listeners that only run once, and listeners with associated arbitrary data. The 
	*	{{#crossLink "EventDispatcher/off"}}{{/crossLink}} method is merely an alias to
	*	{{#crossLink "EventDispatcher/removeEventListener"}}{{/crossLink}}.
	*	
	*	Another addition to the DOM Level 2 model is the {{#crossLink "EventDispatcher/removeAllEventListeners"}}{{/crossLink}}
	*	method, which can be used to listeners for all events, or listeners for a specific event. The Event object also 
	*	includes a {{#crossLink "Event/remove"}}{{/crossLink}} method which removes the active listener.
	*	
	*	<h4>Example</h4>
	*	Add EventDispatcher capabilities to the "MyClass" class.
	*	
	*	     EventDispatcher.initialize(MyClass.prototype);
	*	
	*	Add an event (see {{#crossLink "EventDispatcher/addEventListener"}}{{/crossLink}}).
	*	
	*	     instance.addEventListener("eventName", handlerMethod);
	*	     function handlerMethod(event) {
	*	         console.log(event.target + " Was Clicked");
	*	     }
	*	
	*	<b>Maintaining proper scope</b><br />
	*	Scope (ie. "this") can be be a challenge with events. Using the {{#crossLink "EventDispatcher/on"}}{{/crossLink}}
	*	method to subscribe to events simplifies this.
	*	
	*	     instance.addEventListener("click", function(event) {
	*	         console.log(instance == this); // false, scope is ambiguous.
	*	     });
	*	     
	*	     instance.on("click", function(event) {
	*	         console.log(instance == this); // true, "on" uses dispatcher scope by default.
	*	     });
	*	
	*	If you want to use addEventListener instead, you may want to use function.bind() or a similar proxy to manage
	*	scope.
	*	
	*	<b>Browser support</b>
	*	The event model in CreateJS can be used separately from the suite in any project, however the inheritance model
	*	requires modern browsers (IE9+).
	*/
	public function new():Void;
	
	/**
	* Indicates whether there is at least one listener for the specified event type on this object or any of its
	*	ancestors (parent, parent's parent, etc). A return value of true indicates that if a bubbling event of the
	*	specified type is dispatched from this object, it will trigger at least one listener.
	*	
	*	This is similar to {{#crossLink "EventDispatcher/hasEventListener"}}{{/crossLink}}, but it searches the entire
	*	event flow for a listener, not just this object.
	* @param type The string type of the event.
	*/
	public function willTrigger(type:String):Bool;
	
	/**
	* Indicates whether there is at least one listener for the specified event type.
	* @param type The string type of the event.
	*/
	public function hasEventListener(type:String):Bool;
	
	/**
	* Removes all listeners for the specified type, or all listeners of all types.
	*	
	*	<h4>Example</h4>
	*	
	*	     // Remove all listeners
	*	     displayObject.removeAllEventListeners();
	*	
	*	     // Remove all click listeners
	*	     displayObject.removeAllEventListeners("click");
	* @param type The string type of the event. If omitted, all listeners for all types will be removed.
	*/
	public function removeAllEventListeners(?type:String):Dynamic;
	
	/**
	* Removes the specified event listener.
	*	
	*	<b>Important Note:</b> that you must pass the exact function reference used when the event was added. If a proxy
	*	function, or function closure is used as the callback, the proxy/closure reference must be used - a new proxy or
	*	closure will not work.
	*	
	*	<h4>Example</h4>
	*	
	*	     displayObject.removeEventListener("click", handleClick);
	* @param type The string type of the event.
	* @param listener The listener function or object.
	* @param useCapture For events that bubble, indicates whether to listen for the event in the capture or bubbling/target phase.
	*/
	public function removeEventListener(type:String, listener:Dynamic, ?useCapture:Bool):Dynamic;
	
	/**
	* Static initializer to mix EventDispatcher methods into a target object or prototype.
	*	
	*			EventDispatcher.initialize(MyClass.prototype); // add to the prototype of the class
	*			EventDispatcher.initialize(myObject); // add to a specific instance
	* @param target The target object to inject EventDispatcher methods into. This can be an instance or a
	*	prototype.
	*/
	public static function initialize(target:Dynamic):Dynamic;
	
	private function _dispatchEvent(eventObj:Dynamic, eventPhase:Dynamic):Dynamic;
	
	public function toString():String;
	
}
