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
	* Deprecated in favour of {{#crossLink "Ticker/timingMode"}}{{/crossLink}}, and will be removed in a future version. If true, timingMode will use {{#crossLink "Ticker/RAF_SYNCHED"}}{{/crossLink}} by default.
	*/
	public static var useRAF:Bool;
	
	/**
	* In this mode, Ticker passes through the requestAnimationFrame heartbeat, ignoring the target framerate completely. Because requestAnimationFrame frequency is not deterministic, any content using this mode should be time based. You can leverage {{#crossLink "Ticker/getTime"}}{{/crossLink}} and the tick event object's "delta" properties to make this easier.  Falls back on TIMEOUT if the requestAnimationFrame API is not supported.
	*/
	public static var RAF:String;
	
	/**
	* In this mode, Ticker uses the requestAnimationFrame API, but attempts to synch the ticks to target framerate. It uses a simple heuristic that compares the time of the RAF return to the target time for the current frame and dispatches the tick when the time is within a certain threshold.  This mode has a higher variance for time between frames than TIMEOUT, but does not require that content be time based as with RAF while gaining the benefits of that API (screen synch, background throttling).  Variance is usually lowest for framerates that are a divisor of the RAF frequency. This is usually 60, so framerates of 10, 12, 15, 20, and 30 work well.  Falls back on TIMEOUT if the requestAnimationFrame API is not supported.
	*/
	public static var RAF_SYNCHED:String;
	
	/**
	* In this mode, Ticker uses the setTimeout API. This provides predictable, adaptive frame timing, but does not provide the benefits of requestAnimationFrame (screen synch, background throttling).
	*/
	public static var TIMEOUT:String;
	
	/**
	* Specifies a maximum value for the delta property in the tick event object. This is useful when building time based animations and systems to prevent issues caused by large time gaps caused by background tabs, system sleep, alert dialogs, or other blocking routines. Double the expected frame duration is often an effective value (ex. maxDelta=50 when running at 40fps).  This does not impact any other values (ex. time, runTime, etc), so you may experience issues if you enable maxDelta when using both delta and other values.  If 0, there is no maximum.
	*/
	public static var maxDelta:Float;
	
	/**
	* Specifies the timing api (setTimeout or requestAnimationFrame) and mode to use. See {{#crossLink "Ticker/TIMEOUT"}}{{/crossLink}}, {{#crossLink "Ticker/RAF"}}{{/crossLink}}, and {{#crossLink "Ticker/RAF_SYNCHED"}}{{/crossLink}} for mode details.
	*/
	public static var timingMode:String;
	
	/**
	* Stores the timeout or requestAnimationFrame id.
	*/
	private var _timerId:Float;
	
	/**
	* The number of ticks that have passed
	*/
	private var _ticks:Float;
	
	/**
	* The number of ticks that have passed while Ticker has been paused
	*/
	private var _pausedTicks:Float;
	
	/**
	* True if currently using requestAnimationFrame, false if using setTimeout.
	*/
	private var _raf:Bool;
	
	private var _inited:Bool;
	
	private var _interval:Float;
	
	private var _lastTime:Float;
	
	private var _paused:Bool;
	
	private var _pausedTime:Float;
	
	private var _startTime:Float;
	
	private var _tickTimes:Array<Dynamic>;
	
	private var _times:Array<Dynamic>;
	
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
	* Returns a boolean indicating whether Ticker is currently paused, as set with {{#crossLink "Ticker/setPaused"}}{{/crossLink}}.
	*	When the ticker is paused, all listeners will still receive a tick event, but this value will be false.
	*	
	*	Note that in EaselJS v0.5.0 and earlier, "pauseable" listeners would <strong>not</strong> receive the tick
	*	callback when Ticker was paused. This is no longer the case.
	*	
	*	<h4>Example</h4>
	*	     createjs.Ticker.addEventListener("tick", handleTick);
	*	     createjs.Ticker.setPaused(true);
	*	     function handleTick(event) {
	*	         console.log("Paused:", createjs.Ticker.getPaused());
	*	     }
	*/
	public static function getPaused():Bool;
	
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
	
	/**
	* Similar to getTime(), but returns the time included with the current (or most recent) tick event object.
	* @param runTime [runTime=false] If true, the runTime property will be returned instead of time.
	*/
	public function getEventTime(runTime:Bool):Float;
	
	/**
	* Starts the tick. This is called automatically when the first listener is added.
	*/
	public static function init():Dynamic;
	
	/**
	* Stops the Ticker and removes all listeners. Use init() to restart the Ticker.
	*/
	public static function reset():Dynamic;
	
	private static function _getTime():Dynamic;
	
	private static function _handleRAF():Dynamic;
	
	private static function _handleSynch():Dynamic;
	
	private static function _handleTimeout():Dynamic;
	
	private static function _setupTick():Dynamic;
	
	private static function _tick():Dynamic;
	
}
