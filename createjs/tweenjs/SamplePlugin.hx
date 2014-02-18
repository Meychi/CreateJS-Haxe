package createjs.tweenjs;

/**
* A sample TweenJS plugin. This plugin does not actually affect tweens in any way, it's merely intended to document
*	how to build TweenJS plugins. Please look at the code for inline comments.
*	
*	A TweenJS plugin is simply an object that exposes one property (priority), and three methods (init, step, and tween).
*	Generally a plugin will also expose an <code>install</code> method as well, though this is not strictly necessary.
*/
@:native("createjs.SamplePlugin")
extern class SamplePlugin
{
	/**
	* Used by TweenJS to determine when to call this plugin. Plugins with higher priority have their methods called before plugins with lower priority. The priority value can be any positive or negative number.
	*/
	public static var priority:Dynamic;
	
	/**
	* A sample TweenJS plugin. This plugin does not actually affect tweens in any way, it's merely intended to document
	*	how to build TweenJS plugins. Please look at the code for inline comments.
	*	
	*	A TweenJS plugin is simply an object that exposes one property (priority), and three methods (init, step, and tween).
	*	Generally a plugin will also expose an <code>install</code> method as well, though this is not strictly necessary.
	*/
	public function new():Void;
	
	/**
	* Called by TweenJS when a new step is added to a tween that includes a property the plugin is registered for (ie.
	*	a new "to" action is added to a tween).
	* @param tween The related tween instance.
	* @param prop The name of the property being tweened.
	* @param startValue The value of the property at the beginning of the step. This will
	*	be the same as the init value if this is the first step, or the same as the
	*	endValue of the previous step if not.
	* @param injectProps A generic object to which the plugin can append other properties which should be updated on this step.
	* @param endValue The value of the property at the end of the step.
	*/
	public static function init(tween:Tween, prop:String, startValue:Dynamic, injectProps:Dynamic, endValue:Dynamic):Dynamic;
	
	/**
	* Called when a tween property advances that this plugin is registered for.
	* @param tween The related tween instance.
	* @param prop The name of the property being tweened.
	* @param value The current tweened value of the property, as calculated by TweenJS.
	* @param startValues A hash of all of the property values at the start of the current
	*	step. You could access the start value of the current property using
	*	startValues[prop].
	* @param endValues A hash of all of the property values at the end of the current
	*	step.
	* @param ratio A value indicating the eased progress through the current step. This
	*	number is generally between 0 and 1, though some eases will generate values outside
	*	this range.
	* @param wait Indicates whether the current step is a "wait" step.
	* @param end Indicates that the tween has reached the end.
	*/
	public static function tween(tween:Tween, prop:String, value:Dynamic, startValues:Dynamic, endValues:Dynamic, ratio:Float, wait:Bool, end:Bool):Dynamic;
	
	/**
	* Installs this plugin for use with TweenJS, and registers for a list of properties that this plugin will operate
	*	with. Call this once after TweenJS is loaded to enable this plugin.
	*/
	public static function install():Dynamic;
	
}
