package createjs.easeljs;

/**
* The EventDispatcher provides methods for managing prioritized queues of event listeners and dispatching events. All
*	{{#crossLink "DisplayObject"}}{{/crossLink}} classes dispatch events, as well as some of the utilities like {{#crossLink "Ticker"}}{{/crossLink}}.
*	
*	You can either extend this class or mix its methods into an existing prototype or instance by using the
*	EventDispatcher {{#crossLink "EventDispatcher/initialize"}}{{/crossLink}} method.
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
*	When using EventDispatcher in a class, you may need to use <code>Function.bind</code> or another approach to
*	maintain you method scope. Note that Function.bind is not supported in some older browsers.
*	
*	     instance.addEventListener("click", handleClick.bind(this));
*	     function handleClick(event) {
*	         console.log("Method called in scope: " + this);
*	     }
*	
*	Please note that currently, EventDispatcher does not support event priority or bubbling. Future versions may add
*	support for one or both of these features.
*/
@:native("createjs.EventDispatcher")
extern class EventDispatcher
{
	private var _listeners:Dynamic;
	
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
	*/
	public function addEventListener(type:String, listener:Dynamic):Dynamic;
	
	/**
	* Dispatches the specified event to all listeners.
	*	
	*	<h4>Example</h4>
	*	
	*	     // Use a string event
	*	     this.dispatchEvent("complete");
	*	
	*	     // Use an object
	*	     var event = {
	*	         type: "complete",
	*	         foo: "bar"
	*	     };
	*	     this.dispatchEvent(event);
	* @param eventObj An object with a "type" property, or a string type. If a string is used,
	*	dispatchEvent will construct a generic event object with the specified type.
	* @param target The object to use as the target property of the event object. This will default to the
	*	dispatching object.
	*/
	public function dispatchEvent(eventObj:Dynamic, ?target:Dynamic):Bool;
	
	/**
	* Indicates whether there is at least one listener for the specified event type.
	* @param type The string type of the event.
	*/
	public function hasEventListener(type:String):Bool;
	
	/**
	* Initialization method.
	*/
	//private function initialize():Dynamic;
	
	/**
	* Removes all listeners for the specified type, or all listeners of all types.
	*	
	*	<h4>Example</h4>
	*	
	*	     // Remove all listeners
	*	     displayObject.removeAllEvenListeners();
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
	*/
	public function removeEventListener(type:String, listener:Dynamic):Dynamic;
	
	/**
	* Static initializer to mix in EventDispatcher methods.
	* @param target The target object to inject EventDispatcher methods into. This can be an instance or a
	*	prototype.
	*/
	public static function initialize(target:Dynamic):Dynamic;
	
	/**
	* The EventDispatcher provides methods for managing prioritized queues of event listeners and dispatching events. All
	*	{{#crossLink "DisplayObject"}}{{/crossLink}} classes dispatch events, as well as some of the utilities like {{#crossLink "Ticker"}}{{/crossLink}}.
	*	
	*	You can either extend this class or mix its methods into an existing prototype or instance by using the
	*	EventDispatcher {{#crossLink "EventDispatcher/initialize"}}{{/crossLink}} method.
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
	*	When using EventDispatcher in a class, you may need to use <code>Function.bind</code> or another approach to
	*	maintain you method scope. Note that Function.bind is not supported in some older browsers.
	*	
	*	     instance.addEventListener("click", handleClick.bind(this));
	*	     function handleClick(event) {
	*	         console.log("Method called in scope: " + this);
	*	     }
	*	
	*	Please note that currently, EventDispatcher does not support event priority or bubbling. Future versions may add
	*	support for one or both of these features.
	*/
	public function new():Void;
	
	public function toString():String;
	
}
