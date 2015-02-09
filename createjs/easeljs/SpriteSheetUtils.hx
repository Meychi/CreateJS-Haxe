package createjs.easeljs;

import js.html.CanvasRenderingContext2D;

/**
* The SpriteSheetUtils class is a collection of static methods for working with {{#crossLink "SpriteSheet"}}{{/crossLink}}s.
*	A sprite sheet is a series of images (usually animation frames) combined into a single image on a regular grid. For
*	example, an animation consisting of 8 100x100 images could be combined into a 400x200 sprite sheet (4 frames across
*	by 2 high). The SpriteSheetUtils class uses a static interface and should not be instantiated.
*/
@:native("createjs.SpriteSheetUtils")
extern class SpriteSheetUtils
{
	public static var _workingCanvas:Dynamic;
	
	public static var _workingContext:CanvasRenderingContext2D;
	
	/**
	* <b>This is an experimental method, and may be buggy. Please report issues.</b><br/><br/>
	*	Extends the existing sprite sheet by flipping the original frames horizontally, vertically, or both,
	*	and adding appropriate animation & frame data. The flipped animations will have a suffix added to their names
	*	(_h, _v, _hv as appropriate). Make sure the sprite sheet images are fully loaded before using this method.
	*	<br/><br/>
	*	For example:<br/>
	*	SpriteSheetUtils.addFlippedFrames(mySpriteSheet, true, true);
	*	The above would add frames that are flipped horizontally AND frames that are flipped vertically.
	*	<br/><br/>
	*	Note that you can also flip any display object by setting its scaleX or scaleY to a negative value. On some
	*	browsers (especially those without hardware accelerated canvas) this can result in slightly degraded performance,
	*	which is why addFlippedFrames is available.
	* @param spriteSheet 
	* @param horizontal If true, horizontally flipped frames will be added.
	* @param vertical If true, vertically flipped frames will be added.
	* @param both If true, frames that are flipped both horizontally and vertically will be added.
	*/
	public static function addFlippedFrames(spriteSheet:SpriteSheet, horizontal:Bool, vertical:Bool, both:Bool):Dynamic;
	
	/**
	* Merges the rgb channels of one image with the alpha channel of another. This can be used to combine a compressed
	*	JPEG image containing color data with a PNG32 monochromatic image containing alpha data. With certain types of
	*	images (those with detail that lend itself to JPEG compression) this can provide significant file size savings
	*	versus a single RGBA PNG32. This method is very fast (generally on the order of 1-2 ms to run).
	* @param rbgImage The image (or canvas) containing the RGB channels to use.
	* @param alphaImage The image (or canvas) containing the alpha channel to use.
	* @param canvas Optional. If specified, this canvas will be used and returned. If not, a new canvas will be created.
	*/
	public static function mergeAlpha(rbgImage:HTMLImageElement, alphaImage:HTMLImageElement, canvas:HTMLCanvasElement):HTMLCanvasElement;
	
	/**
	* Returns a single frame of the specified sprite sheet as a new PNG image. An example of when this may be useful is
	*	to use a spritesheet frame as the source for a bitmap fill.
	*	
	*	<strong>WARNING:</strong> In almost all cases it is better to display a single frame using a {{#crossLink "Sprite"}}{{/crossLink}}
	*	with a {{#crossLink "Sprite/gotoAndStop"}}{{/crossLink}} call than it is to slice out a frame using this
	*	method and display it with a Bitmap instance. You can also crop an image using the {{#crossLink "Bitmap/sourceRect"}}{{/crossLink}}
	*	property of {{#crossLink "Bitmap"}}{{/crossLink}}.
	*	
	*	The extractFrame method may cause cross-domain warnings since it accesses pixels directly on the canvas.
	* @param spriteSheet The SpriteSheet instance to extract a frame from.
	* @param frameOrAnimation The frame number or animation name to extract. If an animation
	*	name is specified, only the first frame of the animation will be extracted.
	*/
	public static function extractFrame(spriteSheet:SpriteSheet, frameOrAnimation:Dynamic):HTMLImageElement;
	
}
