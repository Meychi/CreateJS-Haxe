package createjs.tweenjs;

/**
* The Timeline class synchronizes multiple tweens and allows them to be controlled as a group. Please note that if a
*	timeline is looping, the tweens on it may appear to loop even if the "loop" property of the tween is false.
*/
@:native("createjs.Timeline")
extern class Timeline extends EventDispatcher
{
	/**
	* Causes this timeline to continue playing when a global pause is active.
	*/
	public var ignoreGlobalPause:Bool;
	
	/**
	* If true, the timeline will loop when it reaches the end. Can be set via the props param.
	*/
	public var loop:Bool;
	
	/**
	* Indicates whether the timeline is currently registered with Tween.
	*/
	private var _registered:Boolean;
	
	/**
	* The current normalized position of the timeline. This will always be a value between 0 and {{#crossLink "Timeline/duration:property"}}{{/crossLink}}. Changing this property directly will have no effect.
	*/
	public var position:Dynamic;
	
	/**
	* The total duration of this timeline in milliseconds (or ticks if `useTicks `is `true`). This value is usually automatically updated as you modify the timeline. See {{#crossLink "Timeline/updateDuration"}}{{/crossLink}} for more information.
	*/
	public var duration:Float;
	
	private var _labelList:Array<Object>;
	
	private var _labels:Dynamic;
	
	private var _paused:Bool;
	
	private var _prevPos:Float;
	
	private var _prevPosition:Float;
	
	private var _tweens:Array<Tween>;
	
	private var _useTicks:Bool;
	
	/**
	* Adds a label that can be used with {{#crossLink "Timeline/gotoAndPlay"}}{{/crossLink}}/{{#crossLink "Timeline/gotoAndStop"}}{{/crossLink}}.
	* @param label The label name.
	* @param position The position this label represents.
	*/
	public function addLabel(label:String, position:Float):Dynamic;
	
	/**
	* Adds one or more tweens (or timelines) to this timeline. The tweens will be paused (to remove them from the
	*	normal ticking system) and managed by this timeline. Adding a tween to multiple timelines will result in
	*	unexpected behaviour.
	* @param tween The tween(s) to add. Accepts multiple arguments.
	*/
	public function addTween(tween:Tween):Tween;
	
	/**
	* Advances the timeline to the specified position.
	* @param value The position to seek to in milliseconds (or ticks if `useTicks` is `true`).
	* @param actionsMode parameter specifying how actions are handled. See the Tween {{#crossLink "Tween/setPosition"}}{{/crossLink}}
	*	method for more details.
	*/
	public function setPosition(value:Float, ?actionsMode:Float):Bool;
	
	/**
	* Advances this timeline by the specified amount of time in milliseconds (or ticks if `useTicks` is `true`).
	*	This is normally called automatically by the Tween engine (via the {{#crossLink "Tween/tick:event"}}{{/crossLink}}
	*	event), but is exposed for advanced uses.
	* @param delta The time to advance in milliseconds (or ticks if useTicks is true).
	*/
	public function tick(delta:Float):Dynamic;
	
	/**
	* Defines labels for use with gotoAndPlay/Stop. Overwrites any previously set labels.
	* @param o An object defining labels for using {{#crossLink "Timeline/gotoAndPlay"}}{{/crossLink}}/{{#crossLink "Timeline/gotoAndStop"}}{{/crossLink}}
	*	in the form `{labelName:time}` where time is in milliseconds (or ticks if `useTicks` is `true`).
	*/
	public function setLabels(o:Dynamic):Dynamic;
	
	/**
	* If a numeric position is passed, it is returned unchanged. If a string is passed, the position of the
	*	corresponding frame label will be returned, or `null` if a matching label is not defined.
	* @param positionOrLabel A numeric position value or label string.
	*/
	public function resolve(positionOrLabel:Dynamic):Dynamic;
	
	/**
	* Pauses or plays this timeline.
	* @param value Indicates whether the tween should be paused (`true`) or played (`false`).
	*/
	public function setPaused(value:Bool):Dynamic;
	
	/**
	* Pauses this timeline and jumps to the specified position or label.
	* @param positionOrLabel The position in milliseconds (or ticks if `useTicks` is `true`) or label
	*	to jump to.
	*/
	public function gotoAndStop(positionOrLabel:Dynamic):Dynamic;
	
	/**
	* Recalculates the duration of the timeline. The duration is automatically updated when tweens are added or removed,
	*	but this method is useful if you modify a tween after it was added to the timeline.
	*/
	public function updateDuration():Dynamic;
	
	/**
	* Removes one or more tweens from this timeline.
	* @param tween The tween(s) to remove. Accepts multiple arguments.
	*/
	public function removeTween(tween:Tween):Dynamic;
	
	/**
	* Returns a sorted list of the labels defined on this timeline.
	*/
	public function getLabels():Array<Object>;
	
	/**
	* Returns a string representation of this object.
	*/
	public function toString():String;
	
	/**
	* Returns the name of the label on or immediately before the current position. For example, given a timeline with
	*	two labels, "first" on frame index 4, and "second" on frame 8, getCurrentLabel would return:
	*	<UL>
	*			<LI>null if the current position is 2.</LI>
	*			<LI>"first" if the current position is 4.</LI>
	*			<LI>"first" if the current position is 7.</LI>
	*			<LI>"second" if the current position is 15.</LI>
	*	</UL>
	*/
	public function getCurrentLabel():String;
	
	/**
	* The Timeline class synchronizes multiple tweens and allows them to be controlled as a group. Please note that if a
	*	timeline is looping, the tweens on it may appear to loop even if the "loop" property of the tween is false.
	* @param tweens An array of Tweens to add to this timeline. See {{#crossLink "Timeline/addTween"}}{{/crossLink}}
	*	for more info.
	* @param labels An object defining labels for using {{#crossLink "Timeline/gotoAndPlay"}}{{/crossLink}}/{{#crossLink "Timeline/gotoAndStop"}}{{/crossLink}}.
	*	See {{#crossLink "Timeline/setLabels"}}{{/crossLink}}
	*	for details.
	* @param props The configuration properties to apply to this tween instance (ex. `{loop:true}`). All properties
	*	default to false. Supported props are:<UL>
	*	   <LI> loop: sets the loop property on this tween.</LI>
	*	   <LI> useTicks: uses ticks for all durations instead of milliseconds.</LI>
	*	   <LI> ignoreGlobalPause: sets the ignoreGlobalPause property on this tween.</LI>
	*	   <LI> paused: indicates whether to start the tween paused.</LI>
	*	   <LI> position: indicates the initial position for this timeline.</LI>
	*	   <LI> onChange: specifies a listener to add for the {{#crossLink "Timeline/change:event"}}{{/crossLink}} event.</LI>
	*	</UL>
	*/
	public function new(tweens:Array<Dynamic>, labels:Dynamic, props:Dynamic):Void;
	
	/**
	* Unpauses this timeline and jumps to the specified position or label.
	* @param positionOrLabel The position in milliseconds (or ticks if `useTicks` is `true`)
	*	or label to jump to.
	*/
	public function gotoAndPlay(positionOrLabel:Dynamic):Dynamic;
	
	private function _calcPosition(value:Float):Float;
	
	private function _goto(positionOrLabel:Dynamic):Dynamic;
	
	private function clone():Dynamic;
	
}
