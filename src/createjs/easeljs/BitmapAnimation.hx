package createjs.easeljs;

import js.html.CanvasRenderingContext2D;
import js.html.Text;

/**
* Displays frames or sequences of frames (ie. animations) from a sprite sheet image. A sprite sheet is a series of
*	images (usually animation frames) combined into a single image. For example, an animation consisting of 8 100x100
*	images could be combined into a 400x200 sprite sheet (4 frames across by 2 high). You can display individual frames,
*	play frames as an animation, and even sequence animations together.
*	
*	See the {{#crossLink "SpriteSheet"}}{{/crossLink}} class for more information on setting up frames and animations.
*	
*	<h4>Example</h4>
*	     var instance = new createjs.BitmapAnimation(spriteSheet);
*	     instance.gotoAndStop("frameName");
*	
*	Currently, you <strong>must</strong> call either {{#crossLink "BitmapAnimation/gotoAndStop"}}{{/crossLink}} or
*	{{#crossLink "BitmapAnimation/gotoAndPlay"}}{{/crossLink}}, or nothing will display on stage.
*/
@:native("createjs.BitmapAnimation")
extern class BitmapAnimation extends DisplayObject
{
	/**
	* Dispatches the "animationend" event. Returns true if a handler changed the animation (ex. calling {{#crossLink "BitmapAnimation/stop"}}{{/crossLink}}, {{#crossLink "BitmapAnimation/gotoAndPlay"}}{{/crossLink}}, etc.)
	*/
	private var _dispatchAnimationEnd:Dynamic;
	
	/**
	* Prevents the animation from advancing each tick automatically. For example, you could create a sprite sheet of icons, set paused to true, and display the appropriate icon by setting <code>currentFrame</code>.
	*/
	public var paused:Bool;
	
	/**
	* Returns the currently playing animation. READ-ONLY.
	*/
	public var currentAnimation:String;
	
	/**
	* Specifies a function to call whenever any animation reaches its end. It will be called with three params: the first will be a reference to this instance, the second will be the name of the animation that just ended, and the third will be the name of the next animation that will be played.
	*/
	public var onAnimationEnd:Dynamic;
	
	/**
	* Specifies the current frame index within the current playing animation. When playing normally, this will increase successively from 0 to n-1, where n is the number of frames in the current animation.
	*/
	public var currentAnimationFrame:Float;
	
	/**
	* The frame that will be drawn when draw is called. Note that with some SpriteSheet data, this will advance non-sequentially. READ-ONLY.
	*/
	public var currentFrame:Float;
	
	/**
	* The SpriteSheet instance to play back. This includes the source image, frame dimensions, and frame data. See {{#crossLink "SpriteSheet"}}{{/crossLink}} for more information.
	*/
	public var spriteSheet:SpriteSheet;
	
	/**
	* When used in conjunction with animations having an frequency greater than 1, this lets you offset which tick the playhead will advance on. For example, you could create two BitmapAnimations, both playing an animation with a frequency of 2, but one having offset set to 1. Both instances would advance every second tick, but they would advance on alternating ticks (effectively, one instance would advance on odd ticks, the other on even ticks).
	*/
	public var offset:Float;
	
	private var _advanceCount:Float;
	
	private var _animation:Dynamic;
	
	private var DisplayObject__tick:Dynamic;
	
	private var DisplayObject_cloneProps:Dynamic;
	
	private var DisplayObject_draw:Dynamic;
	
	private var DisplayObject_initialize:Dynamic;
	
	/**
	* Advances the <code>currentFrame</code> if paused is not true. This is called automatically when the {{#crossLink "Stage"}}{{/crossLink}}
	*	ticks.
	*/
	//private function _tick():Dynamic;
	
	/**
	* Advances the playhead. This occurs automatically each tick by default.
	*/
	public function advance():Dynamic;
	
	/**
	* Because the content of a Bitmap is already in a simple format, cache is unnecessary for Bitmap instances.
	*	You should not cache Bitmap instances as it can degrade performance.
	*/
	//public function cache():Dynamic;
	
	/**
	* Because the content of a Bitmap is already in a simple format, cache is unnecessary for Bitmap instances.
	*	You should not cache Bitmap instances as it can degrade performance.
	*/
	//public function uncache():Dynamic;
	
	/**
	* Because the content of a Bitmap is already in a simple format, cache is unnecessary for Bitmap instances.
	*	You should not cache Bitmap instances as it can degrade performance.
	*/
	//public function updateCache():Dynamic;
	
	/**
	* Begin playing a paused animation. The BitmapAnimation will be paused if either {{#crossLink "BitmapAnimation/stop"}}{{/crossLink}}
	*	or {{#crossLink "BitmapAnimation/gotoAndStop"}}{{/crossLink}} is called. Single frame animations will remain
	*	unchanged.
	*/
	public function play():Dynamic;
	
	/**
	* Displays frames or sequences of frames (ie. animations) from a sprite sheet image. A sprite sheet is a series of
	*	images (usually animation frames) combined into a single image. For example, an animation consisting of 8 100x100
	*	images could be combined into a 400x200 sprite sheet (4 frames across by 2 high). You can display individual frames,
	*	play frames as an animation, and even sequence animations together.
	*	
	*	See the {{#crossLink "SpriteSheet"}}{{/crossLink}} class for more information on setting up frames and animations.
	*	
	*	<h4>Example</h4>
	*	     var instance = new createjs.BitmapAnimation(spriteSheet);
	*	     instance.gotoAndStop("frameName");
	*	
	*	Currently, you <strong>must</strong> call either {{#crossLink "BitmapAnimation/gotoAndStop"}}{{/crossLink}} or
	*	{{#crossLink "BitmapAnimation/gotoAndPlay"}}{{/crossLink}}, or nothing will display on stage.
	* @param spriteSheet The SpriteSheet instance to play back. This includes the source image(s), frame
	*	dimensions, and frame data. See {{#crossLink "SpriteSheet"}}{{/crossLink}} for more information.
	*/
	public function new(spriteSheet:SpriteSheet):Void;
	
	/**
	* Draws the display object into the specified context ignoring it's visible, alpha, shadow, and transform.
	*	Returns true if the draw was handled (useful for overriding functionality).
	*	NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
	* @param ctx The canvas 2D context object to draw into.
	* @param ignoreCache Indicates whether the draw operation should ignore any current cache.
	*	For example, used for drawing the cache (to prevent it from simply drawing an existing cache back
	*	into itself).
	*/
	//public function draw(ctx:CanvasRenderingContext2D, ignoreCache:Bool):Dynamic;
	
	/**
	* Initialization method.
	*/
	//private function initialize():Dynamic;
	
	/**
	* Moves the playhead to the specified frame number or animation.
	* @param frameOrAnimation The frame number or animation that the playhead should move to.
	*/
	private function _goto(frameOrAnimation:Dynamic):Dynamic;
	
	/**
	* Normalizes the current frame, advancing animations and dispatching callbacks as appropriate.
	*/
	private function _normalizeCurrentFrame():Dynamic;
	
	/**
	* Returns a clone of the BitmapAnimation instance. Note that the same SpriteSheet is shared between cloned
	*	instances.
	*/
	//public function clone():BitmapAnimation;
	
	/**
	* Returns a string representation of this object.
	*/
	//public function toString():String;
	
	/**
	* Returns a {{#crossLink "Rectangle"}}{{/crossLink}} instance defining the bounds of the current frame relative to
	*	the origin. For example, a 90 x 70 frame with <code>regX=50</code> and <code>regY=40</code> would return a
	*	rectangle with [x=-50, y=-40, width=90, height=70].
	*	
	*	Also see the SpriteSheet {{#crossLink "SpriteSheet/getFrameBounds"}}{{/crossLink}} method.
	*/
	public function getBounds():Rectangle;
	
	/**
	* Returns true or false indicating whether the display object would be visible if drawn to a canvas.
	*	This does not account for whether it would be visible within the boundaries of the stage.
	*	NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
	*/
	//public function isVisible():Bool;
	
	/**
	* Sets paused to false and plays the specified animation name, named frame, or frame number.
	* @param frameOrAnimation The frame number or animation name that the playhead should move to
	*	and begin playing.
	*/
	public function gotoAndPlay(frameOrAnimation:Dynamic):Dynamic;
	
	/**
	* Sets paused to true and seeks to the specified animation name, named frame, or frame number.
	* @param frameOrAnimation The frame number or animation name that the playhead should move to
	*	and stop.
	*/
	public function gotoAndStop(frameOrAnimation:Dynamic):Dynamic;
	
	/**
	* Stop playing a running animation. The BitmapAnimation will be playing if {{#crossLink "BitmapAnimation/gotoAndPlay"}}{{/crossLink}}
	*	is called. Note that calling {{#crossLink "BitmapAnimation/gotoAndPlay"}}{{/crossLink}} or {{#crossLink "BitmapAnimation/play"}}{{/crossLink}}
	*	will resume playback.
	*/
	public function stop():Dynamic;
	
	//private function cloneProps(o:Text):Dynamic;
	
}
