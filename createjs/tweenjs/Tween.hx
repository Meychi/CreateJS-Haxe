package createjs.tweenjs;

/**
* A Tween instance tweens properties for a single target. Instance methods can be chained for easy construction and sequencing:
*	
*	<h4>Example</h4>
*	
*	     target.alpha = 1;
*		    createjs.Tween.get(target)
*		         .wait(500)
*		         .to({alpha:0, visible:false}, 1000)
*		         .call(handleComplete);
*		    function handleComplete() {
*		    	//Tween complete
*		    }
*	
*	Multiple tweens can point to the same instance, however if they affect the same properties there could be unexpected
*	behaviour. To stop all tweens on an object, use {{#crossLink "Tween/removeTweens"}}{{/crossLink}} or pass `override:true`
*	in the props argument.
*	
*	     createjs.Tween.get(target, {override:true}).to({x:100});
*	
*	Subscribe to the {{#crossLink "Tween/change:event"}}{{/crossLink}} event to get notified when a property of the
*	target is changed.
*	
*	     createjs.Tween.get(target, {override:true}).to({x:100}).addEventListener("change", handleChange);
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
	* Causes this tween to continue playing when a global pause is active. For example, if TweenJS is using {{#crossLink "Ticker"}}{{/crossLink}}, then setting this to true (the default) will cause this tween to be paused when <code>Ticker.setPaused(true)</code> is called. See the Tween {{#crossLink "Tween/tick"}}{{/crossLink}} method for more info. Can be set via the props parameter.
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
	* Indicates the tween's current position is within a passive wait.
	*/
	public var passive:Bool;
	
	/**
	* Indicates whether the tween is currently registered with Tween.
	*/
	private var _registered:Bool;
	
	/**
	* Normalized position.
	*/
	private var _prevPos:Float;
	
	/**
	* Raw position.
	*/
	private var _prevPosition:Float;
	
	/**
	* Specifies the total duration of this tween in milliseconds (or ticks if useTicks is true). This value is automatically updated as you modify the tween. Changing it directly could result in unexpected behaviour.
	*/
	public var duration:Float;
	
	/**
	* The current normalized position of the tween. This will always be a value between 0 and duration. Changing this property directly will have no effect.
	*/
	public var position:Dynamic;
	
	/**
	* The position within the current step.
	*/
	private var _stepPosition:Float;
	
	/**
	* The target of this tween. This is the object on which the tweened properties will be changed. Changing this property after the tween is created will not have any effect.
	*/
	public var target:Dynamic;
	
	private var _actions:Array<Dynamic>;
	
	private var _curQueueProps:Dynamic;
	
	private var _inited:Bool;
	
	private var _initQueueProps:Dynamic;
	
	private var _paused:Bool;
	
	private var _steps:Array<Dynamic>;
	
	private var _target:Dynamic;
	
	private var _useTicks:Bool;
	
	//public static var _listeners:Array<Tween>;
	
	public static var _plugins:Dynamic;
	
	/**
	* A Tween instance tweens properties for a single target. Instance methods can be chained for easy construction and sequencing:
	*	
	*	<h4>Example</h4>
	*	
	*	     target.alpha = 1;
	*		    createjs.Tween.get(target)
	*		         .wait(500)
	*		         .to({alpha:0, visible:false}, 1000)
	*		         .call(handleComplete);
	*		    function handleComplete() {
	*		    	//Tween complete
	*		    }
	*	
	*	Multiple tweens can point to the same instance, however if they affect the same properties there could be unexpected
	*	behaviour. To stop all tweens on an object, use {{#crossLink "Tween/removeTweens"}}{{/crossLink}} or pass `override:true`
	*	in the props argument.
	*	
	*	     createjs.Tween.get(target, {override:true}).to({x:100});
	*	
	*	Subscribe to the {{#crossLink "Tween/change:event"}}{{/crossLink}} event to get notified when a property of the
	*	target is changed.
	*	
	*	     createjs.Tween.get(target, {override:true}).to({x:100}).addEventListener("change", handleChange);
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
	*	   <LI> ignoreGlobalPause: sets the {{#crossLink "Tween/ignoreGlobalPause:property"}}{{/crossLink}} property on this tween.</LI>
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
	* Advances all tweens. This typically uses the {{#crossLink "Ticker"}}{{/crossLink}} class, but you can call it
	*	manually if you prefer to use your own "heartbeat" implementation.
	* @param delta The change in time in milliseconds since the last tick. Required unless all tweens have
	*	`useTicks` set to true.
	* @param paused Indicates whether a global pause is in effect. Tweens with {{#crossLink "Tween/ignoreGlobalPause:property"}}{{/crossLink}}
	*	will ignore this, but all others will pause if this is `true`.
	*/
	public static function tick(delta:Float, paused:Bool):Dynamic;
	
	/**
	* Advances the tween to a specified position.
	* @param value The position to seek to in milliseconds (or ticks if useTicks is true).
	* @param actionsMode Specifies how actions are handled (ie. call, set, play, pause):
	*	<ul>
	*	     <li>{{#crossLink "Tween/NONE:property"}}{{/crossLink}} (0) - run no actions.</li>
	*	     <li>{{#crossLink "Tween/LOOP:property"}}{{/crossLink}} (1) - if new position is less than old, then run all
	*	     actions between old and duration, then all actions between 0 and new.</li>
	*	     <li>{{#crossLink "Tween/REVERSE:property"}}{{/crossLink}} (2) - if new position is less than old, run all
	*	     actions between them in reverse.</li>
	*	</ul>
	*/
	public function setPosition(value:Float, ?actionsMode:Float):Bool;
	
	/**
	* Advances this tween by the specified amount of time in milliseconds (or ticks if`useTicks` is `true`).
	*	This is normally called automatically by the Tween engine (via {{#crossLink "Tween/tick"}}{{/crossLink}}), but is
	*	exposed for advanced uses.
	* @param delta The time to advance in milliseconds (or ticks if `useTicks` is `true`).
	*/
	//public function tick(delta:Float):Dynamic;
	
	/**
	* Handle events that result from Tween being used as an event handler. This is included to allow Tween to handle
	*	{{#crossLink "Ticker/tick:event"}}{{/crossLink}} events from the createjs {{#crossLink "Ticker"}}{{/crossLink}}.
	*	No other events are handled in Tween.
	* @param event An event object passed in by the {{#crossLink "EventDispatcher"}}{{/crossLink}}. Will
	*	usually be of type "tick".
	*/
	private static function handleEvent(event:Dynamic):Dynamic;
	
	/**
	* Indicates whether there are any active tweens (and how many) on the target object (if specified) or in general.
	* @param target The target to check for active tweens. If not specified, the return value will indicate
	*	if there are any active tweens on any target.
	*/
	public static function hasActiveTweens(?target:Dynamic):Bool;
	
	/**
	* Installs a plugin, which can modify how certain properties are handled when tweened. See the {{#crossLink "CSSPlugin"}}{{/crossLink}}
	*	for an example of how to write TweenJS plugins.
	* @param plugin The plugin class to install
	* @param properties An array of properties that the plugin will handle.
	*/
	public static function installPlugin(plugin:Dynamic, properties:Array<Dynamic>):Dynamic;
	
	/**
	* Pauses or plays this tween.
	* @param value Indicates whether the tween should be paused (`true`) or played (`false`).
	*/
	public function setPaused(?value:Bool):Tween;
	
	/**
	* Queues a tween from the current values to the target properties. Set duration to 0 to jump to these value.
	*	Numeric properties will be tweened from their current value in the tween to the target value. Non-numeric
	*	properties will be set at the end of the specified duration.
	*	<h4>Example</h4>
	*	
	*			createjs.Tween.get(target).to({alpha:0}, 1000);
	* @param props An object specifying property target values for this tween (Ex. `{x:300}` would tween the x
	*	property of the target to 300).
	* @param duration The duration of the wait in milliseconds (or in ticks if `useTicks` is true).
	* @param ease The easing function to use for this tween. See the {{#crossLink "Ease"}}{{/crossLink}}
	*	class for a list of built-in ease functions.
	*/
	public function to(props:Dynamic, ?duration:Float, ?ease:Dynamic):Tween;
	
	/**
	* Queues a wait (essentially an empty tween).
	*	<h4>Example</h4>
	*	
	*			//This tween will wait 1s before alpha is faded to 0.
	*			createjs.Tween.get(target).wait(1000).to({alpha:0}, 1000);
	* @param duration The duration of the wait in milliseconds (or in ticks if `useTicks` is true).
	* @param passive Tween properties will not be updated during a passive wait. This
	*	is mostly useful for use with {{#crossLink "Timeline"}}{{/crossLink}} instances that contain multiple tweens
	*	affecting the same target at different times.
	*/
	public function wait(duration:Float, ?passive:Bool):Tween;
	
	/**
	* Queues an action to call the specified function.
	*	<h4>Example</h4>
	*	
	*	  	//would call myFunction() after 1 second.
	*	  	myTween.wait(1000).call(myFunction);
	* @param callback The function to call.
	* @param params . The parameters to call the function with. If this is omitted, then the function
	*	     will be called with a single param pointing to this tween.
	* @param scope . The scope to call the function in. If omitted, it will be called in the target's
	*	     scope.
	*/
	public function call(_callback:Dynamic, ?params:Array<Dynamic>, ?scope:Dynamic):Tween;
	
	/**
	* Queues an action to pause the specified tween.
	* @param tween The tween to pause. If null, it pauses this tween.
	*/
	public function pause(tween:Tween):Tween;
	
	/**
	* Queues an action to play (unpause) the specified tween. This enables you to sequence multiple tweens.
	*	<h4>Example</h4>
	*	
	*			myTween.to({x:100},500).play(otherTween);
	* @param tween The tween to play.
	*/
	public function play(tween:Tween):Tween;
	
	/**
	* Queues an action to set the specified props on the specified target. If target is null, it will use this tween's
	*	target.
	*	<h4>Example</h4>
	*	
	*			myTween.wait(1000).set({visible:false},foo);
	* @param props The properties to set (ex. `{visible:false}`).
	* @param target The target to set the properties on. If omitted, they will be set on the tween's target.
	*/
	public function set(props:Dynamic, ?target:Dynamic):Tween;
	
	/**
	* Registers or unregisters a tween with the ticking system.
	* @param tween The tween instance to register or unregister.
	* @param value If `true`, the tween is registered. If `false` the tween is unregistered.
	*/
	private static function _register(tween:Tween, value:Bool):Dynamic;
	
	/**
	* Removes all existing tweens for a target. This is called automatically by new tweens if the `override`
	*	property is `true`.
	* @param target The target object to remove existing tweens from.
	*/
	public static function removeTweens(target:Dynamic):Dynamic;
	
	/**
	* Returns a new tween instance. This is functionally identical to using "new Tween(...)", but looks cleaner
	*	with the chained syntax of TweenJS.
	*	<h4>Example</h4>
	*	
	*			var tween = createjs.Tween.get(target);
	* @param target The target object that will have its properties tweened.
	* @param props The configuration properties to apply to this tween instance (ex. `{loop:true, paused:true}`).
	*	All properties default to `false`. Supported props are:
	*	<UL>
	*	   <LI> loop: sets the loop property on this tween.</LI>
	*	   <LI> useTicks: uses ticks for all durations instead of milliseconds.</LI>
	*	   <LI> ignoreGlobalPause: sets the {{#crossLink "Tween/ignoreGlobalPause:property"}}{{/crossLink}} property on
	*	   this tween.</LI>
	*	   <LI> override: if true, `createjs.Tween.removeTweens(target)` will be called to remove any other tweens with
	*	   the same target.
	*	   <LI> paused: indicates whether to start the tween paused.</LI>
	*	   <LI> position: indicates the initial position for this tween.</LI>
	*	   <LI> onChange: specifies a listener for the {{#crossLink "Tween/change:event"}}{{/crossLink}} event.</LI>
	*	</UL>
	* @param pluginData An object containing data for use by installed plugins. See individual plugins'
	*	documentation for details.
	* @param override If true, any previous tweens on the same target will be removed. This is the
	*	same as calling `Tween.removeTweens(target)`.
	*/
	public static function get(target:Dynamic, ?props:Dynamic, ?pluginData:Dynamic, ?_override:Bool):Tween;
	
	/**
	* Returns a string representation of this object.
	*/
	public override function toString():String;
	
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
	
}
