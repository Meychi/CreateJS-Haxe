package createjs.easeljs;

/**
* Encapsulates the properties and methods associated with a sprite sheet. A sprite sheet is a series of images (usually
*	animation frames) combined into a larger image (or images). For example, an animation consisting of eight 100x100
*	images could be combined into a single 400x200 sprite sheet (4 frames across by 2 high).
*	
*	The data passed to the SpriteSheet constructor defines three critical pieces of information:<ol>
*	   <li> The image or images to use.</li>
*	   <li> The positions of individual image frames. This data can be represented in one of two ways:
*	   As a regular grid of sequential, equal-sized frames, or as individually defined, variable sized frames arranged in
*	   an irregular (non-sequential) fashion.</li>
*	   <li> Likewise, animations can be represented in two ways: As a series of sequential frames, defined by a start and
*	   end frame [0,3], or as a list of frames [0,1,2,3].</li>
*	</OL>
*	
*	<h4>SpriteSheet Format</h4>
*	
*	     data = {
*	
*	         // DEFINING IMAGES:
*	         // list of images or image URIs to use. SpriteSheet can handle preloading.
*	         // the order dictates their index value for frame definition.
*	         images: [image1, "path/to/image2.png"],
*	
*	         // DEFINING FRAMES:
*		        // the simple way to define frames, only requires frame size because frames are consecutive:
*		        // define frame width/height, and optionally the frame count and registration point x/y.
*		        // if count is omitted, it will be calculated automatically based on image dimensions.
*		        frames: {width:64, height:64, count:20, regX: 32, regY:64},
*	
*		        // OR, the complex way that defines individual rects for frames.
*		        // The 5th value is the image index per the list defined in "images" (defaults to 0).
*		        frames: [
*		        	// x, y, width, height, imageIndex, regX, regY
*		        	[0,0,64,64,0,32,64],
*		        	[64,0,96,64,0]
*		        ],
*	
*	         // DEFINING ANIMATIONS:
*	
*		        // simple animation definitions. Define a consecutive range of frames.
*		        // also optionally define a "next" animation name for sequencing.
*		        // setting next to false makes it pause when it reaches the end.
*		        animations: {
*		        	// start, end, next, frequency
*		        	run: [0,8],
*		        	jump: [9,12,"run",2],
*		        	stand: 13
*		        }
*	
*	         // the complex approach which specifies every frame in the animation by index.
*	         animations: {
*	         	run: {
*	         		frames: [1,2,3,3,2,1]
*	         	},
*	         	jump: {
*	         		frames: [1,4,5,6,1],
*	         		next: "run",
*	         		frequency: 2
*	         	},
*	         	stand: { frames: [7] }
*	         }
*	
*		        // the above two approaches can be combined, you can also use a single frame definition:
*		        animations: {
*		        	run: [0,8,true,2],
*		        	jump: {
*		        		frames: [8,9,10,9,8],
*		        		next: "run",
*		        		frequency: 2
*		        	},
*		        	stand: 7
*		        }
*	     }
*	
*	<h4>Example</h4>
*	To define a simple sprite sheet, with a single image "sprites.jpg" arranged in a regular 50x50 grid with two
*	animations, "run" looping from frame 0-4 inclusive, and "jump" playing from frame 5-8 and sequencing back to run:
*	
*	     var data = {
*	         images: ["sprites.jpg"],
*	         frames: {width:50, height:50},
*	         animations: {run:[0,4], jump:[5,8,"run"]}
*	     };
*	     var spriteSheet = new createjs.SpriteSheet(data);
*	     var animation = new createjs.BitmapAnimation(spriteSheet);
*	     animation.gotoAndPlay("run");
*/
@:native("createjs.SpriteSheet")
extern class SpriteSheet
{
	/**
	* Read-only property indicating whether all images are finished loading.
	*/
	public var complete:Bool;
	
	/**
	* The onComplete callback is called when all images are loaded. Note that this only fires if the images were not fully loaded when the sprite sheet was initialized. You should check the complete property  to prior to adding an onComplete handler. Ex. <pre><code>var sheet = new SpriteSheet(data); if (!sheet.complete) {  &nbsp; // not preloaded, listen for onComplete:  &nbsp; sheet.onComplete = handler; }</code></pre>
	*/
	public var onComplete:Dynamic;
	
	private var _animations:Dynamic;
	
	private var _data:Dynamic;
	
	private var _frameHeight:Dynamic;
	
	private var _frames:Dynamic;
	
	private var _frameWidth:Dynamic;
	
	private var _images:Dynamic;
	
	private var _loadCount:Dynamic;
	
	private var _numFrames:Dynamic;
	
	private var _regX:Dynamic;
	
	private var _regY:Dynamic;
	
	/**
	* Encapsulates the properties and methods associated with a sprite sheet. A sprite sheet is a series of images (usually
	*	animation frames) combined into a larger image (or images). For example, an animation consisting of eight 100x100
	*	images could be combined into a single 400x200 sprite sheet (4 frames across by 2 high).
	*	
	*	The data passed to the SpriteSheet constructor defines three critical pieces of information:<ol>
	*	   <li> The image or images to use.</li>
	*	   <li> The positions of individual image frames. This data can be represented in one of two ways:
	*	   As a regular grid of sequential, equal-sized frames, or as individually defined, variable sized frames arranged in
	*	   an irregular (non-sequential) fashion.</li>
	*	   <li> Likewise, animations can be represented in two ways: As a series of sequential frames, defined by a start and
	*	   end frame [0,3], or as a list of frames [0,1,2,3].</li>
	*	</OL>
	*	
	*	<h4>SpriteSheet Format</h4>
	*	
	*	     data = {
	*	
	*	         // DEFINING IMAGES:
	*	         // list of images or image URIs to use. SpriteSheet can handle preloading.
	*	         // the order dictates their index value for frame definition.
	*	         images: [image1, "path/to/image2.png"],
	*	
	*	         // DEFINING FRAMES:
	*		        // the simple way to define frames, only requires frame size because frames are consecutive:
	*		        // define frame width/height, and optionally the frame count and registration point x/y.
	*		        // if count is omitted, it will be calculated automatically based on image dimensions.
	*		        frames: {width:64, height:64, count:20, regX: 32, regY:64},
	*	
	*		        // OR, the complex way that defines individual rects for frames.
	*		        // The 5th value is the image index per the list defined in "images" (defaults to 0).
	*		        frames: [
	*		        	// x, y, width, height, imageIndex, regX, regY
	*		        	[0,0,64,64,0,32,64],
	*		        	[64,0,96,64,0]
	*		        ],
	*	
	*	         // DEFINING ANIMATIONS:
	*	
	*		        // simple animation definitions. Define a consecutive range of frames.
	*		        // also optionally define a "next" animation name for sequencing.
	*		        // setting next to false makes it pause when it reaches the end.
	*		        animations: {
	*		        	// start, end, next, frequency
	*		        	run: [0,8],
	*		        	jump: [9,12,"run",2],
	*		        	stand: 13
	*		        }
	*	
	*	         // the complex approach which specifies every frame in the animation by index.
	*	         animations: {
	*	         	run: {
	*	         		frames: [1,2,3,3,2,1]
	*	         	},
	*	         	jump: {
	*	         		frames: [1,4,5,6,1],
	*	         		next: "run",
	*	         		frequency: 2
	*	         	},
	*	         	stand: { frames: [7] }
	*	         }
	*	
	*		        // the above two approaches can be combined, you can also use a single frame definition:
	*		        animations: {
	*		        	run: [0,8,true,2],
	*		        	jump: {
	*		        		frames: [8,9,10,9,8],
	*		        		next: "run",
	*		        		frequency: 2
	*		        	},
	*		        	stand: 7
	*		        }
	*	     }
	*	
	*	<h4>Example</h4>
	*	To define a simple sprite sheet, with a single image "sprites.jpg" arranged in a regular 50x50 grid with two
	*	animations, "run" looping from frame 0-4 inclusive, and "jump" playing from frame 5-8 and sequencing back to run:
	*	
	*	     var data = {
	*	         images: ["sprites.jpg"],
	*	         frames: {width:50, height:50},
	*	         animations: {run:[0,4], jump:[5,8,"run"]}
	*	     };
	*	     var spriteSheet = new createjs.SpriteSheet(data);
	*	     var animation = new createjs.BitmapAnimation(spriteSheet);
	*	     animation.gotoAndPlay("run");
	* @param data 
	*/
	public function new(data:Void):Void;
	
	/**
	* Returns a clone of the SpriteSheet instance.
	*/
	public function clone():SpriteSheet;
	
	/**
	* Returns a Rectangle instance defining the bounds of the specified frame relative to the origin. For example, a
	*	90 x 70 frame with a regX of 50 and a regY of 40 would return a rectangle with [x=-50, y=-40, width=90, height=70].
	* @param frameIndex The index of the frame.
	*/
	public function getFrameBounds(frameIndex:Float):Rectangle;
	
	/**
	* Returns a string representation of this object.
	*/
	public function toString():String;
	
	/**
	* Returns an array of all available animation names as strings.
	*/
	public function getAnimations():Array<Dynamic>;
	
	/**
	* Returns an object defining the specified animation. The returned object has a
	*	frames property containing an array of the frame id's in the animation, a frequency
	*	property indicating the advance frequency for this animation, a name property, 
	*	and a next property, which specifies the default next animation. If the animation
	*	loops, the name and next property will be the same.
	* @param name The name of the animation to get.
	*/
	public function getAnimation(name:String):Dynamic;
	
	/**
	* Returns an object specifying the image and source rect of the specified frame. The returned object
	*	has an image property holding a reference to the image object in which the frame is found,
	*	and a rect property containing a Rectangle instance which defines the boundaries for the
	*	frame within that image.
	* @param frameIndex The index of the frame.
	*/
	public function getFrame(frameIndex:Float):Dynamic;
	
	/**
	* Returns the total number of frames in the specified animation, or in the whole sprite
	*	sheet if the animation param is omitted.
	* @param animation The name of the animation to get a frame count for.
	*/
	public function getNumFrames(animation:String):Float;
	
	private function _calculateFrames():Dynamic;
	
	private function _handleImageLoad():Dynamic;
	
	private function initialize():Dynamic;
	
}
