package createjs;

import js.html.svg.Number;

/**
* The Ticker provides a centralized tick or heartbeat broadcast at a set interval. Listeners can subscribe to the tick
*	event to be notified when a set time interval has elapsed.
*	
*	Note that the interval that the tick event is called is a target interval, and may be broadcast at a slower interval
*	when under high CPU load. The Ticker class uses a static interface (ex. `Ticker.framerate = 30;`) and
*	can not be instantiated.
*	
*	<h4>Example</h4>
*	
*	     createjs.Ticker.addEventListener("tick", handleTick);
*	     function handleTick(event) {
*	         // Actions carried out each tick (aka frame)
*	         if (!event.paused) {
*	             // Actions carried out when the Ticker is not paused.
*	         }
*	     }
*/
@:native("createjs.Ticker")
extern class Ticker
{
	/**
	* Deprecated in favour of {{#crossLink "Ticker/timingMode"}}{{/crossLink}}, and will be removed in a future version. If true, timingMode will use {{#crossLink "Ticker/RAF_SYNCHED"}}{{/crossLink}} by default.
	*/
	public static var useRAF:Bool;
	
	/**
	* In this mode, Ticker passes through the requestAnimationFrame heartbeat, ignoring the target framerate completely. Because requestAnimationFrame frequency is not deterministic, any content using this mode should be time based. You can leverage {{#crossLink "Ticker/getTime"}}{{/crossLink}} and the {{#crossLink "Ticker/tick:event"}}{{/crossLink}} event object's "delta" properties to make this easier.  Falls back on {{#crossLink "Ticker/TIMEOUT:property"}}{{/crossLink}} if the requestAnimationFrame API is not supported.
	*/
	public static var RAF:String;
	
	/**
	* In this mode, Ticker uses the requestAnimationFrame API, but attempts to synch the ticks to target framerate. It uses a simple heuristic that compares the time of the RAF return to the target time for the current frame and dispatches the tick when the time is within a certain threshold.  This mode has a higher variance for time between frames than {{#crossLink "Ticker/TIMEOUT:property"}}{{/crossLink}}, but does not require that content be time based as with {{#crossLink "Ticker/RAF:property"}}{{/crossLink}} while gaining the benefits of that API (screen synch, background throttling).  Variance is usually lowest for framerates that are a divisor of the RAF frequency. This is usually 60, so framerates of 10, 12, 15, 20, and 30 work well.  Falls back to {{#crossLink "Ticker/TIMEOUT:property"}}{{/crossLink}} if the requestAnimationFrame API is not supported.
	*/
	public static var RAF_SYNCHED:String;
	
	/**
	* In this mode, Ticker uses the setTimeout API. This provides predictable, adaptive frame timing, but does not provide the benefits of requestAnimationFrame (screen synch, background throttling).
	*/
	public static var TIMEOUT:String;
	
	/**
	* Indicates the target frame rate in frames per second (FPS). Effectively just a shortcut to `interval`, where `framerate == 1000/interval`.
	*/
	public static var framerate:Float;
	
	/**
	* Indicates the target time (in milliseconds) between ticks. Default is 50 (20 FPS). Note that actual time between ticks may be more than specified depending on CPU load. This property is ignored if the ticker is using the `RAF` timing mode.
	*/
	public static var interval:Float;
	
	/**
	* Specifies a maximum value for the delta property in the tick event object. This is useful when building time based animations and systems to prevent issues caused by large time gaps caused by background tabs, system sleep, alert dialogs, or other blocking routines. Double the expected frame duration is often an effective value (ex. maxDelta=50 when running at 40fps).  This does not impact any other values (ex. time, runTime, etc), so you may experience issues if you enable maxDelta when using both delta and other values.  If 0, there is no maximum.
	*/
	public static var maxDelta:Number;
	
	/**
	* Specifies the timing api (setTimeout or requestAnimationFrame) and mode to use. See {{#crossLink "Ticker/TIMEOUT"}}{{/crossLink}}, {{#crossLink "Ticker/RAF"}}{{/crossLink}}, and {{#crossLink "Ticker/RAF_SYNCHED"}}{{/crossLink}} for mode details.
	*/
	public static var timingMode:String;
	
	/**
	* Stores the timeout or requestAnimationFrame id.
	*/
	public static var _timerId:Float;
	
	/**
	* The number of ticks that have passed
	*/
	public static var _ticks:Float;
	
	/**
	* The number of ticks that have passed while Ticker has been paused
	*/
	public static var _pausedTicks:Float;
	
	/**
	* True if currently using requestAnimationFrame, false if using setTimeout. This may be different than timingMode if that property changed and a tick hasn't fired.
	*/
	public static var _raf:Bool;
	
	/**
	* When the ticker is paused, all listeners will still receive a tick event, but the <code>paused</code> property of the event will be `true`. Also, while paused the `runTime` will not increase. See {{#crossLink "Ticker/tick:event"}}{{/crossLink}}, {{#crossLink "Ticker/getTime"}}{{/crossLink}}, and {{#crossLink "Ticker/getEventTime"}}{{/crossLink}} for more info.  <h4>Example</h4>       createjs.Ticker.addEventListener("tick", handleTick);      createjs.Ticker.paused = true;      function handleTick(event) {          console.log(event.paused,          	createjs.Ticker.getTime(false),          	createjs.Ticker.getTime(true));      }
	*/
	public static var paused:Bool;
	
	public static var _inited:Bool;
	
	public static var _interval:Float;
	
	public static var _lastTime:Float;
	
	public static var _pausedTime:Float;
	
	public static var _startTime:Float;
	
	public static var _tickTimes:Array<Dynamic>;
	
	public static var _times:Array<Dynamic>;
	
	/**
	* Returns the actual frames / ticks per second.
	* @param ticks The number of previous ticks over which to measure the actual frames / ticks per second.
	*	Defaults to the number of ticks per second.
	*/
	public static function getMeasuredFPS(?ticks:Float):Float;
	
	/**
	* Returns the average time spent within a tick. This can vary significantly from the value provided by getMeasuredFPS
	*	because it only measures the time spent within the tick execution stack. 
	*	
	*	Example 1: With a target FPS of 20, getMeasuredFPS() returns 20fps, which indicates an average of 50ms between 
	*	the end of one tick and the end of the next. However, getMeasuredTickTime() returns 15ms. This indicates that 
	*	there may be up to 35ms of "idle" time between the end of one tick and the start of the next.
	*	
	*	Example 2: With a target FPS of 30, getFPS() returns 10fps, which indicates an average of 100ms between the end of
	*	one tick and the end of the next. However, getMeasuredTickTime() returns 20ms. This would indicate that something
	*	other than the tick is using ~80ms (another script, DOM rendering, etc).
	* @param ticks The number of previous ticks over which to measure the average time spent in a tick.
	*	Defaults to the number of ticks per second. To get only the last tick's time, pass in 1.
	*/
	public static function getMeasuredTickTime(?ticks:Float):Float;
	
	/**
	* Returns the number of milliseconds that have elapsed since Ticker was initialized via {{#crossLink "Ticker/init"}}.
	*	Returns -1 if Ticker has not been initialized. For example, you could use
	*	this in a time synchronized animation to determine the exact amount of time that has elapsed.
	* @param runTime If true only time elapsed while Ticker was not paused will be returned.
	*	If false, the value returned will be total time elapsed since the first tick event listener was added.
	*/
	public static function getTime(?runTime:Bool):Float;
	
	/**
	* Returns the number of ticks that have been broadcast by Ticker.
	* @param pauseable Indicates whether to include ticks that would have been broadcast
	*	while Ticker was paused. If true only tick events broadcast while Ticker is not paused will be returned.
	*	If false, tick events that would have been broadcast while Ticker was paused will be included in the return
	*	value. The default value is false.
	*/
	public static function getTicks(pauseable:Bool):Float;
	
	/**
	* Similar to the {{#crossLink "Ticker/getTime"}}{{/crossLink}} method, but returns the time on the most recent {{#crossLink "Ticker/tick:event"}}{{/crossLink}}
	*	event object.
	* @param runTime [runTime=false] If true, the runTime property will be returned instead of time.
	*/
	public static function getEventTime(runTime:Bool):Float;
	
	/**
	* Starts the tick. This is called automatically when the first listener is added.
	*/
	public static function init():Dynamic;
	
	/**
	* Stops the Ticker and removes all listeners. Use init() to restart the Ticker.
	*/
	public static function reset():Dynamic;
	
	/**
	* Use the {{#crossLink "Ticker/framerate:property"}}{{/crossLink}} property instead.
	* @param value 
	*/
	public static function setFPS(value:Float):Dynamic;
	
	/**
	* Use the {{#crossLink "Ticker/framerate:property"}}{{/crossLink}} property instead.
	*/
	public static function getFPS():Float;
	
	/**
	* Use the {{#crossLink "Ticker/interval:property"}}{{/crossLink}} property instead.
	* @param interval 
	*/
	public static function setInterval(interval:Float):Dynamic;
	
	/**
	* Use the {{#crossLink "Ticker/interval:property"}}{{/crossLink}} property instead.
	*/
	public static function getInterval():Float;
	
	/**
	* Use the {{#crossLink "Ticker/paused:property"}}{{/crossLink}} property instead.
	* @param value 
	*/
	public static function setPaused(value:Bool):Dynamic;
	
	/**
	* Use the {{#crossLink "Ticker/paused:property"}}{{/crossLink}} property instead.
	*/
	public static function getPaused():Bool;
	
	private static function _getTime():Dynamic;
	
	private static function _handleRAF():Dynamic;
	
	private static function _handleSynch():Dynamic;
	
	private static function _handleTimeout():Dynamic;
	
	private static function _setupTick():Dynamic;
	
	private static function _tick():Dynamic;
	
	// EventDispatcher injects...
	
	/**
	* A shortcut method for using addEventListener that makes it easier to specify an execution scope, have a listener
	*	only run once, associate arbitrary data with the listener, and remove the listener.
	*	
	*	This method works by creating an anonymous wrapper function and subscribing it with addEventListener.
	*	The created anonymous function is returned for use with .removeEventListener (or .off).
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
	public static function on(type:String, listener:Dynamic, ?scope:Dynamic, ?once:Bool, ?data:Dynamic, ?useCapture:Bool):Dynamic;
	
	/**
	* A shortcut to the removeEventListener method, with the same parameters and return value. This is a companion to the
	*	.on method.
	* @param type The string type of the event.
	* @param listener The listener function or object.
	* @param useCapture For events that bubble, indicates whether to listen for the event in the capture or bubbling/target phase.
	*/
	public static function off(type:String, listener:Dynamic, ?useCapture:Bool):Dynamic;
	
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
	public static function addEventListener(type:String, listener:Dynamic, ?useCapture:Bool):Dynamic;
	
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
	public static function dispatchEvent(eventObj:Dynamic, ?bubbles:Bool, ?cancelable:Bool):Bool;
	
	/**
	* Indicates whether there is at least one listener for the specified event type on this object or any of its
	*	ancestors (parent, parent's parent, etc). A return value of true indicates that if a bubbling event of the
	*	specified type is dispatched from this object, it will trigger at least one listener.
	*	
	*	This is similar to {{#crossLink "EventDispatcher/hasEventListener"}}{{/crossLink}}, but it searches the entire
	*	event flow for a listener, not just this object.
	* @param type The string type of the event.
	*/
	public static function willTrigger(type:String):Bool;
	
	/**
	* Indicates whether there is at least one listener for the specified event type.
	* @param type The string type of the event.
	*/
	public static function hasEventListener(type:String):Bool;
	
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
	public static function removeAllEventListeners(?type:String):Dynamic;
	
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
	public static function removeEventListener(type:String, listener:Dynamic, ?useCapture:Bool):Dynamic;
	
}
