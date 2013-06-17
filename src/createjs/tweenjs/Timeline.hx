package createjs.tweenjs;

/**
* The Timeline class synchronizes multiple tweens and allows them to be controlled as a group. Please note that if a
*	timeline is looping, the tweens on it may appear to loop even if the "loop" property of the tween is false.
*/
@:native("createjs.Timeline")
extern class Timeline
{	
	/**
	* Called, with a single parameter referencing this timeline instance, whenever the timeline's position changes.
	*/
	public var onChange:Dynamic;
	
	/**
	* Causes this timeline to continue playing when a global pause is active.
	*/
	public var ignoreGlobalPause:Bool;
	
	/**
	* If true, the timeline will loop when it reaches the end. Can be set via the props param.
	*/
	public var loop:Bool;
	
	/**
	* Read-only property specifying the total duration of this timeline in milliseconds (or ticks if useTicks is true). This value is usually automatically updated as you modify the timeline. See updateDuration for more information.
	*/
	public var duration:Float;
	
	/**
	* Read-only. The current normalized position of the timeline. This will always be a value between 0 and duration. Changing this property directly will have no effect.
	*/
	public var position:Dynamic;
	private var _labels:Array<String>;
	private var _paused:Bool;
	private var _prevPos:Float;
	private var _prevPosition:Float;
	private var _tweens:Array<Tween>;
	private var _useTicks:Bool;
	
	/**
	* Adds one or more tweens (or timelines) to this timeline. The tweens will be paused (to remove them from the normal ticking system)
	*	and managed by this timeline. Adding a tween to multiple timelines will result in unexpected behaviour.
	* @param tween The tween(s) to add. Accepts multiple arguments.
	*/
	public function addTween(tween:Dynamic):Dynamic;
	
	/**
	* Advances the timeline to the specified position.
	* @param value The position to seek to in milliseconds (or ticks if useTicks is true).
	* @param actionsMode Optional parameter specifying how actions are handled. See Tween.setPosition for more details.
	*/
	public function setPosition(value:Dynamic, ?actionsMode:Dynamic):Dynamic;
	
	/**
	* Advances this timeline by the specified amount of time in milliseconds (or ticks if useTicks is true).
	*	This is normally called automatically by the Tween engine (via Tween.tick), but is exposed for advanced uses.
	* @param delta The time to advance in milliseconds (or ticks if useTicks is true).
	*/
	public function tick(delta:Dynamic):Dynamic;
	
	/**
	* Defines labels for use with gotoAndPlay/Stop. Overwrites any previously set labels.
	* @param o An object defining labels for using gotoAndPlay/Stop in the form  where time is in ms (or ticks if useTicks is true).
	*/
	public function addLabel(o:LabelName:time):Dynamic;
	
	/**
	* If a numeric position is passed, it is returned unchanged. If a string is passed, the position of the
	*	corresponding frame label will be returned, or null if a matching label is not defined.
	* @param positionOrLabel A numeric position value or label string.
	*/
	public function resolve(positionOrLabel:Dynamic):Dynamic;
	
	/**
	* Initialization method.
	*/
	private function initialize():Dynamic;
	
	/**
	* Pauses or plays this timeline.
	* @param value Indicates whether the tween should be paused (true) or played (false).
	*/
	public function setPaused(value:Dynamic):Dynamic;
	
	/**
	* Pauses this timeline and jumps to the specified position or label.
	* @param positionOrLabel The position in milliseconds (or ticks if useTicks is true) or label to jump to.
	*/
	public function gotoAndStop(positionOrLabel:Dynamic):Dynamic;
	
	/**
	* Recalculates the duration of the timeline.
	*	The duration is automatically updated when tweens are added or removed, but this method is useful 
	*	if you modify a tween after it was added to the timeline.
	*/
	public function updateDuration():Dynamic;
	
	/**
	* Removes one or more tweens from this timeline.
	* @param tween The tween(s) to remove. Accepts multiple arguments.
	*/
	public function removeTween(tween:Dynamic):Dynamic;
	
	/**
	* Returns a string representation of this object.
	*/
	public function toString():String;
	
	/**
	* The Timeline class synchronizes multiple tweens and allows them to be controlled as a group. Please note that if a
	*	timeline is looping, the tweens on it may appear to loop even if the "loop" property of the tween is false.
	* @param tweens An array of Tweens to add to this timeline. See addTween for more info.
	* @param labels An object defining labels for using gotoAndPlay/Stop. See }{{/crossLink}}
	*	for details.
	* @param props The configuration properties to apply to this tween instance (ex. ). All properties default to
	*	false. Supported props are:<UL>
	*	   <LI> loop: sets the loop property on this tween.</LI>
	*	   <LI> useTicks: uses ticks for all durations instead of milliseconds.</LI>
	*	   <LI> ignoreGlobalPause: sets the ignoreGlobalPause property on this tween.</LI>
	*	   <LI> paused: indicates whether to start the tween paused.</LI>
	*	   <LI> position: indicates the initial position for this timeline.</LI>
	*	   <LI> onChanged: specifies an onChange handler for this timeline.</LI>
	*	</UL>
	*/
	public function new(tweens:Void, labels:Dynamic, props:Loop:true):Void;
	
	/**
	* Unpauses this timeline and jumps to the specified position or label.
	* @param positionOrLabel The position in milliseconds (or ticks if useTicks is true) or label to jump to.
	*/
	public function gotoAndPlay(positionOrLabel:Dynamic):Dynamic;
	private function _goto():Dynamic;
	private function clone():Dynamic;
}
