package createjs.tweenjs;

/**
* A Tween instance tweens properties for a single target. Instance methods can be chained for easy construction and sequencing:
*	
*	<h4>Example</h4>
*	
*	     target.alpha = 1;
*		    Tween.get(target)
*		         .wait(500)
*		         .to({alpha:0, visible:false}, 1000)
*		         .call(handleComplete);
*		    function handleComplete() {
*		    	//Tween complete
*		    }
*	
*	Multiple tweens can point to the same instance, however if they affect the same properties there could be unexpected
*	behaviour. To stop all tweens on an object, use {{#crossLink "Tween/removeTweens"}}{{/crossLink}} or pass <code>override:true</code>
*	in the props argument.
*	
*	     Tween.get(target, {override:true}).to({x:100});
*	
*	Subscribe to the "change" event to get notified when a property of the target is changed.
*	
*	     Tween.get(target, {override:true}).to({x:100}).addEventListener("change", handleChange);
*	     function handleChange(event) {
*	         // The tween changed.
*	     }
*	
*	See the Tween {{#crossLink "Tween/get"}}{{/crossLink}} method for additional param documentation.
*/
@:native("createjs.Tween")
extern class Tween extends EventDispatcher
{
	/**
	* Allows you to specify data that will be used by installed plugins. Each plugin uses this differently, but in general you specify data by setting it to a property of pluginData with the same name as the plugin class.
	*/
	public var pluginData:Dynamic;
	
	/**
	* Causes this tween to continue playing when a global pause is active. For example, if TweenJS is using Ticker, then setting this to true (the default) will cause this tween to be paused when <code>Ticker.setPaused(true)</code> is called. See Tween.tick() for more info. Can be set via the props param.
	*/
	public var ignoreGlobalPause:Bool;
	
	/**
	* Constant defining the loop actionsMode for use with setPosition.
	*/
	public static var LOOP:Float;
	
	/**
	* Constant defining the none actionsMode for use with setPosition.
	*/
	public static var NONE:Float;
	
	/**
	* Constant defining the reverse actionsMode for use with setPosition.
	*/
	public static var REVERSE:Float;
	
	/**
	* Constant returned by plugins to tell the tween not to use default assignment.
	*/
	public static var IGNORE:Dynamic;
	
	/**
	* If true, the tween will loop when it reaches the end. Can be set via the props param.
	*/
	public var loop:Bool;
	
	/**
	* Normalized position.
	*/
	private var _prevPos:Float;
	
	/**
	* Raw position.
	*/
	private var _prevPosition:Float;
	
	/**
	* Read-only. Indicates the tween's current position is within a passive wait.
	*/
	public var passive:Bool;
	
	/**
	* Read-only. Specifies the total duration of this tween in milliseconds (or ticks if useTicks is true). This value is automatically updated as you modify the tween. Changing it directly could result in unexpected behaviour.
	*/
	public var duration:Float;
	
	/**
	* Read-only. The current normalized position of the tween. This will always be a value between 0 and duration. Changing this property directly will have no effect.
	*/
	public var position:Dynamic;
	
	/**
	* Read-only. The target of this tween. This is the object on which the tweened properties will be changed. Changing this property after the tween is created will not have any effect.
	*/
	public var target:Dynamic;
	
	/**
	* The position within the current step.
	*/
	private var _stepPosition:Float;
	
	private var _actions:Array<Dynamic>;
	
	private var _curQueueProps:Dynamic;
	
	private var _inited:Boolean;
	
	private var _initQueueProps:Dynamic;
	
	private var _paused:Bool;
	
	private var _steps:Array<Dynamic>;
	
	private var _target:Dynamic;
	
	private var _useTicks:Bool;
	
	public static var _listeners:Array<Tween>;
	
	public static var _plugins:Dynamic;
	
	/**
	* A Tween instance tweens properties for a single target. Instance methods can be chained for easy construction and sequencing:
	*	
	*	<h4>Example</h4>
	*	
	*	     target.alpha = 1;
	*		    Tween.get(target)
	*		         .wait(500)
	*		         .to({alpha:0, visible:false}, 1000)
	*		         .call(handleComplete);
	*		    function handleComplete() {
	*		    	//Tween complete
	*		    }
	*	
	*	Multiple tweens can point to the same instance, however if they affect the same properties there could be unexpected
	*	behaviour. To stop all tweens on an object, use {{#crossLink "Tween/removeTweens"}}{{/crossLink}} or pass <code>override:true</code>
	*	in the props argument.
	*	
	*	     Tween.get(target, {override:true}).to({x:100});
	*	
	*	Subscribe to the "change" event to get notified when a property of the target is changed.
	*	
	*	     Tween.get(target, {override:true}).to({x:100}).addEventListener("change", handleChange);
	*	     function handleChange(event) {
	*	         // The tween changed.
	*	     }
	*	
	*	See the Tween {{#crossLink "Tween/get"}}{{/crossLink}} method for additional param documentation.
	* @param target The target object that will have its properties tweened.
	* @param props The configuration properties to apply to this tween instance (ex. `{loop:true, paused:true}`.
	*	All properties default to false. Supported props are:<UL>
	*	   <LI> loop: sets the loop property on this tween.</LI>
	*	   <LI> useTicks: uses ticks for all durations instead of milliseconds.</LI>
	*	   <LI> ignoreGlobalPause: sets the ignoreGlobalPause property on this tween.</LI>
	*	   <LI> override: if true, `Tween.removeTweens(target)` will be called to remove any other tweens with the same target.
	*	   <LI> paused: indicates whether to start the tween paused.</LI>
	*	   <LI> position: indicates the initial position for this tween.</LI>
	*	   <LI> onChange: specifies a listener for the "change" event.</LI>
	*	</UL>
	* @param pluginData An object containing data for use by installed plugins. See individual
	*	plugins' documentation for details.
	*/
	public function new(target:Dynamic, ?props:Dynamic, ?pluginData:Dynamic):Void;
	
	/**
	* Advances all tweens. This typically uses the Ticker class (available in the EaselJS library), but you can call it
	*	manually if you prefer to use your own "heartbeat" implementation.
	*	
	*	Note: Currently, EaselJS must be included <em>before</em> TweenJS to ensure Ticker exists during initialization.
	* @param delta The change in time in milliseconds since the last tick. Required unless all tweens have
	*	<code>useTicks</code> set to true.
	* @param paused Indicates whether a global pause is in effect. Tweens with <code>ignoreGlobalPause</code>
	*	will ignore this, but all others will pause if this is true.
	*/
	public static function tick(delta:Float, paused:Bool):Dynamic;
	
	/**
	* Advances the tween to a specified position.
	* @param value The position to seek to in milliseconds (or ticks if useTicks is true).
	* @param actionsMode Optional parameter specifying how actions are handled (ie. call, set, play, pause):
	*	     <code>Tween.NONE</code> (0) - run no actions. <code>Tween.LOOP</code> (1) - if new position is less than old, then run all actions
	*	     between old and duration, then all actions between 0 and new. Defaults to <code>LOOP</code>. <code>Tween.REVERSE</code> (2) - if new
	*	     position is less than old, run all actions between them in reverse.
	*/
	public function setPosition(value:Float, actionsMode:Float):Bool;
	
	/**
	* Advances this tween by the specified amount of time in milliseconds (or ticks if <code>useTicks</code> is true).
	*	This is normally called automatically by the Tween engine (via <code>Tween.tick</code>), but is exposed for advanced uses.
	* @param delta The time to advance in milliseconds (or ticks if <code>useTicks</code> is true).
	*/
	//public function tick(delta:Float):Dynamic;
	
	/**
	* Handle events that result from Tween being used as an event handler. This is included to allow Tween to handle
	*	tick events from <code>createjs.Ticker</code>. No other events are handled in Tween.
	* @param event An event object passed in by the EventDispatcher. Will usually be of type "tick".
	*/
	private static function handleEvent(event:Dynamic):Dynamic;
	
	/**
	* Indicates whether there are any active tweens (and how many) on the target object (if specified) or in general.
	* @param target The target to check for active tweens. If not specified, the return value will indicate
	*	if there are any active tweens on any target.
	*/
	public static function hasActiveTweens(?target:Dynamic):Bool;
	
	/**
	* Installs a plugin, which can modify how certain properties are handled when tweened. See the CSSPlugin for an
	*	example of how to write TweenJS plugins.
	* @param plugin The plugin class to install
	* @param properties An array of properties that the plugin will handle.
	*/
	public static function installPlugin(plugin:Dynamic, properties:Array<Dynamic>):Dynamic;
	
	/**
	* Pauses or plays this tween.
	* @param value Indicates whether the tween should be paused (true) or played (false).
	*/
	public function setPaused(value:Bool):Tween;
	
	/**
	* Queues a tween from the current values to the target properties. Set duration to 0 to jump to these value.
	*	Numeric properties will be tweened from their current value in the tween to the target value. Non-numeric
	*	properties will be set at the end of the specified duration.
	* @param props An object specifying property target values for this tween (Ex. <code>{x:300}</code> would tween the x
	*	     property of the target to 300).
	* @param duration Optional. The duration of the wait in milliseconds (or in ticks if <code>useTicks</code> is true).
	*	     Defaults to 0.
	* @param ease Optional. The easing function to use for this tween. Defaults to a linear ease.
	*/
	public function to(props:Dynamic, ?duration:Float, ?ease:Dynamic):Tween;
	
	/**
	* Queues a wait (essentially an empty tween).
	* @param duration The duration of the wait in milliseconds (or in ticks if <code>useTicks</code> is true).
	* @param passive Tween properties will not be updated during a passive wait. This
	*	is mostly useful for use with Timeline's that contain multiple tweens affecting the same target
	*	at different times.
	*/
	public function wait(duration:Float, passive:Bool):Tween;
	
	/**
	* Queues an action to call the specified function.
	* @param callback The function to call.
	* @param params Optional. The parameters to call the function with. If this is omitted, then the function
	*	     will be called with a single param pointing to this tween.
	* @param scope Optional. The scope to call the function in. If omitted, it will be called in the target's
	*	     scope.
	*/
	public function call(_callback:Dynamic, ?params:Array<Dynamic>, ?scope:Dynamic):Tween;
	
	/**
	* Queues an action to set the specified props on the specified target. If target is null, it will use this tween's
	*	target.
	* @param props The properties to set (ex. <code>{visible:false}</code>).
	* @param target Optional. The target to set the properties on. If omitted, they will be set on the tween's target.
	*/
	public function set(props:Dynamic, ?target:Dynamic):Tween;
	
	/**
	* Queues an action to to pause the specified tween.
	* @param tween The tween to play. If null, it pauses this tween.
	*/
	public function pause(tween:Tween):Tween;
	
	/**
	* Queues an action to to play (unpause) the specified tween. This enables you to sequence multiple tweens.
	* @param tween The tween to play.
	*/
	public function play(tween:Tween):Tween;
	
	/**
	* Registers or unregisters a tween with the ticking system.
	* @param tween The tween instance to register or unregister.
	* @param value If true, the tween is registered. If false the tween is unregistered.
	*/
	private static function _register(tween:Tween, value:Bool):Dynamic;
	
	/**
	* Removes all existing tweens for a target. This is called automatically by new tweens if the <code>override</code>
	*	property is <code>true</code>.
	* @param target The target object to remove existing tweens from.
	*/
	public static function removeTweens(target:Dynamic):Dynamic;
	
	/**
	* Returns a new tween instance. This is functionally identical to using "new Tween(...)", but looks cleaner
	*	with the chained syntax of TweenJS.
	* @param target The target object that will have its properties tweened.
	* @param props The configuration properties to apply to this tween instance (ex. <code>{loop:true, paused:true}</code>).
	*	All properties default to false. Supported props are:<UL>
	*	   <LI> loop: sets the loop property on this tween.</LI>
	*	   <LI> useTicks: uses ticks for all durations instead of milliseconds.</LI>
	*	   <LI> ignoreGlobalPause: sets the ignoreGlobalPause property on this tween.</LI>
	*	   <LI> override: if true, Tween.removeTweens(target) will be called to remove any other tweens with the same target.
	*	   <LI> paused: indicates whether to start the tween paused.</LI>
	*	   <LI> position: indicates the initial position for this tween.</LI>
	*	   <LI> onChange: specifies a listener for the "change" event.</LI>
	*	</UL>
	* @param pluginData An object containing data for use by installed plugins. See individual
	*	plugins' documentation for details.
	* @param override If true, any previous tweens on the same target will be removed. This is the same as
	*	calling <code>Tween.removeTweens(target)</code>.
	*/
	public static function get(target:Dynamic, ?props:Dynamic, ?pluginData:Dynamic, ?_override:Bool):Tween;
	
	/**
	* Returns a string representation of this object.
	*/
	public function toString():String;
	
	/**
	* Stop and remove all existing tweens.
	*/
	public static function removeAllTweens():Dynamic;
	
	private function _addAction(o:Dynamic):Dynamic;
	
	private function _addStep(o:Dynamic):Dynamic;
	
	private function _appendQueueProps(o:Dynamic):Dynamic;
	
	private function _cloneProps(props:Dynamic):Dynamic;
	
	private function _runActions(startPos:Float, endPos:Float, includeStart:Bool):Dynamic;
	
	private function _set(props:Dynamic, o:Dynamic):Dynamic;
	
	private function _updateTargetProps(step:Dynamic, ratio:Float):Dynamic;
	
	private function clone():Dynamic;
	
	private function initialize(target:Dynamic, props:Dynamic, pluginData:Dynamic):Dynamic;
	
}
