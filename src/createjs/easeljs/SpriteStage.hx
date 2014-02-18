package createjs.easeljs;

import js.html.CanvasRenderingContext2D;
import js.html.Float32Array;
import js.html.Image;
import js.html.Uint16Array;

/**
* A sprite stage is the root level {{#crossLink "Container"}}{{/crossLink}} for an aggressively optimized display list. Each time its {{#crossLink "Stage/tick"}}{{/crossLink}}
*	method is called, it will render its display list to its target canvas. WebGL content is fully compatible with the existing Context2D renderer.
*	On devices or browsers that don't support WebGL, content will automatically be rendered via canvas 2D.
*	
*	Restrictions:
*	    - only Sprite, SpriteContainer, BitmapText, Bitmap and DOMElement are allowed to be added to the display list.
*	    - a child being added (with the exception of DOMElement) MUST have an image or spriteSheet defined on it.
*	    - a child's image/spriteSheet MUST never change while being on the display list.
*	
*	<h4>Example</h4>
*	This example creates a sprite stage, adds a child to it, then uses {{#crossLink "Ticker"}}{{/crossLink}} to update the child
*	and redraw the stage using {{#crossLink "SpriteStage/update"}}{{/crossLink}}.
*	
*	     var stage = new createjs.SpriteStage("canvasElementId", false, false);
*	     stage.updateViewport(800, 600);
*	     var image = new createjs.Bitmap("imagePath.png");
*	     stage.addChild(image);
*	     createjs.Ticker.addEventListener("tick", handleTick);
*	     function handleTick(event) {
*	         image.x += 10;
*	         stage.update();
*	     }
*	
*	<strong>Note:</strong> SpriteStage is not included in the minified version of EaselJS.
*/
@:native("createjs.SpriteStage")
extern class SpriteStage extends Stage
{
	/**
	* A 2D projection matrix used to convert WebGL's clipspace into normal pixels.
	*/
	private var _projectionMatrix:Float32Array;
	
	/**
	* Indicates whether or not an error has been detected when dealing with WebGL. If the is true, the behavior should be to use Canvas 2D rendering instead.
	*/
	private var _webGLErrorDetected:Bool;
	
	/**
	* Indicates whether WebGL is being used for rendering. For example, this would be false if WebGL is not supported in the browser.
	*/
	public var isWebGL:Bool;
	
	/**
	* Specifies whether or not the browser's WebGL implementation should try to perform antialiasing.
	*/
	private var _antialias:Bool;
	
	/**
	* Specifies whether or not the canvas is auto-cleared by WebGL. Spec discourages true. If true, the canvas is NOT auto-cleared by WebGL. Value is ignored if p._alphaEnabled is false. Useful if you want to use p.autoClear = false.
	*/
	private var _preserveDrawingBuffer:Bool;
	
	/**
	* The amount used to increment p._maxBoxesPointsPerDraw when the maximum has been reached. If the maximum size of element index WebGL allows for (SpriteStage.MAX_INDEX_SIZE) was used, the array size for p._vertices would equal 1280kb and p._indices 192kb. But since mobile phones with less memory need to be accounted for, the maximum size is somewhat arbitrarily divided by 4, reducing the array sizes to 320kb and 48kb respectively.
	*/
	public static var MAX_BOXES_POINTS_INCREMENT:Float;
	
	/**
	* The buffer that contains all the indices data.
	*/
	private var _indicesBuffer:WebGLBuffer;
	
	/**
	* The buffer that contains all the vertices data.
	*/
	private var _verticesBuffer:WebGLBuffer;
	
	/**
	* The color to use when the WebGL canvas has been cleared.
	*/
	private var _clearColor:Dynamic;
	
	/**
	* The current box index being defined for drawing.
	*/
	private var _currentBoxIndex:Float;
	
	/**
	* The current texture that will be used to draw into the GPU.
	*/
	private var _drawTexture:WebGLTexture;
	
	/**
	* The current WebGL canvas context.
	*/
	private var _webGLContext:WebGLRenderingContext;
	
	/**
	* The height of the canvas element.
	*/
	private var _viewportHeight:Float;
	
	/**
	* The indices to the vertices defined in p._vertices.
	*/
	private var _indices:Uint16Array;
	
	/**
	* The maximum number of boxes (sprites) that can be drawn in one draw call.
	*/
	private var _maxBoxesPerDraw:Float;
	
	/**
	* The maximum number of indices that can be drawn in one draw call.
	*/
	private var _maxIndicesPerDraw:Float;
	
	/**
	* The maximum number of textures WebGL can work with per draw call.
	*/
	private var _maxTexturesPerDraw:Float;
	
	/**
	* The maximum size WebGL allows for element index numbers: 16 bit unsigned integer
	*/
	public static var MAX_INDEX_SIZE:Float;
	
	/**
	* The maximum total number of boxes points that can be defined per draw call.
	*/
	private var _maxBoxesPointsPerDraw:Float;
	
	/**
	* The number of indices needed to define a box using triangles. 6 indices = 2 triangles = 1 box
	*/
	public static var INDICES_PER_BOX:Float;
	
	/**
	* The number of points in a box...obviously :)
	*/
	public static var POINTS_PER_BOX:Float;
	
	/**
	* The number of properties defined per vertex in p._verticesBuffer. x, y, textureU, textureV, alpha
	*/
	public static var NUM_VERTEX_PROPERTIES:Float;
	
	/**
	* The number of vertex properties per box.
	*/
	public static var NUM_VERTEX_PROPERTIES_PER_BOX:Float;
	
	/**
	* The shader program used to draw everything.
	*/
	private var _shaderProgram:WebGLProgram;
	
	/**
	* The vertices data for the current draw call.
	*/
	private var _vertices:Float32Array;
	
	/**
	* The width of the canvas element.
	*/
	private var _viewportWidth:Float;
	
	private var Stage_draw:Dynamic;
	
	private var Stage_initialize:Dynamic;
	
	/**
	* A sprite stage is the root level {{#crossLink "Container"}}{{/crossLink}} for an aggressively optimized display list. Each time its {{#crossLink "Stage/tick"}}{{/crossLink}}
	*	method is called, it will render its display list to its target canvas. WebGL content is fully compatible with the existing Context2D renderer.
	*	On devices or browsers that don't support WebGL, content will automatically be rendered via canvas 2D.
	*	
	*	Restrictions:
	*	    - only Sprite, SpriteContainer, BitmapText, Bitmap and DOMElement are allowed to be added to the display list.
	*	    - a child being added (with the exception of DOMElement) MUST have an image or spriteSheet defined on it.
	*	    - a child's image/spriteSheet MUST never change while being on the display list.
	*	
	*	<h4>Example</h4>
	*	This example creates a sprite stage, adds a child to it, then uses {{#crossLink "Ticker"}}{{/crossLink}} to update the child
	*	and redraw the stage using {{#crossLink "SpriteStage/update"}}{{/crossLink}}.
	*	
	*	     var stage = new createjs.SpriteStage("canvasElementId", false, false);
	*	     stage.updateViewport(800, 600);
	*	     var image = new createjs.Bitmap("imagePath.png");
	*	     stage.addChild(image);
	*	     createjs.Ticker.addEventListener("tick", handleTick);
	*	     function handleTick(event) {
	*	         image.x += 10;
	*	         stage.update();
	*	     }
	*	
	*	<strong>Note:</strong> SpriteStage is not included in the minified version of EaselJS.
	* @param canvas A canvas object that the SpriteStage will render to, or the string id
	*	of a canvas object in the current document.
	* @param preserveDrawingBuffer If true, the canvas is NOT auto-cleared by WebGL (spec discourages true). Useful if you want to use p.autoClear = false.
	* @param antialias Specifies whether or not the browser's WebGL implementation should try to perform antialiasing.
	*/
	public function new(canvas:Dynamic, preserveDrawingBuffer:Bool, antialias:Bool):Void;
	
	/**
	* Adds a child to the display list at the specified index, bumping children at equal or greater indexes up one, and
	*	setting its parent to this Container.
	*	Only children of type SpriteContainer, Sprite, Bitmap, BitmapText, or DOMElement are allowed.
	*	Children also MUST have either an image or spriteSheet defined on them (unless it's a DOMElement).
	*	
	*	<h4>Example</h4>
	*	     addChildAt(child1, index);
	*	
	*	You can also add multiple children, such as:
	*	
	*	     addChildAt(child1, child2, ..., index);
	*	
	*	The index must be between 0 and numChildren. For example, to add myShape under otherShape in the display list,
	*	you could use:
	*	
	*	     container.addChildAt(myShape, container.getChildIndex(otherShape));
	*	
	*	This would also bump otherShape's index up by one. Fails silently if the index is out of range.
	* @param child The display object to add.
	* @param index The index to add the child at.
	*/
	//public function addChildAt(child:DisplayObject, index:Float):DisplayObject;
	
	/**
	* Adds a child to the top of the display list.
	*	Only children of type SpriteContainer, Sprite, Bitmap, BitmapText, or DOMElement are allowed.
	*	Children also MUST have either an image or spriteSheet defined on them (unless it's a DOMElement).
	*	
	*	<h4>Example</h4>
	*	     container.addChild(bitmapInstance);
	*	
	*	 You can also add multiple children at once:
	*	
	*	     container.addChild(bitmapInstance, shapeInstance, textInstance);
	* @param child The display object to add.
	*/
	//public function addChild(child:DisplayObject):DisplayObject;
	
	/**
	* Clears an image's texture to free it up for garbage collection.
	* @param image 
	*/
	public function clearImageTexture(image:Image):Dynamic;
	
	/**
	* Clears the target canvas. Useful if {{#crossLink "Stage/autoClear:property"}}{{/crossLink}} is set to `false`.
	*/
	//public function clear():Dynamic;
	
	/**
	* Creates a shader from the specified string.
	* @param ctx 
	* @param type The type of shader to create.
	* @param str The definition for the shader.
	*/
	private function _createShader(ctx:WebGLRenderingContext, type:Float, str:String):WebGLShader;
	
	/**
	* Creates the shader program that's going to be used to draw everything.
	* @param ctx 
	*/
	private function _createShaderProgram(ctx:WebGLRenderingContext):Dynamic;
	
	/**
	* Draw all the kids into the WebGL context.
	* @param kids The list of kids to draw.
	* @param ctx The canvas WebGL context object to draw into.
	* @param parentMVMatrix The parent's global transformation matrix.
	*/
	private function _drawWebGLKids(kids:Array<Dynamic>, ctx:WebGLRenderingContext, parentMVMatrix:Matrix2D):Dynamic;
	
	/**
	* Draws all the currently defined boxes to the GPU.
	* @param ctx The canvas WebGL context object to draw into.
	*/
	private function _drawToGPU(ctx:WebGLRenderingContext):Dynamic;
	
	/**
	* Draws the stage into the specified context (using WebGL) ignoring its visible, alpha, shadow, and transform.
	*	If WebGL is not supported in the browser, it will default to a 2D context.
	*	Returns true if the draw was handled (useful for overriding functionality).
	*	
	*	NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
	* @param ctx The canvas 2D context object to draw into.
	* @param ignoreCache Indicates whether the draw operation should ignore any current cache.
	*	For example, used for drawing the cache (to prevent it from simply drawing an existing cache back
	*	into itself).
	*/
	//public function draw(ctx:CanvasRenderingContext2D, ?ignoreCache:Bool):Dynamic;
	
	/**
	* Each time the update method is called, the stage will tick all descendants (see: {{#crossLink "DisplayObject/tick"}}{{/crossLink}})
	*	and then render the display list to the canvas using WebGL. If WebGL is not supported in the browser, it will default to a 2D context.
	*	
	*	Any parameters passed to `update()` will be passed on to any
	*	{{#crossLink "DisplayObject/tick:event"}}{{/crossLink}} event handlers.
	*	
	*	Some time-based features in EaselJS (for example {{#crossLink "Sprite/framerate"}}{{/crossLink}} require that
	*	a tick event object (or equivalent) be passed as the first parameter to update(). For example:
	*	
	*	     Ticker.addEventListener("tick", handleTick);
	*	     function handleTick(evtObj) {
	*	         // do some work here, then update the stage, passing through the event object:
	*	         myStage.update(evtObj);
	*	     }
	* @param params Params to include when ticking descendants. The first param should usually be a tick event.
	*/
	//public function update(?params:*):Dynamic;
	
	/**
	* Initialization method.
	* @param canvas A canvas object, or the string id of a canvas object in the current document.
	* @param preserveDrawingBuffer If true, the canvas is NOT auto-cleared by WebGL (spec discourages true). Useful if you want to use p.autoClear = false.
	* @param antialias Specifies whether or not the browser's WebGL implementation should try to perform antialiasing.
	*/
	//private function initialize(canvas:Dynamic, preserveDrawingBuffer:Bool, antialias:Bool):Dynamic;
	
	/**
	* Initializes rendering with WebGL using the current canvas element.
	*/
	private function _initializeWebGL():Dynamic;
	
	/**
	* Returns a string representation of this object.
	*/
	//public function toString():String;
	
	/**
	* Sets the color to use when the WebGL canvas has been cleared.
	* @param r A number between 0 and 1.
	* @param g A number between 0 and 1.
	* @param b A number between 0 and 1.
	* @param a A number between 0 and 1.
	*/
	private function _setClearColor(r:Float, g:Float, b:Float, a:Float):Dynamic;
	
	/**
	* Sets the WebGL context to use for future draws.
	*/
	private function _setWebGLContext():WebGLRenderingContext;
	
	/**
	* Sets up a kid's WebGL texture.
	* @param ctx The canvas WebGL context object to draw into.
	* @param kid The list of kids to draw.
	*/
	private function _setUpKidTexture(ctx:WebGLRenderingContext, kid:Dynamic):WebGLTexture;
	
	/**
	* Sets up the necessary vertices and indices buffers.
	* @param ctx 
	*/
	private function _createBuffers(ctx:WebGLRenderingContext):Dynamic;
	
	/**
	* Sets up the WebGL context for rendering.
	*/
	private function _initializeWebGLContext():Dynamic;
	
	/**
	* Update the WebGL viewport. Note that this does NOT update the canvas element's width/height.
	* @param width 
	* @param height 
	*/
	public function updateViewport(width:Float, height:Float):Dynamic;
	
	/**
	* Updates the maximum total number of boxes points that can be defined per draw call,
	*	and updates the buffers with the new array length sizes.
	* @param ctx 
	* @param value The new this._maxBoxesPointsPerDraw value.
	*/
	private function _setMaxBoxesPoints(ctx:WebGLRenderingContext, value:Float):Dynamic;
	
}
