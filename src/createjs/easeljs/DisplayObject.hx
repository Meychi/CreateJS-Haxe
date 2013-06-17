package createjs.easeljs;

import js.html.CanvasRenderingContext2D;

/**
* DisplayObject is an abstract class that should not be constructed directly. Instead construct subclasses such as
*	{{#crossLink "Container"}}{{/crossLink}}, {{#crossLink "Bitmap"}}{{/crossLink}}, and {{#crossLink "Shape"}}{{/crossLink}}.
*	DisplayObject is the base class for all display classes in the EaselJS library. It defines the core properties and
*	methods that are shared between all display objects, such as transformation properties (x, y, scaleX, scaleY, etc),
*	caching, and mouse handlers.
*/
@:native("createjs.DisplayObject")
extern class DisplayObject extends EventDispatcher
{
	/**
	* A CSS cursor (ex. "pointer", "help", "text", etc) that will be displayed when the user hovers over this display object. You must enable mouseover events using the {{#crossLink "Stage/enableMouseOver"}}{{/crossLink}} method to use this property. If null it will use the default cursor.
	*/
	public var cursor:String;
	
	/**
	* A display object that will be tested when checking mouse interactions or testing {{#crossLink "Container/getObjectsUnderPoint"}}{{/crossLink}}. The hit area will have its transformation applied relative to this display object's coordinate space (as though the hit test object were a child of this display object and relative to its regX/Y). The hitArea will be tested using only its own `alpha` value regardless of the alpha value on the target display object, or the target's ancestors (parents).  Note that hitArea is NOT currently used by the `hitTest()` method, nor is it supported for {{#crossLink "Stage"}}{{/crossLink}}.
	*/
	public var hitArea:DisplayObject;
	
	/**
	* A reference to the Container or Stage object that contains this display object, or null if it has not been added to one. READ-ONLY.
	*/
	public var parent:Container;
	
	/**
	* A shadow object that defines the shadow to render on this display object. Set to null to remove a shadow. If null, this property is inherited from the parent container.
	*/
	public var shadow:Shadow;
	
	/**
	* A Shape instance that defines a vector mask (clipping path) for this display object.  The shape's transformation will be applied relative to the display object's parent coordinates (as if it were a child of the parent).
	*/
	public var mask:Shape;
	
	/**
	* An array of Filter objects to apply to this display object. Filters are only applied / updated when `cache()` or `updateCache()` is called on the display object, and only apply to the area that is cached.
	*/
	public var filters:Array<Dynamic>;
	
	/**
	* An optional name for this display object. Included in toString(). Useful for debugging.
	*/
	public var name:String;
	
	/**
	* If a cache is active, this returns the canvas that holds the cached version of this display object. See cache() for more information. READ-ONLY.
	*/
	public var cacheCanvas:Dynamic;
	
	/**
	* Indicates whether the display object should have it's x & y position rounded prior to drawing it to stage. Snapping to whole pixels can result in a sharper and faster draw for images (ex. Bitmap & cached objects). This only applies if the enclosing stage has snapPixelsEnabled set to true. The snapToPixel property is true by default for Bitmap and BitmapAnimation instances, and false for all other display objects. <br/><br/> Note that this applies only rounds the display object's local position. You should ensure that all of the display object's ancestors (parent containers) are also on a whole pixel. You can do this by setting the ancestors' snapToPixel property to true.
	*/
	public var snapToPixel:Bool;
	
	/**
	* Indicates whether this display object should be rendered to the canvas and included when running Stage.getObjectsUnderPoint().
	*/
	public var visible:Bool;
	
	/**
	* Indicates whether to include this object when running mouse interactions. Setting this to `false` for children of a {{#crossLink "Container"}}{{/crossLink}} will cause events on the Container to not fire when that child is clicked. Note that setting this property to `false` does not prevent the {{#crossLink "Container/getObjectsUnderPoint"}}{{/crossLink}} method from returning the child.
	*/
	public var mouseEnabled:Bool;
	
	/**
	* Returns an ID number that uniquely identifies the current cache for this display object. This can be used to * determine if the cache has changed since a previous check.
	*/
	public var cacheID:Float;
	
	/**
	* Suppresses errors generated when using features like hitTest, mouse events, and getObjectsUnderPoint with cross domain content
	*/
	public static var suppressCrossDomainErrors:Bool;
	
	/**
	* The alpha (transparency) for this display object. 0 is fully transparent, 1 is fully opaque.
	*/
	public var alpha:Float;
	
	/**
	* The composite operation indicates how the pixels of this display object will be composited with the elements behind it. If null, this property is inherited from the parent container. For more information, read the <a href="http://www.whatwg.org/specs/web-apps/current-work/multipage/the-canvas-element.html#compositing"> whatwg spec on compositing</a>.
	*/
	public var compositeOperation:String;
	
	/**
	* The factor to skew this display object horizontally.
	*/
	public var skewX:Float;
	
	/**
	* The factor to skew this display object vertically.
	*/
	public var skewY:Float;
	
	/**
	* The factor to stretch this display object horizontally. For example, setting scaleX to 2 will stretch the display object to twice it's nominal width. To horizontally flip an object, set the scale to a negative number.
	*/
	public var scaleX:Float;
	
	/**
	* The factor to stretch this display object vertically. For example, setting scaleY to 0.5 will stretch the display object to half it's nominal height. To vertically flip an object, set the scale to a negative number.
	*/
	public var scaleY:Float;
	
	/**
	* The onClick callback is called when the user presses down on and then releases the mouse button over this display object. The handler is passed a single param containing the corresponding MouseEvent instance. If an onClick handler is set on a container, it will receive the event if any of its children are clicked.
	*/
	public var onClick:Dynamic;
	
	/**
	* The onDoubleClick callback is called when the user double clicks over this display object. The handler is passed a single param containing the corresponding MouseEvent instance. If an onDoubleClick handler is set on a container, it will receive the event if any of its children are clicked.
	*/
	public var onDoubleClick:Dynamic;
	
	/**
	* The onMouseOut callback is called when the user rolls off of the display object. You must enable this event using stage.enableMouseOver(). The handler is passed a single param containing the corresponding MouseEvent instance.
	*/
	public var onMouseOut:Dynamic;
	
	/**
	* The onMouseOver callback is called when the user rolls over the display object. You must enable this event using stage.enableMouseOver(). The handler is passed a single param containing the corresponding MouseEvent instance.
	*/
	public var onMouseOver:Dynamic;
	
	/**
	* The onPress callback is called when the user presses down on their mouse over this display object. The handler is passed a single param containing the corresponding MouseEvent instance. You can subscribe to the onMouseMove and onMouseUp callbacks of the event object to receive these events until the user releases the mouse button. If an onPress handler is set on a container, it will receive the event if any of its children are clicked.
	*/
	public var onPress:Dynamic;
	
	/**
	* The onTick callback is called on each display object on a stage whenever the stage updates. This occurs immediately before the rendering (draw) pass. When stage.update() is called, first all display objects on the stage have onTick called, then all of the display objects are drawn to stage. Children will have their `onTick` called in order of their depth prior to onTick being called on their parent.  Any parameters passed in to `stage.update()` are passed on to the `onTick()` handlers. For example, if you call `stage.update("hello")`, all of the display objects with a handler will have `onTick("hello")` called.
	*/
	public var onTick:Dynamic;
	
	/**
	* The rotation in degrees for this display object.
	*/
	public var rotation:Float;
	
	/**
	* The x (horizontal) position of the display object, relative to its parent.
	*/
	public var x:Float;
	
	/**
	* The x offset for this display object's registration point. For example, to make a 100x100px Bitmap rotate around it's center, you would set regX and regY to 50.
	*/
	public var regX:Float;
	
	/**
	* The y (vertical) position of the display object, relative to its parent.
	*/
	public var y:Float;
	
	/**
	* The y offset for this display object's registration point. For example, to make a 100x100px Bitmap rotate around it's center, you would set regX and regY to 50.
	*/
	public var regY:Float;
	
	/**
	* Unique ID for this display object. Makes display objects easier for some uses.
	*/
	public var id:Float;
	private var _cacheDataURL:String;
	private var _cacheDataURLID:Float;
	private var _cacheOffsetX:Float;
	private var _cacheOffsetY:Float;
	private var _cacheScale:Float;
	private var _matrix:Matrix2D;
	public static var _hitTestCanvas:Dynamic;
	public static var _hitTestContext:CanvasRenderingContext2D;
	public static var _nextCacheID:Float;
	
	/**
	* Applies this display object's transformation, alpha, globalCompositeOperation, clipping path (mask), and shadow
	*	to the specified context. This is typically called prior to {{#crossLink "DisplayObject/draw"}}{{/crossLink}}.
	* @param ctx The canvas 2D to update.
	*/
	public function updateContext(ctx:CanvasRenderingContext2D):Dynamic;
	
	/**
	* Clears the current cache. See {{#crossLink "DisplayObject/cache"}}{{/crossLink}} for more information.
	*/
	public function uncache():Dynamic;
	
	/**
	* DisplayObject is an abstract class that should not be constructed directly. Instead construct subclasses such as
	*	{{#crossLink "Container"}}{{/crossLink}}, {{#crossLink "Bitmap"}}{{/crossLink}}, and {{#crossLink "Shape"}}{{/crossLink}}.
	*	DisplayObject is the base class for all display classes in the EaselJS library. It defines the core properties and
	*	methods that are shared between all display objects, such as transformation properties (x, y, scaleX, scaleY, etc),
	*	caching, and mouse handlers.
	*/
	public function new():Void;
	
	/**
	* Draws the display object into a new canvas, which is then used for subsequent draws. For complex content
	*	that does not change frequently (ex. a Container with many children that do not move, or a complex vector Shape),
	*	this can provide for much faster rendering because the content does not need to be re-rendered each tick. The
	*	cached display object can be moved, rotated, faded, etc freely, however if it's content changes, you must
	*	manually update the cache by calling <code>updateCache()</code> or <code>cache()</code> again. You must specify
	*	the cache area via the x, y, w, and h parameters. This defines the rectangle that will be rendered and cached
	*	using this display object's coordinates.
	*	
	*	<h4>Example</h4>
	*	For example if you defined a Shape that drew a circle at 0, 0 with a radius of 25:
	*	
	*	     var shape = new createjs.Shape();
	*	     shape.graphics.beginFill("#ff0000").drawCircle(0, 0, 25);
	*	     myShape.cache(-25, -25, 50, 50);
	*	
	*	Note that filters need to be defined <em>before</em> the cache is applied. Check out the {{#crossLink "Filter"}}{{/crossLink}}
	*	class for more information.
	* @param x The x coordinate origin for the cache region.
	* @param y The y coordinate origin for the cache region.
	* @param width The width of the cache region.
	* @param height The height of the cache region.
	* @param scale The scale at which the cache will be created. For example, if you cache a vector shape using
	*		myShape.cache(0,0,100,100,2) then the resulting cacheCanvas will be 200x200 px. This lets you scale and rotate
	*		cached elements with greater fidelity. Default is 1.
	*/
	public function cache(x:Float, y:Float, width:Float, height:Float, ?scale:Float):Dynamic;
	
	/**
	* Draws the display object into the specified context ignoring it's visible, alpha, shadow, and transform.
	*	Returns <code>true</code> if the draw was handled (useful for overriding functionality).
	*	
	*	NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
	* @param ctx The canvas 2D context object to draw into.
	* @param ignoreCache Indicates whether the draw operation should ignore any current cache. For example,
	*	used for drawing the cache (to prevent it from simply drawing an existing cache back into itself).
	*/
	public function draw(ctx:CanvasRenderingContext2D, ?ignoreCache:Bool):Dynamic;
	
	/**
	* Generates a concatenated Matrix2D object representing the combined transform of the display object and all of its
	*	parent Containers up to the highest level ancestor (usually the {{#crossLink "Stage"}}{{/crossLink}}). This can
	*	be used to transform positions between coordinate spaces, such as with {{#crossLink "DisplayObject/localToGlobal"}}{{/crossLink}}
	*	and {{#crossLink "DisplayObject/globalToLocal"}}{{/crossLink}}.
	* @param mtx A {{#crossLink "Matrix2D"}}{{/crossLink}} object to populate with the calculated values.
	*	If null, a new Matrix2D object is returned.
	*/
	public function getConcatenatedMatrix(?mtx:Matrix2D):Matrix2D;
	
	/**
	* Indicates whether the display object has a listener of the corresponding event types.
	* @param typeMask A bitmask indicating which event types to look for. Bit 1 specifies press &
	*	click & double click, bit 2 specifies it should look for mouse over and mouse out. This implementation may change.
	*/
	private function _hasMouseHandler(typeMask:Float):Bool;
	
	/**
	* Initialization method.
	*/
	private function initialize():Dynamic;
	
	/**
	* Provides a chainable shortcut method for setting a number of properties on a DisplayObject instance.
	*	
	*	<h4>Example</h4>
	*	
	*	     var myGraphics = new createjs.Graphics().beginFill("#ff0000").drawCircle(0, 0, 25);
	*	     var shape = stage.addChild(new Shape())
	*	         .set({graphics:myGraphics, x:100, y:100, alpha:0.5});
	* @param props A generic object containing properties to copy to the DisplayObject instance.
	*/
	public function set(props:Dynamic):DisplayObject;
	
	/**
	* Redraws the display object to its cache. Calling updateCache without an active cache will throw an error.
	*	If compositeOperation is null the current cache will be cleared prior to drawing. Otherwise the display object
	*	will be drawn over the existing cache using the specified compositeOperation.
	*	
	*	<h4>Example</h4>
	*	Clear the current graphics of a cached shape, draw some new instructions, and then update the cache. The new line
	*	will be drawn on top of the old one.
	*	
	*	     // Not shown: Creating the shape, and caching it.
	*	     shapeInstance.clear();
	*	     shapeInstance.setStrokeStyle(3).beginStroke("#ff0000").moveTo(100, 100).lineTo(200,200);
	*	     shapeInstance.updateCache();
	* @param compositeOperation The compositeOperation to use, or null to clear the cache and redraw it.
	*	<a href="http://www.whatwg.org/specs/web-apps/current-work/multipage/the-canvas-element.html#compositing">
	*	whatwg spec on compositing</a>.
	*/
	public function updateCache(compositeOperation:String):Dynamic;
	
	/**
	* Returns a clone of this DisplayObject. Some properties that are specific to this instance's current context are
	*	reverted to their defaults (for example .parent).
	*/
	public function clone():DisplayObject;
	
	/**
	* Returns a data URL for the cache, or null if this display object is not cached.
	*	Uses cacheID to ensure a new data URL is not generated if the cache has not changed.
	*/
	public function getCacheDataURL():Dynamic;
	
	/**
	* Returns a matrix based on this object's transform.
	* @param matrix Optional. A Matrix2D object to populate with the calculated values. If null, a new
	*	Matrix object is returned.
	*/
	public function getMatrix(?matrix:Matrix2D):Matrix2D;
	
	/**
	* Returns a string representation of this object.
	*/
	public function toString():String;
	
	/**
	* Returns the stage that this display object will be rendered on, or null if it has not been added to one.
	*/
	public function getStage():Stage;
	
	/**
	* Returns true or false indicating whether the display object would be visible if drawn to a canvas.
	*	This does not account for whether it would be visible within the boundaries of the stage.
	*	
	*	NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
	*/
	public function isVisible():Bool;
	
	/**
	* Shortcut method to quickly set the transform properties on the display object. All parameters are optional.
	*	Omitted parameters will have the default value set.
	*	
	*	<h4>Example</h4>
	*	
	*	     displayObject.setTransform(100, 100, 2, 2);
	* @param x The horizontal translation (x position) in pixels
	* @param y The vertical translation (y position) in pixels
	* @param scaleX The horizontal scale, as a percentage of 1
	* @param scaleY the vertical scale, as a percentage of 1
	* @param rotation The rotation, in degrees
	* @param skewX The horizontal skew factor
	* @param skewY The vertical skew factor
	* @param regX The horizontal registration point in pixels
	* @param regY The vertical registration point in pixels
	*/
	public function setTransform(?x:Float, ?y:Float, ?scaleX:Float, ?scaleY:Float, ?rotation:Float, ?skewX:Float, ?skewY:Float, ?regX:Float, ?regY:Float):DisplayObject;
	
	/**
	* Tests whether the display object intersects the specified local point (ie. draws a pixel with alpha > 0 at
	*	the specified position). This ignores the alpha, shadow and compositeOperation of the display object, and all
	*	transform properties including regX/Y.
	*	
	*	<h4>Example</h4>
	*	
	*	     stage.addEventListener("stagemousedown", handleMouseDown);
	*	     function handleMouseDown(event) {
	*	         var hit = myShape.hitTest(event.stageX, event.stageY);
	*	     }
	*	
	*	Please note that shape-to-shape collision is not currently supported by EaselJS.
	* @param x The x position to check in the display object's local coordinates.
	* @param y The y position to check in the display object's local coordinates.
	*/
	public function hitTest(x:Float, y:Float):Bool;
	
	/**
	* Transforms the specified x and y position from the coordinate space of the display object
	*	to the global (stage) coordinate space. For example, this could be used to position an HTML label
	*	over a specific point on a nested display object. Returns a Point instance with x and y properties
	*	correlating to the transformed coordinates on the stage.
	*	
	*	<h4>Example</h4>
	*	
	*	     displayObject.x = 300;
	*	     displayObject.y = 200;
	*	     stage.addChild(displayObject);
	*	     var point = myDisplayObject.localToGlobal(100, 100);
	*	     // Results in x=400, y=300
	* @param x The x position in the source display object to transform.
	* @param y The y position in the source display object to transform.
	*/
	public function localToGlobal(x:Float, y:Float):Point;
	
	/**
	* Transforms the specified x and y position from the coordinate space of this display object to the coordinate
	*	space of the target display object. Returns a Point instance with x and y properties correlating to the
	*	transformed position in the target's coordinate space. Effectively the same as using the following code with
	*	{{#crossLink "DisplayObject/localToGlobal"}}{{/crossLink}} and {{#crossLink "DisplayObject/globalToLocal"}}{{/crossLink}}.
	*	
	*	     var pt = this.localToGlobal(x, y);
	*	     pt = target.globalToLocal(pt.x, pt.y);
	* @param x The x position in the source display object to transform.
	* @param y The y position on the stage to transform.
	* @param target The target display object to which the coordinates will be transformed.
	*/
	public function localToLocal(x:Float, y:Float, target:DisplayObject):Point;
	
	/**
	* Transforms the specified x and y position from the global (stage) coordinate space to the
	*	coordinate space of the display object. For example, this could be used to determine
	*	the current mouse position within the display object. Returns a Point instance with x and y properties
	*	correlating to the transformed position in the display object's coordinate space.
	*	
	*	<h4>Example</h4>
	*	
	*	     displayObject.x = 300;
	*	     displayObject.y = 200;
	*	     stage.addChild(displayObject);
	*	     var point = myDisplayObject.globalToLocal(100, 100);
	*	     // Results in x=-200, y=-100
	* @param x The x position on the stage to transform.
	* @param y The y position on the stage to transform.
	*/
	public function globalToLocal(x:Float, y:Float):Point;
	private function _applyFilters():Dynamic;
	private function _applyShadow(ctx:CanvasRenderingContext2D, shadow:Shadow):Dynamic;
	private function _testHit(ctx:CanvasRenderingContext2D):Bool;
	private function _tick():Dynamic;
	private function cloneProps(o:DisplayObject):Dynamic;
}
