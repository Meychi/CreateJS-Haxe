package createjs.easeljs;

import js.html.CanvasRenderingContext2D;

/**
* A Container is a nestable display list that allows you to work with compound display elements. For  example you could
*	group arm, leg, torso and head {{#crossLink "Bitmap"}}{{/crossLink}} instances together into a Person Container, and
*	transform them as a group, while still being able to move the individual parts relative to each other. Children of
*	containers have their <code>transform</code> and <code>alpha</code> properties concatenated with their parent
*	Container.
*	
*	For example, a {{#crossLink "Shape"}}{{/crossLink}} with x=100 and alpha=0.5, placed in a Container with <code>x=50</code>
*	and <code>alpha=0.7</code> will be rendered to the canvas at <code>x=150</code> and <code>alpha=0.35</code>.
*	Containers have some overhead, so you generally shouldn't create a Container to hold a single child.
*	
*	<h4>Example</h4>
*	
*	     var container = new createjs.Container();
*	     container.addChild(bitmapInstance, shapeInstance);
*	     container.x = 100;
*/
@:native("createjs.Container")
extern class Container extends DisplayObject
{
	/**
	* If false, the tick will not be propagated to children of this Container. This can provide some performance benefits. In addition to preventing the "tick" event from being dispatched, it will also prevent tick related updates on some display objects (ex. Sprite & MovieClip frame advancing, DOMElement visibility handling).
	*/
	public var tickChildren:Bool;
	
	/**
	* Indicates whether the children of this container are independently enabled for mouse/pointer interaction. If false, the children will be aggregated under the container - for example, a click on a child shape would trigger a click event on the container.
	*/
	public var mouseChildren:Bool;
	
	/**
	* Returns the number of children in the container.
	*/
	public var numChildren:Float;
	
	/**
	* The array of children in the display list. You should usually use the child management methods such as {{#crossLink "Container/addChild"}}{{/crossLink}}, {{#crossLink "Container/removeChild"}}{{/crossLink}}, {{#crossLink "Container/swapChildren"}}{{/crossLink}}, etc, rather than accessing this directly, but it is included for advanced uses.
	*/
	public var children:Array<Dynamic>;
	
	/**
	* A Container is a nestable display list that allows you to work with compound display elements. For  example you could
	*	group arm, leg, torso and head {{#crossLink "Bitmap"}}{{/crossLink}} instances together into a Person Container, and
	*	transform them as a group, while still being able to move the individual parts relative to each other. Children of
	*	containers have their <code>transform</code> and <code>alpha</code> properties concatenated with their parent
	*	Container.
	*	
	*	For example, a {{#crossLink "Shape"}}{{/crossLink}} with x=100 and alpha=0.5, placed in a Container with <code>x=50</code>
	*	and <code>alpha=0.7</code> will be rendered to the canvas at <code>x=150</code> and <code>alpha=0.35</code>.
	*	Containers have some overhead, so you generally shouldn't create a Container to hold a single child.
	*	
	*	<h4>Example</h4>
	*	
	*	     var container = new createjs.Container();
	*	     container.addChild(bitmapInstance, shapeInstance);
	*	     container.x = 100;
	*/
	public function new():Void;
	
	/**
	* Adds a child to the display list at the specified index, bumping children at equal or greater indexes up one, and
	*	setting its parent to this Container.
	*	
	*	<h4>Example</h4>
	*	
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
	public function addChildAt(child:DisplayObject, index:Float):DisplayObject;
	
	/**
	* Adds a child to the top of the display list.
	*	
	*	<h4>Example</h4>
	*	
	*			container.addChild(bitmapInstance);
	*	
	*	You can also add multiple children at once:
	*	
	*			container.addChild(bitmapInstance, shapeInstance, textInstance);
	* @param child The display object to add.
	*/
	public function addChild(child:DisplayObject):DisplayObject;
	
	/**
	* Changes the depth of the specified child. Fails silently if the child is not a child of this container, or the index is out of range.
	* @param child 
	* @param index 
	*/
	public function setChildIndex(child:DisplayObject, index:Float):Dynamic;
	
	/**
	* Constructor alias for backwards compatibility. This method will be removed in future versions.
	*	Subclasses should be updated to use {{#crossLink "Utility Methods/extends"}}{{/crossLink}}.
	*/
	public function initialize():Dynamic;
	
	/**
	* Draws the display object into the specified context ignoring its visible, alpha, shadow, and transform.
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
	* Performs an array sort operation on the child list.
	*	
	*	<h4>Example: Display children with a higher y in front.</h4>
	*	
	*	     var sortFunction = function(obj1, obj2, options) {
	*	         if (obj1.y > obj2.y) { return 1; }
	*	         if (obj1.y < obj2.y) { return -1; }
	*	         return 0;
	*	     }
	*	     container.sortChildren(sortFunction);
	* @param sortFunction the function to use to sort the child list. See JavaScript's <code>Array.sort</code>
	*	documentation for details.
	*/
	public function sortChildren(sortFunction:Dynamic):Dynamic;
	
	/**
	* Recursively clones all children of this container, and adds them to the target container.
	* @param o The target container.
	*/
	private function cloneChildren(o:Container):Dynamic;
	
	/**
	* Removes all children from the display list.
	*	
	*	<h4>Example</h4>
	*	
	*		container.removeAllChildren();
	*/
	public function removeAllChildren():Dynamic;
	
	/**
	* Removes the child at the specified index from the display list, and sets its parent to null.
	*	
	*	<h4>Example</h4>
	*	
	*	     container.removeChildAt(2);
	*	
	*	You can also remove multiple children:
	*	
	*	     container.removeChild(2, 7, ...)
	*	
	*	Returns true if the child (or children) was removed, or false if any index was out of range.
	* @param index The index of the child to remove.
	*/
	public function removeChildAt(index:Float):Bool;
	
	/**
	* Removes the specified child from the display list. Note that it is faster to use removeChildAt() if the index is
	*	already known.
	*	
	*	<h4>Example</h4>
	*	
	*	     container.removeChild(child);
	*	
	*	You can also remove multiple children:
	*	
	*	     removeChild(child1, child2, ...);
	*	
	*	Returns true if the child (or children) was removed, or false if it was not in the display list.
	* @param child The child to remove.
	*/
	public function removeChild(child:DisplayObject):Bool;
	
	/**
	* Returns a clone of this Container. Some properties that are specific to this instance's current context are
	*	reverted to their defaults (for example .parent).
	* @param recursive If true, all of the descendants of this container will be cloned recursively. If false, the
	*	properties of the container will be cloned, but the new instance will not have any children.
	*/
	//public function clone(?recursive:Bool):Container;
	
	/**
	* Returns a string representation of this object.
	*/
	//public function toString():String;
	
	/**
	* Returns an array of all display objects under the specified coordinates that are in this container's display
	*	list. This routine ignores any display objects with {{#crossLink "DisplayObject/mouseEnabled:property"}}{{/crossLink}}
	*	set to `false`. The array will be sorted in order of visual depth, with the top-most display object at index 0.
	*	This uses shape based hit detection, and can be an expensive operation to run, so it is best to use it carefully.
	*	For example, if testing for objects under the mouse, test on tick (instead of on {{#crossLink "DisplayObject/mousemove:event"}}{{/crossLink}}),
	*	and only if the mouse's position has changed.
	*	
	*	<ul>
	*	    <li>By default (mode=0) this method evaluates all display objects.</li>
	*	    <li>By setting the `mode` parameter to `1`, the {{#crossLink "DisplayObject/mouseEnabled:property"}}{{/crossLink}}
	*			and {{#crossLink "mouseChildren:property"}}{{/crossLink}} properties will be respected.</li>
	*		   <li>Setting the `mode` to `2` additionally excludes display objects that do not have active mouse event
	*		   	listeners or a {{#crossLink "DisplayObject:cursor:property"}}{{/crossLink}} property. That is, only objects
	*		   	that would normally intercept mouse interaction will be included. This can significantly improve performance
	*		   	in some cases by reducing the number of display objects that need to be tested.</li>
	*	</li>
	*	
	*	This method accounts for both {{#crossLink "DisplayObject/hitArea:property"}}{{/crossLink}} and {{#crossLink "DisplayObject/mask:property"}}{{/crossLink}}.
	* @param x The x position in the container to test.
	* @param y The y position in the container to test.
	* @param mode The mode to use to determine which display objects to include. 0-all, 1-respect mouseEnabled/mouseChildren, 2-only mouse opaque objects.
	*/
	public function getObjectsUnderPoint(x:Float, y:Float, ?mode:Float):Array<Dynamic>;
	
	/**
	* Returns the child at the specified index.
	*	
	*	<h4>Example</h4>
	*	
	*	     container.getChildAt(2);
	* @param index The index of the child to return.
	*/
	public function getChildAt(index:Float):DisplayObject;
	
	/**
	* Returns the child with the specified name.
	* @param name The name of the child to return.
	*/
	public function getChildByName(name:String):DisplayObject;
	
	/**
	* Returns the index of the specified child in the display list, or -1 if it is not in the display list.
	*	
	*	<h4>Example</h4>
	*	
	*	     var index = container.getChildIndex(child);
	* @param child The child to return the index of.
	*/
	public function getChildIndex(child:DisplayObject):Float;
	
	/**
	* Returns true if the specified display object either is this container or is a descendent (child, grandchild, etc)
	*	of this container.
	* @param child The DisplayObject to be checked.
	*/
	public function contains(child:DisplayObject):Bool;
	
	/**
	* Returns true or false indicating whether the display object would be visible if drawn to a canvas.
	*	This does not account for whether it would be visible within the boundaries of the stage.
	*	
	*	NOTE: This method is mainly for internal use, though it may be useful for advanced uses.
	*/
	//public function isVisible():Bool;
	
	/**
	* Similar to {{#crossLink "Container/getObjectsUnderPoint"}}{{/crossLink}}, but returns only the top-most display
	*	object. This runs significantly faster than <code>getObjectsUnderPoint()</code>, but is still potentially an expensive
	*	operation. See {{#crossLink "Container/getObjectsUnderPoint"}}{{/crossLink}} for more information.
	* @param x The x position in the container to test.
	* @param y The y position in the container to test.
	* @param mode The mode to use to determine which display objects to include.  0-all, 1-respect mouseEnabled/mouseChildren, 2-only mouse opaque objects.
	*/
	public function getObjectUnderPoint(x:Float, y:Float, mode:Float):DisplayObject;
	
	/**
	* Swaps the children at the specified indexes. Fails silently if either index is out of range.
	* @param index1 
	* @param index2 
	*/
	public function swapChildrenAt(index1:Float, index2:Float):Dynamic;
	
	/**
	* Swaps the specified children's depth in the display list. Fails silently if either child is not a child of this
	*	Container.
	* @param child1 
	* @param child2 
	*/
	public function swapChildren(child1:DisplayObject, child2:DisplayObject):Dynamic;
	
	/**
	* Tests whether the display object intersects the specified local point (ie. draws a pixel with alpha > 0 at the
	*	specified position). This ignores the alpha, shadow and compositeOperation of the display object, and all
	*	transform properties including regX/Y.
	* @param x The x position to check in the display object's local coordinates.
	* @param y The y position to check in the display object's local coordinates.
	*/
	//public function hitTest(x:Float, y:Float):Bool;
	
	/**
	* Use the {{#crossLink "Container/numChildren:property"}}{{/crossLink}} property instead.
	*/
	public function getNumChildren():Float;
	
	//private function _getBounds(matrix:Matrix2D, ignoreTransform:Bool):Rectangle;
	
	//private function _tick(evtObj:Dynamic):Dynamic;
	
	private function _getObjectsUnderPoint(x:Float, y:Float, arr:Array<Dynamic>, mouse:Bool, activeListener:Bool, currentDepth:Float):DisplayObject;
	
	private function _testMask(target:DisplayObject, x:Float, y:Float):Bool;
	
}
