package createjs.easeljs;

import js.html.CanvasRenderingContext2D;

/**
* The MovieClip class associates a TweenJS Timeline with an EaselJS {{#crossLink "Container"}}{{/crossLink}}. It allows
*	you to create objects which encapsulate timeline animations, state changes, and synched actions. Due to the
*	complexities inherent in correctly setting up a MovieClip, it is largely intended for tool output and is not included
*	in the main EaselJS library.
*	
*	Currently MovieClip only works properly if it is tick based (as opposed to time based) though some concessions have
*	been made to support time-based timelines in the future.
*	
*	<h4>Example</h4>
*	This example animates two shapes back and forth. The grey shape starts on the left, but we jump to a mid-point in
*	the animation using {{#crossLink "MovieClip/gotoAndPlay"}}{{/crossLink}}.
*	
*	     var stage = new createjs.Stage("canvas");
*	     createjs.Ticker.addEventListener("tick", stage);
*	
*	     var mc = new createjs.MovieClip(null, 0, true, {start:20});
*	     stage.addChild(mc);
*	
*	     var child1 = new createjs.Shape(
*	         new createjs.Graphics().beginFill("#999999")
*	             .drawCircle(30,30,30));
*	     var child2 = new createjs.Shape(
*	         new createjs.Graphics().beginFill("#5a9cfb")
*	             .drawCircle(30,30,30));
*	
*	     mc.timeline.addTween(
*	         createjs.Tween.get(child1)
*	             .to({x:0}).to({x:60}, 50).to({x:0}, 50));
*	     mc.timeline.addTween(
*	         createjs.Tween.get(child2)
*	             .to({x:60}).to({x:0}, 50).to({x:60}, 50));
*	
*	     mc.gotoAndPlay("start");
*	
*	It is recommended to use <code>tween.to()</code> to animate and set properties (use no duration to have it set
*	immediately), and the <code>tween.wait()</code> method to create delays between animations. Note that using the
*	<code>tween.set()</code> method to affect properties will likely not provide the desired result.
*/
@:native("createjs.MovieClip")
extern class MovieClip extends Container
{
	/**
	* An array of bounds for each frame in the MovieClip. This is mainly intended for tool output.
	*/
	public var frameBounds:Array<Dynamic>;
	
	/**
	* Controls how this MovieClip advances its time. Must be one of 0 (INDEPENDENT), 1 (SINGLE_FRAME), or 2 (SYNCHED). See each constant for a description of the behaviour.
	*/
	public var mode:String;
	
	/**
	* If true, actions in this MovieClip's tweens will be run when the playhead advances.
	*/
	public var actionsEnabled:Bool;
	
	/**
	* If true, the MovieClip will automatically be reset to its first frame whenever the timeline adds it back onto the display list. This only applies to MovieClip instances with mode=INDEPENDENT. <br><br> For example, if you had a character animation with a "body" child MovieClip instance with different costumes on each frame, you could set body.autoReset = false, so that you can manually change the frame it is on, without worrying that it will be reset automatically.
	*/
	public var autoReset:Bool;
	
	/**
	* If true, the MovieClip's position will not advance when ticked.
	*/
	public var paused:Bool;
	
	/**
	* Indicates whether this MovieClip should loop when it reaches the end of its timeline.
	*/
	public var loop:Bool;
	
	/**
	* List of display objects that are actively being managed by the MovieClip.
	*/
	private var _managed:Dynamic;
	
	/**
	* Specifies what the first frame to play in this movieclip, or the only frame to display if mode is SINGLE_FRAME.
	*/
	public var startPosition:Float;
	
	/**
	* The build date for this release in UTC format.
	*/
	public static var buildDate:String;
	
	/**
	* The current frame of the movieclip.
	*/
	public var currentFrame:Float;
	
	/**
	* The MovieClip will advance independently of its parent, even if its parent is paused. This is the default mode.
	*/
	public static var INDEPENDENT:String;
	
	/**
	* The MovieClip will be advanced only when its parent advances and will be synched to the position of the parent MovieClip.
	*/
	public static var SYNCHED:String;
	
	/**
	* The MovieClip will only display a single frame (as determined by the startPosition property).
	*/
	public static var SINGLE_FRAME:String;
	
	/**
	* The TweenJS Timeline that is associated with this MovieClip. This is created automatically when the MovieClip instance is initialized. Animations are created by adding <a href="http://tweenjs.com">TweenJS</a> Tween instances to the timeline.  <h4>Example</h4>      var tween = createjs.Tween.get(target).to({x:0}).to({x:100}, 30);      var mc = new createjs.MovieClip();      mc.timeline.addTween(tween);  Elements can be added and removed from the timeline by toggling an "_off" property using the <code>tweenInstance.to()</code> method. Note that using <code>Tween.set</code> is not recommended to create MovieClip animations. The following example will toggle the target off on frame 0, and then back on for frame 1. You can use the "visible" property to achieve the same effect.       var tween = createjs.Tween.get(target).to({_off:false})          .wait(1).to({_off:true})          .wait(1).to({_off:false});
	*/
	public var timeline:Timeline;
	
	/**
	* The version string for this release.
	*/
	public static var version:String;
	
	private var _prevPos:Float;
	
	private var _prevPosition:Float;
	
	private var _synchOffset:Float;
	
	private var Container__tick:Dynamic;
	
	private var Container_draw:Dynamic;
	
	/**
	* Adds a child to the timeline, and sets it up as a managed child.
	* @param child The child MovieClip to manage
	* @param offset 
	*/
	private function _addManagedChild(child:MovieClip, offset:Float):Dynamic;
	
	/**
	* Advances this movie clip to the specified position or label and sets paused to false.
	* @param positionOrLabel The animation name or frame number to go to.
	*/
	public function gotoAndPlay(positionOrLabel:Dynamic):Dynamic;
	
	/**
	* Advances this movie clip to the specified position or label and sets paused to true.
	* @param positionOrLabel The animation or frame name to go to.
	*/
	public function gotoAndStop(positionOrLabel:Dynamic):Dynamic;
	
	/**
	* Draws the display object into the specified context ignoring its visible, alpha, shadow, and transform.
	*	Returns true if the draw was handled (useful for overriding functionality).
	*	NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
	* @param ctx The canvas 2D context object to draw into.
	* @param ignoreCache Indicates whether the draw operation should ignore any current cache.
	*	For example, used for drawing the cache (to prevent it from simply drawing an existing cache back
	*	into itself).
	*/
	//public function draw(ctx:CanvasRenderingContext2D, ignoreCache:Bool):Dynamic;
	
	/**
	* Initialization method called by the constructor.
	* @param mode Initial value for the mode property. One of MovieClip.INDEPENDENT,
	*	MovieClip.SINGLE_FRAME, or MovieClip.SYNCHED. The default is MovieClip.INDEPENDENT.
	* @param startPosition Initial value for the startPosition property.
	* @param loop Initial value for the loop property. The default is true.
	* @param labels A hash of labels to pass to the timeline instance associated with this MovieClip.
	*	Labels only need to be passed if they need to be used.
	*/
	//private function initialize(?mode:String, ?startPosition:Float, ?loop:Bool, ?labels:Dynamic):Dynamic;
	
	/**
	* MovieClip instances cannot be cloned.
	*/
	//public function clone():Dynamic;
	
	/**
	* Returns a sorted list of the labels defined on this MovieClip. Shortcut to TweenJS: Timeline.getLabels();
	*/
	public function getLabels():Array<Object>;
	
	/**
	* Returns a string representation of this object.
	*/
	//public function toString():String;
	
	/**
	* Returns the name of the label on or immediately before the current frame. See TweenJS: Timeline.getCurrentLabel()
	*	for more information.
	*/
	public function getCurrentLabel():String;
	
	/**
	* Returns true or false indicating whether the display object would be visible if drawn to a canvas.
	*	This does not account for whether it would be visible within the boundaries of the stage.
	*	NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
	*/
	//public function isVisible():Bool;
	
	/**
	* Sets paused to false.
	*/
	public function play():Dynamic;
	
	/**
	* Sets paused to true.
	*/
	public function stop():Dynamic;
	
	/**
	* The MovieClip class associates a TweenJS Timeline with an EaselJS {{#crossLink "Container"}}{{/crossLink}}. It allows
	*	you to create objects which encapsulate timeline animations, state changes, and synched actions. Due to the
	*	complexities inherent in correctly setting up a MovieClip, it is largely intended for tool output and is not included
	*	in the main EaselJS library.
	*	
	*	Currently MovieClip only works properly if it is tick based (as opposed to time based) though some concessions have
	*	been made to support time-based timelines in the future.
	*	
	*	<h4>Example</h4>
	*	This example animates two shapes back and forth. The grey shape starts on the left, but we jump to a mid-point in
	*	the animation using {{#crossLink "MovieClip/gotoAndPlay"}}{{/crossLink}}.
	*	
	*	     var stage = new createjs.Stage("canvas");
	*	     createjs.Ticker.addEventListener("tick", stage);
	*	
	*	     var mc = new createjs.MovieClip(null, 0, true, {start:20});
	*	     stage.addChild(mc);
	*	
	*	     var child1 = new createjs.Shape(
	*	         new createjs.Graphics().beginFill("#999999")
	*	             .drawCircle(30,30,30));
	*	     var child2 = new createjs.Shape(
	*	         new createjs.Graphics().beginFill("#5a9cfb")
	*	             .drawCircle(30,30,30));
	*	
	*	     mc.timeline.addTween(
	*	         createjs.Tween.get(child1)
	*	             .to({x:0}).to({x:60}, 50).to({x:0}, 50));
	*	     mc.timeline.addTween(
	*	         createjs.Tween.get(child2)
	*	             .to({x:60}).to({x:0}, 50).to({x:60}, 50));
	*	
	*	     mc.gotoAndPlay("start");
	*	
	*	It is recommended to use <code>tween.to()</code> to animate and set properties (use no duration to have it set
	*	immediately), and the <code>tween.wait()</code> method to create delays between animations. Note that using the
	*	<code>tween.set()</code> method to affect properties will likely not provide the desired result.
	* @param mode Initial value for the mode property. One of MovieClip.INDEPENDENT,
	*	MovieClip.SINGLE_FRAME, or MovieClip.SYNCHED. The default is MovieClip.INDEPENDENT.
	* @param startPosition Initial value for the startPosition property.
	* @param loop Initial value for the loop property. The default is true.
	* @param labels A hash of labels to pass to the timeline instance associated with this MovieClip.
	*	Labels only need to be passed if they need to be used.
	*/
	public function new(?mode:String, ?startPosition:Float, ?loop:Bool, ?labels:Dynamic):Void;
	
	//private function _getBounds(matrix:Matrix2D, ignoreTransform:Bool):Rectangle;
	
	//private function _tick(params:Array<Dynamic>):Dynamic;
	
	private function _goto(positionOrLabel:Dynamic):Dynamic;
	
	private function _reset():Dynamic;
	
	private function _setState(state:Array<Dynamic>, offset:Float):Dynamic;
	
	private function _updateTimeline():Dynamic;
	
	private function Container__getBounds(matrix:Matrix2D, ignoreTransform:Bool):Rectangle;
	
}
