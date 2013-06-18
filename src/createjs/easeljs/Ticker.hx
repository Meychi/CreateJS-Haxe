package createjs.easeljs;

/**
* The Ticker provides  a centralized tick or heartbeat broadcast at a set interval. Listeners can subscribe to the tick
*	event to be notified when a set time interval has elapsed.
*	
*	Note that the interval that the tick event is called is a target interval, and may be broadcast at a slower interval
*	during times of high CPU load. The Ticker class uses a static interface (ex. <code>Ticker.getPaused()</code>) and
*	should not be instantiated.
*	
*	<h4>Example</h4>
*	     createjs.Ticker.addEventListener("tick", handleTick);
*	     function handleTick(event) {
*	         // Actions carried out each frame
*	         if (!event.paused) {
*	             // Actions carried out when the Ticker is not paused.
*	         }
*	     }
*	
*	To update a stage every tick, the {{#crossLink "Stage"}}{{/crossLink}} instance can also be used as a listener, as
*	it will automatically update when it receives a tick event:
*	
*	     createjs.Ticker.addEventListener("tick", stage);
*/
@:native("createjs.Ticker")
extern class Ticker
{
	/**
	* Indicates whether Ticker should use <code>requestAnimationFrame</code> if it is supported in the browser. If false, Ticker will use <code>setTimeout</code>. If you use RAF, it is recommended that you set the framerate to a divisor of 60 (ex. 15, 20, 30, 60).
	*/
	public static var useRAF:Bool;
	
	/**
	* The number of ticks that have passed
	*/
	private var _ticks:Float;
	
	/**
	* The number of ticks that have passed while Ticker has been paused
	*/
	private var _pausedTicks:Float;
	
	private var _inited:Bool;
	
	private var _interval:Float;
	
	private var _lastTime:Float;
	
	private var _listeners:Array<Dynamic>;
	
	private var _pauseable:Array<Dynamic>;
	
	private var _paused:Bool;
	
	private var _pausedTime:Float;
	
	private var _rafActive:Bool;
	
	private var _startTime:Float;
	
	private var _tickTimes:Array<Dynamic>;
	
	private var _timeoutID:Float;
	
	private var _times:Array<Dynamic>;
	
	/**
	* Adds a listener for the tick event. The listener must be either an object exposing a <code>tick</code> method,
	*	or a function. The listener will be called once each tick / interval. The interval is specified via the 
	*	<code>.setInterval(ms)</code> method.
	*	The tick method or function is passed two parameters: the elapsed time between the previous tick and the current
	*	one, and a boolean indicating whether Ticker is paused.
	* @param o The object or function to add as a listener.
	* @param pauseable If false, the listener will continue to have tick called 
	*	even when Ticker is paused via Ticker.pause(). Default is true.
	*/
	public static function addListener(o:Dynamic, pauseable:Bool):Dynamic;
	
	/**
	* Changes the "paused" state of the Ticker, which can be retrieved by the {{#crossLink "Ticker/getPaused"}}{{/crossLink}}
	*	method, and is passed as the "paused" property of the <code>tick</code> event. When the ticker is paused, all
	*	listeners will still receive a tick event, but the <code>paused</code> property will be false.
	*	
	*	Note that in EaselJS v0.5.0 and earlier, "pauseable" listeners would <strong>not</strong> receive the tick
	*	callback when Ticker was paused. This is no longer the case.
	*	
	*	<h4>Example</h4>
	*	     createjs.Ticker.addEventListener("tick", handleTick);
	*	     createjs.Ticker.setPaused(true);
	*	     function handleTick(event) {
	*	         console.log("Paused:", event.paused, createjs.Ticker.getPaused());
	*	     }
	* @param value Indicates whether to pause (true) or unpause (false) Ticker.
	*/
	public static function setPaused(value:Bool):Dynamic;
	
	/**
	* Initializes or resets the timer, clearing all associated listeners and fps measuring data, starting the tick.
	*	This is called automatically when the first listener is added.
	*/
	public static function init():Dynamic;
	
	/**
	* Removes all listeners.
	*/
	public static function removeAllListeners():Dynamic;
	
	/**
	* Removes the specified listener.
	* @param o The object or function to remove from listening from the tick event.
	*/
	public static function removeListener(o:Dynamic):Dynamic;
	
	/**
	* Returns the actual frames / ticks per second.
	* @param ticks The number of previous ticks over which to measure the actual frames / ticks per second.
	*	Defaults to the number of ticks per second.
	*/
	public static function getMeasuredFPS(?ticks:Float):Float;
	
	/**
	* Returns the current target time between ticks, as set with {{#crossLink "Ticker/setInterval"}}{{/crossLink}}.
	*/
	public static function getInterval():Float;
	
	/**
	* Returns the number of milliseconds that have elapsed since Ticker was initialized. For example, you could use
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
	* Returns the target frame rate in frames per second (FPS). For example, with an interval of 40, <code>getFPS()</code>
	*	will return 25 (1000ms per second divided by 40 ms per tick = 25fps).
	*/
	public static function getFPS():Float;
	
	/**
	* Sets the target frame rate in frames per second (FPS). For example, with an interval of 40, <code>getFPS()</code>
	*	will return 25 (1000ms per second divided by 40 ms per tick = 25fps).
	* @param value Target number of ticks broadcast per second.
	*/
	public static function setFPS(value:Float):Dynamic;
	
	/**
	* Sets the target time (in milliseconds) between ticks. Default is 50 (20 FPS).
	*	
	*	Note actual time between ticks may be more than requested depending on CPU load.
	* @param interval Time in milliseconds between ticks. Default value is 50.
	*/
	public static function setInterval(interval:Float):Dynamic;
	
	private function _getTime():Dynamic;
	
	private function _handleAF():Dynamic;
	
	private function _handleTimeout():Dynamic;
	
	private function _setupTick():Dynamic;
	
	private function _tick():Dynamic;
	
}
