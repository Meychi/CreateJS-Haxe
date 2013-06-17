package createjs.easeljs;

/**
* The SpriteSheetBuilder allows you to generate sprite sheets at run time from any display object. This can allow
*	you to maintain your assets as vector graphics (for low file size), and render them at run time as sprite sheets
*	for better performance.
*	
*	Sprite sheets can be built either synchronously, or asynchronously, so that large sprite sheets can be generated
*	without locking the UI.
*	
*	Note that the "images" used in the generated sprite sheet are actually canvas elements, and that they will be sized
*	to the nearest power of 2 up to the value of <code>maxWidth</code> or <code>maxHeight</code>.
*/
@:native("createjs.SpriteSheetBuilder")
extern class SpriteSheetBuilder
{
	
	/**
	* A number from 0.01 to 0.99 that indicates what percentage of time the builder can use. This can be thought of as the number of seconds per second the builder will use. For example, with a timeSlice value of 0.3, the builder will run 20 times per second, using approximately 15ms per build (30% of available time, or 0.3s per second). Defaults to 0.3.
	*/
	public var timeSlice:Float;
	
	/**
	* Callback function to call when a build completes. Called with a single parameter pointing back to this instance.
	*/
	public var onComplete:Dynamic;
	
	/**
	* Callback to call when an asynchronous build has progress. Called with two parameters, a reference back to this instance, and the current progress value (0-1).
	*/
	public var onProgress:Dynamic;
	
	/**
	* Read-only. A value between 0 and 1 that indicates the progress of a build, or -1 if a build has not been initiated.
	*/
	public var progress:Float;
	
	/**
	* The maximum height for the images (not individual frames) in the generated sprite sheet. It is recommended to use a power of 2 for this value (ex. 1024, 2048, 4096). If the frames cannot all fit within the max dimensions, then additional images will be created as needed.
	*/
	public var maxHeight:Float;
	
	/**
	* The maximum width for the images (not individual frames) in the generated sprite sheet. It is recommended to use a power of 2 for this value (ex. 1024, 2048, 4096). If the frames cannot all fit within the max dimensions, then additional images will be created as needed.
	*/
	public var maxWidth:Float;
	
	/**
	* The padding to use between frames. This is helpful to preserve antialiasing on drawn vector content.
	*/
	public var padding:Float;
	
	/**
	* The scale to apply when drawing all frames to the sprite sheet. This is multiplied against any scale specified in the addFrame call. This can be used, for example, to generate a sprite sheet at run time that is tailored to the a specific device resolution (ex. tablet vs mobile).
	*/
	public var defaultScale:Float;
	
	/**
	* The sprite sheet that was generated. This will be null before a build is completed successfully.
	*/
	public var spriteSheet:SpriteSheet;
	private var _animations:Array<Dynamic>;
	private var _data:Array<Dynamic>;
	private var _frames:Array<Dynamic>;
	private var _index:Float;
	private var _nextFrameIndex:Float;
	private var _scale:Float;
	private var _timerID:Float;
	
	/**
	* Adds a frame to the {{#crossLink "SpriteSheet"}}{{/crossLink}}. Note that the frame will not be drawn until you
	*	call {{#crossLink "SpriteSheetBuilder/build"}}{{/crossLink}} method. The optional setup params allow you to have
	*	a function run immediately before the draw occurs. For example, this allows you to add a single source multiple
	*	times, but manipulate it or it's children to change it to generate different frames.
	*	
	*	Note that the source's transformations (x, y, scale, rotate, alpha) will be ignored, except for regX/Y. To apply
	*	transforms to a source object and have them captured in the sprite sheet, simply place it into a {{#crossLink "Container"}}{{/crossLink}}
	*	and pass in the Container as the source.
	* @param source The source {{#crossLink "DisplayObject"}}{{/crossLink}}  to draw as the frame.
	* @param sourceRect A {{#crossLink "Rectangle"}}{{/crossLink}} defining the portion of the
	*	source to draw to the frame. If not specified, it will look for a <code>getBounds</code> method, bounds property,
	*	or <code>nominalBounds</code> property on the source to use. If one is not found, the frame will be skipped.
	* @param scale Optional. The scale to draw this frame at. Default is 1.
	* @param setupFunction Optional. A function to call immediately before drawing this frame.
	* @param setupParams Parameters to pass to the setup function.
	* @param setupScope The scope to call the setupFunction in.
	*/
	public function addFrame(source:DisplayObject, ?sourceRect:Rectangle, ?scale:Float, ?setupFunction:Dynamic, ?setupParams:Array<Dynamic>, ?setupScope:Dynamic):Float;
	
	/**
	* Adds an animation that will be included in the created sprite sheet.
	* @param name The name for the animation.
	* @param frames An array of frame indexes that comprise the animation. Ex. [3,6,5] would describe an animation
	*	that played frame indexes 3, 6, and 5 in that order.
	* @param next Specifies the name of the animation to continue to after this animation ends. You can
	*	also pass false to have the animation stop when it ends. By default it will loop to the start of the same animation.
	* @param frequency Specifies a frame advance frequency for this animation. For example, a value
	*	of 2 would cause the animation to advance every second tick.
	*/
	public function addAnimation(name:String, frames:Array<Dynamic>, ?next:String, ?frequency:Float):Dynamic;
	
	/**
	* Asynchronously builds a {{#crossLink "SpriteSheet"}}{{/crossLink}} instance based on the current frames. It will
	*	run 20 times per second, using an amount of time defined by <code>timeSlice</code>. When it is complete it will
	*	call the specified callback.
	* @param timeSlice Sets the timeSlice property on this instance.
	*/
	public function buildAsync(?timeSlice:Float):Dynamic;
	
	/**
	* Builds a SpriteSheet instance based on the current frames.
	*/
	public function build():Dynamic;
	
	/**
	* Initialization method.
	*/
	private function initialize():Dynamic;
	
	/**
	* Returns a string representation of this object.
	*/
	public function toString():String;
	
	/**
	* SpriteSheetBuilder instances cannot be cloned.
	*/
	public function clone():Dynamic;
	
	/**
	* Stops the current asynchronous build.
	*/
	public function stopAsync():Dynamic;
	
	/**
	* The SpriteSheetBuilder allows you to generate sprite sheets at run time from any display object. This can allow
	*	you to maintain your assets as vector graphics (for low file size), and render them at run time as sprite sheets
	*	for better performance.
	*	
	*	Sprite sheets can be built either synchronously, or asynchronously, so that large sprite sheets can be generated
	*	without locking the UI.
	*	
	*	Note that the "images" used in the generated sprite sheet are actually canvas elements, and that they will be sized
	*	to the nearest power of 2 up to the value of <code>maxWidth</code> or <code>maxHeight</code>.
	*/
	public function new():Void;
	
	/**
	* This will take a MovieClip, and add its frames and labels to this builder. Labels will be added as an animation
	*	running from the label index to the next label. For example, if there is a label named "foo" at frame 0 and a label
	*	named "bar" at frame 10, in a MovieClip with 15 frames, it will add an animation named "foo" that runs from frame
	*	index 0 to 9, and an animation named "bar" that runs from frame index 10 to 14.
	*	
	*	Note that this will iterate through the full MovieClip with actionsEnabled set to false, ending on the last frame.
	* @param source The source MovieClip to add to the sprite sheet.
	* @param sourceRect A {{#crossLink "Rectangle"}}{{/crossLink}} defining the portion of the source to
	*	draw to the frame. If not specified, it will look for a <code>getBounds</code> method, <code>frameBounds</code>
	*	Array, <code>bounds</code> property, or <code>nominalBounds</code> property on the source to use. If one is not
	*	found, the MovieClip will be skipped.
	* @param scale The scale to draw the movie clip at.
	*/
	public function addMovieClip(source:MovieClip, ?sourceRect:Rectangle, ?scale:Float):Dynamic;
	private function _drawNext():Dynamic;
	private function _endBuild():Dynamic;
	private function _fillRow():Float;
	private function _run():Dynamic;
	private function _startBuild():Dynamic;
}
