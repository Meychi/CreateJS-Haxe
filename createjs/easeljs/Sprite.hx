package createjs.easeljs;

import js.html.CanvasRenderingContext2D;

/**
* Displays a frame or sequence of frames (ie. an animation) from a SpriteSheet instance. A sprite sheet is a series of
*	images (usually animation frames) combined into a single image. For example, an animation consisting of 8 100x100
*	images could be combined into a 400x200 sprite sheet (4 frames across by 2 high). You can display individual frames,
*	play frames as an animation, and even sequence animations together.
*	
*	See the {{#crossLink "SpriteSheet"}}{{/crossLink}} class for more information on setting up frames and animations.
*	
*	<h4>Example</h4>
*	
*	     var instance = new createjs.Sprite(spriteSheet);
*	     instance.gotoAndStop("frameName");
*	
*	Until {{#crossLink "Sprite/gotoAndStop"}}{{/crossLink}} or {{#crossLink "Sprite/gotoAndPlay"}}{{/crossLink}} is called,
*	only the first defined frame defined in the sprite sheet will be displayed.
*/
@:native("createjs.Sprite")
extern class Sprite extends DisplayObject
{
	/**
	* By default Sprite instances advance one frame per tick. Specifying a framerate for the Sprite (or its related SpriteSheet) will cause it to advance based on elapsed time between ticks as appropriate to maintain the target framerate.  For example, if a Sprite with a framerate of 10 is placed on a Stage being updated at 40fps, then the Sprite will advance roughly one frame every 4 ticks. This will not be exact, because the time between each tick will vary slightly between frames.  This feature is dependent on the tick event object (or an object with an appropriate "delta" property) being passed into {{#crossLink "Stage/update"}}{{/crossLink}}.
	*/
	public var framerate:Float;
	
	/**
	* Current animation object.
	*/
	private var _animation:Dynamic;
	
	/**
	* Current frame index.
	*/
	private var _currentFrame:Float;
	
	/**
	* Dispatches the "animationend" event. Returns true if a handler changed the animation (ex. calling {{#crossLink "Sprite/stop"}}{{/crossLink}}, {{#crossLink "Sprite/gotoAndPlay"}}{{/crossLink}}, etc.)
	*/
	private var _dispatchAnimationEnd:Dynamic;
	
	/**
	* Prevents the animation from advancing each tick automatically. For example, you could create a sprite sheet of icons, set paused to true, and display the appropriate icon by setting <code>currentFrame</code>.
	*/
	public var paused:Bool;
	
	/**
	* Returns the name of the currently playing animation.
	*/
	public var currentAnimation:String;
	
	/**
	* Skips the next auto advance. Used by gotoAndPlay to avoid immediately jumping to the next frame
	*/
	private var _skipAdvance:Bool;
	
	/**
	* Specifies the current frame index within the currently playing animation. When playing normally, this will increase from 0 to n-1, where n is the number of frames in the current animation.  This could be a non-integer value if using time-based playback (see {{#crossLink "Sprite/framerate"}}{{/crossLink}}, or if the animation's speed is not an integer.
	*/
	public var currentAnimationFrame:Float;
	
	/**
	* The frame index that will be drawn when draw is called. Note that with some {{#crossLink "SpriteSheet"}}{{/crossLink}} definitions, this will advance non-sequentially. This will always be an integer value.
	*/
	public var currentFrame:Float;
	
	/**
	* The SpriteSheet instance to play back. This includes the source image, frame dimensions, and frame data. See {{#crossLink "SpriteSheet"}}{{/crossLink}} for more information.
	*/
	public var spriteSheet:SpriteSheet;
	
	/**
	* Advances the <code>currentFrame</code> if paused is not true. This is called automatically when the {{#crossLink "Stage"}}{{/crossLink}}
	*	ticks.
	* @param evtObj An event object that will be dispatched to all tick listeners. This object is reused between dispatchers to reduce construction & GC costs.
	*/
	//private function _tick(evtObj:Dynamic):Dynamic;
	
	/**
	* Advances the playhead. This occurs automatically each tick by default.
	* @param time The amount of time in ms to advance by. Only applicable if framerate is set on the Sprite
	*	or its SpriteSheet.
	*/
	public function advance(?time:Float):Dynamic;
	
	/**
	* Because the content of a Sprite is already in a raster format, cache is unnecessary for Sprite instances.
	*	You should not cache Sprite instances as it can degrade performance.
	*/
	//public function cache():Dynamic;
	
	/**
	* Because the content of a Sprite is already in a raster format, cache is unnecessary for Sprite instances.
	*	You should not cache Sprite instances as it can degrade performance.
	*/
	//public function uncache():Dynamic;
	
	/**
	* Because the content of a Sprite is already in a raster format, cache is unnecessary for Sprite instances.
	*	You should not cache Sprite instances as it can degrade performance.
	*/
	//public function updateCache():Dynamic;
	
	/**
	* Constructor alias for backwards compatibility. This method will be removed in future versions.
	*	Subclasses should be updated to use {{#crossLink "Utility Methods/extends"}}{{/crossLink}}.
	*/
	public function initialize():Dynamic;
	
	/**
	* Displays a frame or sequence of frames (ie. an animation) from a SpriteSheet instance. A sprite sheet is a series of
	*	images (usually animation frames) combined into a single image. For example, an animation consisting of 8 100x100
	*	images could be combined into a 400x200 sprite sheet (4 frames across by 2 high). You can display individual frames,
	*	play frames as an animation, and even sequence animations together.
	*	
	*	See the {{#crossLink "SpriteSheet"}}{{/crossLink}} class for more information on setting up frames and animations.
	*	
	*	<h4>Example</h4>
	*	
	*	     var instance = new createjs.Sprite(spriteSheet);
	*	     instance.gotoAndStop("frameName");
	*	
	*	Until {{#crossLink "Sprite/gotoAndStop"}}{{/crossLink}} or {{#crossLink "Sprite/gotoAndPlay"}}{{/crossLink}} is called,
	*	only the first defined frame defined in the sprite sheet will be displayed.
	* @param spriteSheet The SpriteSheet instance to play back. This includes the source image(s), frame
	*	dimensions, and frame data. See {{#crossLink "SpriteSheet"}}{{/crossLink}} for more information.
	* @param frameOrAnimation The frame number or animation to play initially.
	*/
	public function new(spriteSheet:SpriteSheet, ?frameOrAnimation:Dynamic):Void;
	
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
	* Moves the playhead to the specified frame number or animation.
	* @param frameOrAnimation The frame number or animation that the playhead should move to.
	* @param frame The frame of the animation to go to. Defaults to 0.
	*/
	private function _goto(frameOrAnimation:Dynamic, ?frame:Bool):Dynamic;
	
	/**
	* Normalizes the current frame, advancing animations and dispatching callbacks as appropriate.
	*/
	private function _normalizeFrame():Dynamic;
	
	/**
	* Play (unpause) the current animation. The Sprite will be paused if either {{#crossLink "Sprite/stop"}}{{/crossLink}}
	*	or {{#crossLink "Sprite/gotoAndStop"}}{{/crossLink}} is called. Single frame animations will remain
	*	unchanged.
	*/
	public function play():Dynamic;
	
	/**
	* Returns a clone of the Sprite instance. Note that the same SpriteSheet is shared between cloned
	*	instances.
	*/
	//public function clone():Sprite;
	
	/**
	* Returns a string representation of this object.
	*/
	//public function toString():String;
	
	/**
	* Returns a {{#crossLink "Rectangle"}}{{/crossLink}} instance defining the bounds of the current frame relative to
	*	the origin. For example, a 90 x 70 frame with <code>regX=50</code> and <code>regY=40</code> would return a
	*	rectangle with [x=-50, y=-40, width=90, height=70]. This ignores transformations on the display object.
	*	
	*	Also see the SpriteSheet {{#crossLink "SpriteSheet/getFrameBounds"}}{{/crossLink}} method.
	*/
	//public function getBounds():Rectangle;
	
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
	* Stop playing a running animation. The Sprite will be playing if {{#crossLink "Sprite/gotoAndPlay"}}{{/crossLink}}
	*	is called. Note that calling {{#crossLink "Sprite/gotoAndPlay"}}{{/crossLink}} or {{#crossLink "Sprite/play"}}{{/crossLink}}
	*	will resume playback.
	*/
	public function stop():Dynamic;
	
	//private function _cloneProps(o:Sprite):Sprite;
	
}
