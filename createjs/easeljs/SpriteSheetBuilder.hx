package createjs.easeljs;

/**
* The SpriteSheetBuilder allows you to generate {{#crossLink "SpriteSheet"}}{{/crossLink}} instances at run time
*	from any display object. This can allow you to maintain your assets as vector graphics (for low file size), and
*	render them at run time as SpriteSheets for better performance.
*	
*	SpriteSheets can be built either synchronously, or asynchronously, so that large SpriteSheets can be generated
*	without locking the UI.
*	
*	Note that the "images" used in the generated SpriteSheet are actually canvas elements, and that they will be
*	sized to the nearest power of 2 up to the value of {{#crossLink "SpriteSheetBuilder/maxWidth:property"}}{{/crossLink}}
*	or {{#crossLink "SpriteSheetBuilder/maxHeight:property"}}{{/crossLink}}.
*/
@:native("createjs.SpriteSheetBuilder")
extern class SpriteSheetBuilder extends EventDispatcher
{
	/**
	* A number from 0.01 to 0.99 that indicates what percentage of time the builder can use. This can be thought of as the number of seconds per second the builder will use. For example, with a timeSlice value of 0.3, the builder will run 20 times per second, using approximately 15ms per build (30% of available time, or 0.3s per second). Defaults to 0.3.
	*/
	public var timeSlice:Float;
	
	/**
	* A value between 0 and 1 that indicates the progress of a build, or -1 if a build has not been initiated.
	*/
	public var progress:Float;
	
	/**
	* A {{#crossLink "SpriteSheet/framerate:property"}}{{/crossLink}} value that will be passed to new {{#crossLink "SpriteSheet"}}{{/crossLink}} instances that are created. If no framerate is specified (or it is 0), then SpriteSheets will use the {{#crossLink "Ticker"}}{{/crossLink}} framerate.
	*/
	public var framerate:Float;
	
	/**
	* The maximum height for the images (not individual frames) in the generated SpriteSheet. It is recommended to use a power of 2 for this value (ex. 1024, 2048, 4096). If the frames cannot all fit within the max dimensions, then additional images will be created as needed.
	*/
	public var maxHeight:Float;
	
	/**
	* The maximum width for the images (not individual frames) in the generated SpriteSheet. It is recommended to use a power of 2 for this value (ex. 1024, 2048, 4096). If the frames cannot all fit within the max dimensions, then additional images will be created as needed.
	*/
	public var maxWidth:Float;
	
	/**
	* The padding to use between frames. This is helpful to preserve antialiasing on drawn vector content.
	*/
	public var padding:Float;
	
	/**
	* The scale to apply when drawing all frames to the SpriteSheet. This is multiplied against any scale specified in the addFrame call. This can be used, for example, to generate a SpriteSheet at run time that is tailored to the a specific device resolution (ex. tablet vs mobile).
	*/
	public var scale:Float;
	
	/**
	* The SpriteSheet that was generated. This will be null before a build is completed successfully.
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
	* <strong>REMOVED</strong>. Removed in favor of using `MySuperClass_constructor`.
	*	See {{#crossLink "Utility Methods/extend"}}{{/crossLink}} and {{#crossLink "Utility Methods/promote"}}{{/crossLink}}
	*	for details.
	*	
	*	There is an inheritance tutorial distributed with EaselJS in /tutorials/Inheritance.
	*/
	private function initialize():Dynamic;
	
	/**
	* Adds a frame to the {{#crossLink "SpriteSheet"}}{{/crossLink}}. Note that the frame will not be drawn until you
	*	call {{#crossLink "SpriteSheetBuilder/build"}}{{/crossLink}} method. The optional setup params allow you to have
	*	a function run immediately before the draw occurs. For example, this allows you to add a single source multiple
	*	times, but manipulate it or its children to change it to generate different frames.
	*	
	*	Note that the source's transformations (x, y, scale, rotate, alpha) will be ignored, except for regX/Y. To apply
	*	transforms to a source object and have them captured in the SpriteSheet, simply place it into a {{#crossLink "Container"}}{{/crossLink}}
	*	and pass in the Container as the source.
	* @param source The source {{#crossLink "DisplayObject"}}{{/crossLink}}  to draw as the frame.
	* @param sourceRect A {{#crossLink "Rectangle"}}{{/crossLink}} defining the portion of the
	*	source to draw to the frame. If not specified, it will look for a `getBounds` method, bounds property, or
	*	`nominalBounds` property on the source to use. If one is not found, the frame will be skipped.
	* @param scale Optional. The scale to draw this frame at. Default is 1.
	* @param setupFunction A function to call immediately before drawing this frame. It will be called with two parameters: the source, and setupData.
	* @param setupData Arbitrary setup data to pass to setupFunction as the second parameter.
	*/
	public function addFrame(source:DisplayObject, ?sourceRect:Rectangle, ?scale:Float, ?setupFunction:Dynamic, ?setupData:Dynamic):Float;
	
	/**
	* Adds an animation that will be included in the created {{#crossLink "SpriteSheet"}}{{/crossLink}}.
	* @param name The name for the animation.
	* @param frames An array of frame indexes that comprise the animation. Ex. [3,6,5] would describe an animation
	*	that played frame indexes 3, 6, and 5 in that order.
	* @param next Specifies the name of the animation to continue to after this animation ends. You can
	*	also pass false to have the animation stop when it ends. By default it will loop to the start of the same animation.
	* @param speed Specifies a frame advance speed for this animation. For example, a value of 0.5 would
	*	cause the animation to advance every second tick. Note that earlier versions used `frequency` instead, which had
	*	the opposite effect.
	*/
	public function addAnimation(name:String, frames:Array<Dynamic>, ?next:String, ?speed:Float):Dynamic;
	
	/**
	* Asynchronously builds a {{#crossLink "SpriteSheet"}}{{/crossLink}} instance based on the current frames. It will
	*	run 20 times per second, using an amount of time defined by `timeSlice`. When it is complete it will call the
	*	specified callback.
	* @param timeSlice Sets the timeSlice property on this instance.
	*/
	public function buildAsync(?timeSlice:Float):Dynamic;
	
	/**
	* Builds a {{#crossLink "SpriteSheet"}}{{/crossLink}} instance based on the current frames.
	*/
	public function build():SpriteSheet;
	
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
	* The SpriteSheetBuilder allows you to generate {{#crossLink "SpriteSheet"}}{{/crossLink}} instances at run time
	*	from any display object. This can allow you to maintain your assets as vector graphics (for low file size), and
	*	render them at run time as SpriteSheets for better performance.
	*	
	*	SpriteSheets can be built either synchronously, or asynchronously, so that large SpriteSheets can be generated
	*	without locking the UI.
	*	
	*	Note that the "images" used in the generated SpriteSheet are actually canvas elements, and that they will be
	*	sized to the nearest power of 2 up to the value of {{#crossLink "SpriteSheetBuilder/maxWidth:property"}}{{/crossLink}}
	*	or {{#crossLink "SpriteSheetBuilder/maxHeight:property"}}{{/crossLink}}.
	* @param framerate The {{#crossLink "SpriteSheet/framerate:property"}}{{/crossLink}} of
	*	{{#crossLink "SpriteSheet"}}{{/crossLink}} instances that are created.
	*/
	public function new(?framerate:Float):Void;
	
	/**
	* This will take a {{#crossLink "MovieClip"}}{{/crossLink}} instance, and add its frames and labels to this
	*	builder. Labels will be added as an animation running from the label index to the next label. For example, if
	*	there is a label named "foo" at frame 0 and a label named "bar" at frame 10, in a MovieClip with 15 frames, it
	*	will add an animation named "foo" that runs from frame index 0 to 9, and an animation named "bar" that runs from
	*	frame index 10 to 14.
	*	
	*	Note that this will iterate through the full MovieClip with {{#crossLink "MovieClip/actionsEnabled:property"}}{{/crossLink}}
	*	set to `false`, ending on the last frame.
	* @param source The source MovieClip instance to add to the SpriteSheet.
	* @param sourceRect A {{#crossLink "Rectangle"}}{{/crossLink}} defining the portion of the source to
	*	draw to the frame. If not specified, it will look for a {{#crossLink "DisplayObject/getBounds"}}{{/crossLink}}
	*	method, `frameBounds` Array, `bounds` property, or `nominalBounds` property on the source to use. If one is not
	*	found, the MovieClip will be skipped.
	* @param scale The scale to draw the movie clip at.
	* @param setupFunction A function to call immediately before drawing each frame. It will be called
	*	with three parameters: the source, setupData, and the frame index.
	* @param setupData Arbitrary setup data to pass to setupFunction as the second parameter.
	* @param labelFunction This method will be called for each MovieClip label that is added with four
	*	parameters: the label name, the source MovieClip instance, the starting frame index (in the movieclip timeline)
	*	and the end index. It must return a new name for the label/animation, or `false` to exclude the label.
	*/
	public function addMovieClip(source:MovieClip, ?sourceRect:Rectangle, ?scale:Float, ?setupFunction:Dynamic, ?setupData:Dynamic, ?labelFunction:Dynamic):Dynamic;
	
	private function _drawNext():Dynamic;
	
	private function _endBuild():Dynamic;
	
	private function _fillRow(frames:Array<Dynamic>, y:Float, img:HTMLImageElement, dataFrames:Dynamic, pad:Float):Float;
	
	private function _getSize():Float;
	
	private function _run():Dynamic;
	
	private function _setupMovieClipFrame():Float;
	
	private function _startBuild():Dynamic;
	
}
