package createjs.easeljs;

import js.html.CanvasRenderingContext2D;
import haxe.extern.Rest;

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
	* A CSS cursor (ex. "pointer", "help", "text", etc) that will be displayed when the user hovers over this display object. You must enable mouseover events using the {{#crossLink "Stage/enableMouseOver"}}{{/crossLink}} method to use this property. Setting a non-null cursor on a Container will override the cursor set on its descendants.
	*/
	public var cursor:String;
	
	/**
	* A display object that will be tested when checking mouse interactions or testing {{#crossLink "Container/getObjectsUnderPoint"}}{{/crossLink}}. The hit area will have its transformation applied relative to this display object's coordinate space (as though the hit test object were a child of this display object and relative to its regX/Y). The hitArea will be tested using only its own `alpha` value regardless of the alpha value on the target display object, or the target's ancestors (parents).  If set on a {{#crossLink "Container"}}{{/crossLink}}, children of the Container will not receive mouse events. This is similar to setting {{#crossLink "mouseChildren"}}{{/crossLink}} to false.  Note that hitArea is NOT currently used by the `hitTest()` method, nor is it supported for {{#crossLink "Stage"}}{{/crossLink}}.
	*/
	public var hitArea:DisplayObject;
	
	/**
	* A reference to the {{#crossLink "Container"}}{{/crossLink}} or {{#crossLink "Stage"}}{{/crossLink}} object that contains this display object, or null if it has not been added to one.
	*/
	public var parent:Container;
	
	/**
	* A shadow object that defines the shadow to render on this display object. Set to `null` to remove a shadow. If null, this property is inherited from the parent container.
	*/
	public var shadow:Shadow;
	
	/**
	* A Shape instance that defines a vector mask (clipping path) for this display object.  The shape's transformation will be applied relative to the display object's parent coordinates (as if it were a child of the parent).
	*/
	public var mask:Shape;
	
	/**
	* An array of Filter objects to apply to this display object. Filters are only applied / updated when {{#crossLink "cache"}}{{/crossLink}} or {{#crossLink "updateCache"}}{{/crossLink}} is called on the display object, and only apply to the area that is cached.
	*/
	public var filters:Array<Dynamic>;
	
	/**
	* An optional name for this display object. Included in {{#crossLink "DisplayObject/toString"}}{{/crossLink}} . Useful for debugging.
	*/
	public var name:String;
	
	/**
	* If a cache is active, this returns the canvas that holds the cached version of this display object. See {{#crossLink "cache"}}{{/crossLink}} for more information.
	*/
	public var cacheCanvas:Dynamic;
	
	/**
	* If false, the tick will not run on this display object (or its children). This can provide some performance benefits. In addition to preventing the "tick" event from being dispatched, it will also prevent tick related updates on some display objects (ex. Sprite & MovieClip frame advancing, DOMElement visibility handling).
	*/
	public var tickEnabled:Bool;
	
	/**
	* If set, defines the transformation for this display object, overriding all other transformation properties (x, y, rotation, scale, skew).
	*/
	public var transformMatrix:Matrix2D;
	
	/**
	* Indicates whether the display object should be drawn to a whole pixel when {{#crossLink "Stage/snapToPixelEnabled"}}{{/crossLink}} is true. To enable/disable snapping on whole categories of display objects, set this value on the prototype (Ex. Text.prototype.snapToPixel = true).
	*/
	public var snapToPixel:Bool;
	
	/**
	* Indicates whether this display object should be rendered to the canvas and included when running the Stage {{#crossLink "Stage/getObjectsUnderPoint"}}{{/crossLink}} method.
	*/
	public var visible:Bool;
	
	/**
	* Indicates whether to include this object when running mouse interactions. Setting this to `false` for children of a {{#crossLink "Container"}}{{/crossLink}} will cause events on the Container to not fire when that child is clicked. Setting this property to `false` does not prevent the {{#crossLink "Container/getObjectsUnderPoint"}}{{/crossLink}} method from returning the child.  <strong>Note:</strong> In EaselJS 0.7.0, the mouseEnabled property will not work properly with nested Containers. Please check out the latest NEXT version in <a href="https://github.com/CreateJS/EaselJS/tree/master/lib">GitHub</a> for an updated version with this issue resolved. The fix will be provided in the next release of EaselJS.
	*/
	public var mouseEnabled:Bool;
	
	/**
	* Listing of mouse event names. Used in _hasMouseEventListener.
	*/
	public static var _MOUSE_EVENTS:Array<Dynamic>;
	
	/**
	* Returns an ID number that uniquely identifies the current cache for this display object. This can be used to determine if the cache has changed since a previous check.
	*/
	public var cacheID:Float;
	
	/**
	* Returns the Stage instance that this display object will be rendered on, or null if it has not been added to one.
	*/
	public var stage:Stage;
	
	/**
	* Suppresses errors generated when using features like hitTest, mouse events, and {{#crossLink "getObjectsUnderPoint"}}{{/crossLink}} with cross domain content.
	*/
	public static var suppressCrossDomainErrors:Bool;
	
	/**
	* The alpha (transparency) for this display object. 0 is fully transparent, 1 is fully opaque.
	*/
	public var alpha:Float;
	
	/**
	* The composite operation indicates how the pixels of this display object will be composited with the elements behind it. If `null`, this property is inherited from the parent container. For more information, read the <a href="http://www.whatwg.org/specs/web-apps/current-work/multipage/the-canvas-element.html#compositing"> whatwg spec on compositing</a>.
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
	* The factor to stretch this display object horizontally. For example, setting scaleX to 2 will stretch the display object to twice its nominal width. To horizontally flip an object, set the scale to a negative number.
	*/
	public var scaleX:Float;
	
	/**
	* The factor to stretch this display object vertically. For example, setting scaleY to 0.5 will stretch the display object to half its nominal height. To vertically flip an object, set the scale to a negative number.
	*/
	public var scaleY:Float;
	
	/**
	* The left offset for this display object's registration point. For example, to make a 100x100px Bitmap rotate around its center, you would set regX and {{#crossLink "DisplayObject/regY:property"}}{{/crossLink}} to 50.
	*/
	public var regX:Float;
	
	/**
	* The rotation in degrees for this display object.
	*/
	public var rotation:Float;
	
	/**
	* The x (horizontal) position of the display object, relative to its parent.
	*/
	public var x:Float;
	
	/**
	* The y offset for this display object's registration point. For example, to make a 100x100px Bitmap rotate around its center, you would set {{#crossLink "DisplayObject/regX:property"}}{{/crossLink}} and regY to 50.
	*/
	public var regY:Float;
	
	/**
	* Unique ID for this display object. Makes display objects easier for some uses.
	*/
	public var id:Float;
	
	private var _bounds:Rectangle;
	
	private var _cacheDataURL:String;
	
	private var _cacheDataURLID:Float;
	
	private var _cacheOffsetX:Float;
	
	private var _cacheOffsetY:Float;
	
	private var _cacheScale:Float;
	
	private var _filterOffsetX:Float;
	
	private var _filterOffsetY:Float;
	
	private var _props:DisplayObject;
	
	private var _rectangle:Rectangle;
	
	public static var _hitTestCanvas:Dynamic;
	
	public static var _hitTestContext:CanvasRenderingContext2D;
	
	public static var _nextCacheID:Float;
	
	public static var _snapToPixelEnabled:Bool;
	
	public var y:Float;
	
	/**
	* Allows you to manually specify the bounds of an object that either cannot calculate their own bounds (ex. Shape &
	*	Text) for future reference, or so the object can be included in Container bounds. Manually set bounds will always
	*	override calculated bounds.
	*	
	*	The bounds should be specified in the object's local (untransformed) coordinates. For example, a Shape instance
	*	with a 25px radius circle centered at 0,0 would have bounds of (-25, -25, 50, 50).
	* @param x The x origin of the bounds. Pass null to remove the manual bounds.
	* @param y The y origin of the bounds.
	* @param width The width of the bounds.
	* @param height The height of the bounds.
	*/
	public function setBounds(x:Float, y:Float, width:Float, height:Float):Dynamic;
	
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
	*	cached display object can be moved, rotated, faded, etc freely, however if its content changes, you must
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
	*	class for more information. Some filters (ex. BlurFilter) will not work as expected in conjunction with the scale param.
	*	
	*	Usually, the resulting cacheCanvas will have the dimensions width*scale by height*scale, however some filters (ex. BlurFilter)
	*	will add padding to the canvas dimensions.
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
	* Draws the display object into the specified context ignoring its visible, alpha, shadow, and transform.
	*	Returns <code>true</code> if the draw was handled (useful for overriding functionality).
	*	
	*	NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
	* @param ctx The canvas 2D context object to draw into.
	* @param ignoreCache Indicates whether the draw operation should ignore any current cache. For example,
	*	used for drawing the cache (to prevent it from simply drawing an existing cache back into itself).
	*/
	public function draw(ctx:CanvasRenderingContext2D, ?ignoreCache:Bool):Bool;
	
	/**
	* Generates a DisplayProps object representing the combined display properties of the  object and all of its
	*	parent Containers up to the highest level ancestor (usually the {{#crossLink "Stage"}}{{/crossLink}}).
	* @param props A {{#crossLink "DisplayProps"}}{{/crossLink}} object to populate with the calculated values.
	*	If null, a new DisplayProps object is returned.
	*/
	public function getConcatenatedDisplayProps(?props:DisplayProps):DisplayProps;
	
	/**
	* Generates a Matrix2D object representing the combined transform of the display object and all of its
	*	parent Containers up to the highest level ancestor (usually the {{#crossLink "Stage"}}{{/crossLink}}). This can
	*	be used to transform positions between coordinate spaces, such as with {{#crossLink "DisplayObject/localToGlobal"}}{{/crossLink}}
	*	and {{#crossLink "DisplayObject/globalToLocal"}}{{/crossLink}}.
	* @param matrix A {{#crossLink "Matrix2D"}}{{/crossLink}} object to populate with the calculated values.
	*	If null, a new Matrix2D object is returned.
	*/
	public function getConcatenatedMatrix(?matrix:Matrix2D):Matrix2D;
	
	/**
	* Indicates whether the display object has any mouse event listeners or a cursor.
	*/
	private function _isMouseOpaque():Bool;
	
	/**
	* Provides a chainable shortcut method for setting a number of properties on the instance.
	*	
	*	<h4>Example</h4>
	*	
	*	     var myGraphics = new createjs.Graphics().beginFill("#ff0000").drawCircle(0, 0, 25);
	*	     var shape = stage.addChild(new Shape()).set({graphics:myGraphics, x:100, y:100, alpha:0.5});
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
	@:overload(function(params:Rest<Dynamic>):Dynamic{})
	public function updateCache(?compositeOperation:String):Dynamic;
	
	/**
	* Returns a clone of this DisplayObject. Some properties that are specific to this instance's current context are
	*	reverted to their defaults (for example .parent). Caches are not maintained across clones, and some elements
	*	are copied by reference (masks, individual filter instances, hit area)
	*/
	public function clone():DisplayObject;
	
	/**
	* Returns a data URL for the cache, or null if this display object is not cached.
	*	Uses cacheID to ensure a new data URL is not generated if the cache has not changed.
	*/
	public function getCacheDataURL():String;
	
	/**
	* Returns a matrix based on this object's current transform.
	* @param matrix Optional. A Matrix2D object to populate with the calculated values. If null, a new
	*	Matrix object is returned.
	*/
	public function getMatrix(matrix:Matrix2D):Matrix2D;
	
	/**
	* Returns a rectangle representing this object's bounds in its local coordinate system (ie. with no transformation).
	*	Objects that have been cached will return the bounds of the cache.
	*	
	*	Not all display objects can calculate their own bounds (ex. Shape). For these objects, you can use 
	*	{{#crossLink "DisplayObject/setBounds"}}{{/crossLink}} so that they are included when calculating Container
	*	bounds.
	*	
	*	<table>
	*		<tr><td><b>All</b></td><td>
	*			All display objects support setting bounds manually using setBounds(). Likewise, display objects that
	*			have been cached using cache() will return the bounds of their cache. Manual and cache bounds will override
	*			the automatic calculations listed below.
	*		</td></tr>
	*		<tr><td><b>Bitmap</b></td><td>
	*			Returns the width and height of the sourceRect (if specified) or image, extending from (x=0,y=0).
	*		</td></tr>
	*		<tr><td><b>Sprite</b></td><td>
	*			Returns the bounds of the current frame. May have non-zero x/y if a frame registration point was specified
	*			in the spritesheet data. See also {{#crossLink "SpriteSheet/getFrameBounds"}}{{/crossLink}}
	*		</td></tr>
	*		<tr><td><b>Container</b></td><td>
	*			Returns the aggregate (combined) bounds of all children that return a non-null value from getBounds().
	*		</td></tr>
	*		<tr><td><b>Shape</b></td><td>
	*			Does not currently support automatic bounds calculations. Use setBounds() to manually define bounds.
	*		</td></tr>
	*		<tr><td><b>Text</b></td><td>
	*			Returns approximate bounds. Horizontal values (x/width) are quite accurate, but vertical values (y/height) are
	*			not, especially when using textBaseline values other than "top".
	*		</td></tr>
	*		<tr><td><b>BitmapText</b></td><td>
	*			Returns approximate bounds. Values will be more accurate if spritesheet frame registration points are close
	*			to (x=0,y=0).
	*		</td></tr>
	*	</table>
	*	
	*	Bounds can be expensive to calculate for some objects (ex. text, or containers with many children), and
	*	are recalculated each time you call getBounds(). You can prevent recalculation on static objects by setting the
	*	bounds explicitly:
	*	
	*		var bounds = obj.getBounds();
	*		obj.setBounds(bounds.x, bounds.y, bounds.width, bounds.height);
	*		// getBounds will now use the set values, instead of recalculating
	*	
	*	To reduce memory impact, the returned Rectangle instance may be reused internally; clone the instance or copy its
	*	values if you need to retain it.
	*	
	*		var myBounds = obj.getBounds().clone();
	*		// OR:
	*		myRect.copy(obj.getBounds());
	*/
	public function getBounds():Rectangle;
	
	/**
	* Returns a rectangle representing this object's bounds in its parent's coordinate system (ie. with transformations applied).
	*	Objects that have been cached will return the transformed bounds of the cache.
	*	
	*	Not all display objects can calculate their own bounds (ex. Shape). For these objects, you can use 
	*	{{#crossLink "DisplayObject/setBounds"}}{{/crossLink}} so that they are included when calculating Container
	*	bounds.
	*	
	*	To reduce memory impact, the returned Rectangle instance may be reused internally; clone the instance or copy its
	*	values if you need to retain it.
	*	
	*	Container instances calculate aggregate bounds for all children that return bounds via getBounds.
	*/
	public function getTransformedBounds():Rectangle;
	
	/**
	* Returns a string representation of this object.
	*/
	override public function toString():String;
	
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
	* Tests whether the display object intersects the specified point in local coordinates (ie. draws a pixel with alpha > 0 at
	*	the specified position). This ignores the alpha, shadow, hitArea, mask, and compositeOperation of the display object.
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
	* @param pt An object to copy the result into. If omitted a new Point object with x/y properties will be returned.
	*/
	public function localToGlobal(x:Float, y:Float, ?pt:Dynamic):Point;
	
	/**
	* Transforms the specified x and y position from the coordinate space of this display object to the coordinate
	*	space of the target display object. Returns a Point instance with x and y properties correlating to the
	*	transformed position in the target's coordinate space. Effectively the same as using the following code with
	*	{{#crossLink "DisplayObject/localToGlobal"}}{{/crossLink}} and {{#crossLink "DisplayObject/globalToLocal"}}{{/crossLink}}.
	*	
	*	     var pt = this.localToGlobal(x, y);
	*	     pt = target.globalToLocal(pt.x, pt.y);
	* @param x The x position in the source display object to transform.
	* @param y The y position on the source display object to transform.
	* @param target The target display object to which the coordinates will be transformed.
	* @param pt An object to copy the result into. If omitted a new Point object with x/y properties will be returned.
	*/
	public function localToLocal(x:Float, y:Float, target:DisplayObject, ?pt:Dynamic):Point;
	
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
	* @param pt An object to copy the result into. If omitted a new Point object with x/y properties will be returned.
	*/
	public function globalToLocal(x:Float, y:Float, ?pt:Dynamic):Point;
	
	/**
	* Use the {{#crossLink "DisplayObject/stage:property"}}{{/crossLink}} property instead.
	*/
	public function getStage():Stage;
	
	private function _applyFilters():Dynamic;
	
	private function _applyShadow(ctx:CanvasRenderingContext2D, shadow:Shadow):Dynamic;
	
	private function _cloneProps(o:DisplayObject):DisplayObject;
	
	private function _getBounds(matrix:Matrix2D, ignoreTransform:Bool):Rectangle;
	
	private function _getFilterBounds():Rectangle;
	
	private function _testHit(ctx:CanvasRenderingContext2D):Bool;
	
	private function _tick(evtObj:Dynamic):Dynamic;
	
	private function _transformBounds(bounds:Rectangle, matrix:Matrix2D, ignoreTransform:Bool):Rectangle;
	
}
