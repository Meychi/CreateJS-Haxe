package createjs;

import js.html.Event;

/**
* Contains properties and methods shared by all events for use with
*	{{#crossLink "EventDispatcher"}}{{/crossLink}}.
*	
*	Note that Event objects are often reused, so you should never
*	rely on an event object's state outside of the call stack it was received in.
*/
@:native("createjs.Event")
extern class Event
{
	/**
	* For bubbling events, this indicates the current event phase:<OL> 	<LI> capture phase: starting from the top parent to the target</LI> 	<LI> at target phase: currently being dispatched from the target</LI> 	<LI> bubbling phase: from the target to the top parent</LI> </OL>
	*/
	public var eventPhase:Float;
	
	/**
	* Indicates if {{#crossLink "Event/preventDefault"}}{{/crossLink}} has been called on this event.
	*/
	public var defaultPrevented:Bool;
	
	/**
	* Indicates if {{#crossLink "Event/remove"}}{{/crossLink}} has been called on this event.
	*/
	public var removed:Bool;
	
	/**
	* Indicates if {{#crossLink "Event/stopImmediatePropagation"}}{{/crossLink}} has been called on this event.
	*/
	public var immediatePropagationStopped:Bool;
	
	/**
	* Indicates if {{#crossLink "Event/stopPropagation"}}{{/crossLink}} or {{#crossLink "Event/stopImmediatePropagation"}}{{/crossLink}} has been called on this event.
	*/
	public var propagationStopped:Bool;
	
	/**
	* Indicates whether the default behaviour of this event can be cancelled via {{#crossLink "Event/preventDefault"}}{{/crossLink}}. This is set via the Event constructor.
	*/
	public var cancelable:Bool;
	
	/**
	* Indicates whether the event will bubble through the display list.
	*/
	public var bubbles:Bool;
	
	/**
	* The current target that a bubbling event is being dispatched from. For non-bubbling events, this will always be the same as target. For example, if childObj.parent = parentObj, and a bubbling event is generated from childObj, then a listener on parentObj would receive the event with target=childObj (the original target) and currentTarget=parentObj (where the listener was added).
	*/
	public var currentTarget:Dynamic;
	
	/**
	* The epoch time at which this event was created.
	*/
	public var timeStamp:Float;
	
	/**
	* The object that generated an event.
	*/
	public var target:Dynamic;
	
	/**
	* The type of event.
	*/
	public var type:String;
	
	/**
	* <strong>REMOVED</strong>. Removed in favor of using `MySuperClass_constructor`.
	*	See {{#crossLink "Utility Methods/extend"}}{{/crossLink}} and {{#crossLink "Utility Methods/promote"}}{{/crossLink}}
	*	for details.
	*	
	*	There is an inheritance tutorial distributed with EaselJS in /tutorials/Inheritance.
	*/
	private function initialize():Dynamic;
	
	/**
	* Causes the active listener to be removed via removeEventListener();
	*	
	*			myBtn.addEventListener("click", function(evt) {
	*				// do stuff...
	*				evt.remove(); // removes this listener.
	*			});
	*/
	public function remove():Dynamic;
	
	/**
	* Contains properties and methods shared by all events for use with
	*	{{#crossLink "EventDispatcher"}}{{/crossLink}}.
	*	
	*	Note that Event objects are often reused, so you should never
	*	rely on an event object's state outside of the call stack it was received in.
	* @param type The event type.
	* @param bubbles Indicates whether the event will bubble through the display list.
	* @param cancelable Indicates whether the default behaviour of this event can be cancelled.
	*/
	public function new(type:String, bubbles:Bool, cancelable:Bool):Void;
	
	/**
	* Provides a chainable shortcut method for setting a number of properties on the instance.
	* @param props A generic object containing properties to copy to the instance.
	*/
	public function set(props:Dynamic):Event;
	
	/**
	* Returns a clone of the Event instance.
	*/
	public function clone():Event;
	
	/**
	* Returns a string representation of this object.
	*/
	public function toString():String;
	
	/**
	* Sets {{#crossLink "Event/defaultPrevented"}}{{/crossLink}} to true if the event is cancelable.
	*	Mirrors the DOM level 2 event standard. In general, cancelable events that have `preventDefault()` called will
	*	cancel the default behaviour associated with the event.
	*/
	public function preventDefault():Dynamic;
	
	/**
	* Sets {{#crossLink "Event/propagationStopped"}}{{/crossLink}} and
	*	{{#crossLink "Event/immediatePropagationStopped"}}{{/crossLink}} to true.
	*	Mirrors the DOM event standard.
	*/
	public function stopImmediatePropagation():Dynamic;
	
	/**
	* Sets {{#crossLink "Event/propagationStopped"}}{{/crossLink}} to true.
	*	Mirrors the DOM event standard.
	*/
	public function stopPropagation():Dynamic;
	
}
